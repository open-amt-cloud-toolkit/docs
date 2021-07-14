--8<-- "References/abbreviations.md"

# Azure Kubernetes Service (AKS)

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- Azure CLI (v2.24.0+)
- [Helm CLI (v3.5+)](https://helm.sh/)

## Create SSH Key
This key is required by Azure to create VMs that use SSH keys for authentication. See [https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-ssh-keys-detailed](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-ssh-keys-detailed) for more details.

```
ssh-keygen -t rsa -b 2048
```
Note the location as you will need the public key (`.pub` file) in the next step. 

## Deploy AKS

Login using `az login` if you haven't already.
```
az login
``` 
Additionally, make sure the correct subscription is set as default using `az account set`
```
az account set
```

``` bash
az group create --name <your-resource-group-name> --location eastus
```

```
az deployment group create --resource-group <your-resource-group-name> --template-file aks.json
```
You will be prompted for a name for the AKS Cluster, the linux user admin name (i.e. your name), and the public key (`.pub` file) you generated in [Create SSH Key](#create-ssh-key). This takes about ~5 min. Note the `fqdnSuffix` in the "outputs" section of the JSON response (i.e. `westus2.cloudapp.azure.com`) when complete. This will be needed for the updating the commonName in the `values.yaml` file.

## Connect to AKS Instance

Ensure your `kubectl` is connected to the Kubernetes cluster you wish to deploy/manage. With AKS, use the following: 

```
az aks get-credentials --resource-group <your-resource-group-name> --name <your-cluster-name>
```

## Create Secrets 

### 1. Private Docker Registry Credentials

If you are using a private docker registry, you'll need to provide your credentials to K8S. 
``` bash
kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-username> --docker-password=<your-password>
```

Where:

- **&lt;your-registry-server&gt;** is your Private Docker Registry FQDN.
- **&lt;your-username&gt;** is your Docker username.
- **&lt;your-password&gt;** is your Docker password.

### 2. MPS/KONG JWT

This is the secret used for generating and verifying JWTs.
```
kubectl create secret generic open-amt-admin-jwt --from-literal=kongCredType=jwt --from-literal=key="admin-issuer" --from-literal=algorithm=HS256 --from-literal=secret="<your-secret>"
```

Where:

- **&lt;your-secret&gt;** is your chosen strong secret.

### 3. KONG ACL for JWT

This configures KONG with an Access Control List (ACL) to allow an admin user `open-amt-admin` to access endpoints using the JWT retrieved when logging in.
```
kubectl create secret generic open-amt-admin-acl --from-literal=kongCredType=acl --from-literal=group=open-amt-admin
```

### 4. MPS Web Username and Password
This is the username and password that is used for requesting a JWT. These credentials are also used for logging into the Sample Web UI.
```
kubectl create secret generic mpsweb --from-literal=user=<your-username> --from-literal=password=<your-password>
```

Where:

- **&lt;your-username&gt;** is a username of your choice.
- **&lt;your-password&gt;** is a strong password of your choice.

    !!! important
        The password must meet standard, **strong** password requirements:

        - 8 to 32 characters
        - One uppercase, one lowercase, one numerical digit, one special character


### Azure Storage Account Key 
Currently, we leverage Azure Storage Accounts for persistent storage of MPS certificates that can be shared by multiple instances of MPS. This creates the secret to access the provisioned Azure Storage account for use in a persistent volume (PV).

!!! note 
    This will likely change in a future release

```
kubectl create secret generic azure-secret --from-literal=azurestorageaccountname=<your-cluster-name>stg --from-literal=azurestorageaccountkey=<your-storage-key>
```


## Update Configuration

Update the `kong:` section in the `./kubernetes/charts/values.yaml` file with the desired dns name you would like for your cluster (i.e. myopenamtk8s):

``` yaml
kong:
  proxy:
    annotations:
      service.beta.kubernetes.io/azure-dns-label-name: "<your-domain-name>"
```

Next, update the `commonName:` key in the `mps:` section in the `values.yaml` file with the FQDN for your cluster. For AKS, the format is `<your-domain-name>.<location>.cloudapp.azure.com`. This is the `fqdnSuffix` provided in the "outputs" section when you [Deploy AKS](#deploy-aks).

``` yaml
mps:
  commonName: "<your-domain-name>.<location>.cloudapp.azure.com"
```

Lastly, the default access mode for storage (`storageAccessMode:`) is set to `ReadWriteOnce`. This only works with a one node cluster. You'll need to update this to `ReadWriteMany` to scale out the toolkit.

``` yaml
mps:
  storageAccessMode: "ReadWriteMany"
```

This will update the PersistentVolumeClaim to request `ReadWriteMany`, this means you'll need to provide a `PersistentVolume` that can match the claim. The Azure deployment performed in [Deploy AKS](#deploy-aks) creates a Storage Account that can be used. Use the following yaml to provision the volume for the cluster:

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mps-certs
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteMany
  azureFile:
    secretName: azure-secret
    secretNamespace: default
    shareName: mps-certs
    readOnly: false
  mountOptions:
  - dir_mode=0755
  - file_mode=0755
  - uid=1000
  - gid=1000
  - mfsymlinks
  - nobrl
```
This is provided in `./kubernetes/charts/volumes/azure.yaml` and can be applied to your cluster with 

```
kubectl apply -f ./kubernetes/charts/volumes/azure.yaml
```

## Deploy Open AMT Cloud Toolkit using Helm

Navigate to `./kubernetes` and deploy using Helm 
```
helm install openamtstack ./charts
```

## Initialize and Unseal Vault

1. Please refer to HashiCorp documentation on how to [Initialize and unseal Vault](https://learn.hashicorp.com/tutorials/vault/kubernetes-azure-aks?in=vault/kubernetes#initialize-and-unseal-vault).

    !!! important 
        Make sure you download your credentials and save them in a secure location.

After initializing and unsealing the vault, you need to enable the Key Value engine:

1. Click "Enable New Engine +".

2. Choose "KV".

3. Click "Next".

4. Leave the default path and choose version 2 from the drop down. 

5. Click "Enable Engine".
  
#### Vault Token Secret

1. Add the root token as a secret to the k8s cluster so that the services can access Vault.

    ```
    kubectl create secret generic vault --from-literal=vaultKey=<your-root-token>
    ```

    Where:

    - **&lt;your-root-token&gt;** is your *root_token* generated by Vault.

## Next Steps

Visit the portal using the FQDN name and [**Continue from the Get Started steps**](https://open-amt-cloud-toolkit.github.io/docs/1.4/General/loginToRPS/)

