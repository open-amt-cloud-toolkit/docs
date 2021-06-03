--8<-- "References/abbreviations.md"
## Prerequisites

- Docker Desktop w/ kubectl
- Azure CLI (v2.24.0+)
- Helm CLI (v3.5+)

## Create SSH Key
```
ssh-keygen -t rsa -b 2048
```
Note the location as you will need the public key (`.pub` file) in the next step. 

## Deploy AKS

Login using `az login` if you haven't already and make sure the correct subscription is set as default using `az account set`
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

If you are using a private docker registry, you'll need to provide your credentials to K8S. 
```
kubectl create secret docker-registry registrycredentials --docker-server=<your-registry-server> 
--docker-username=<your-username> 
--docker-password=<your-password>
```

Additionally, you'll need to provide secrets for the following:

MPS/KONG JWT:

```
kubectl create secret generic open-amt-admin-jwt --from-literal=kongCredType=jwt --from-literal=key="admin-issuer" --from-literal=algorithm=HS256 --from-literal=secret="<your-secret>"
```
KONG ACL for JWT:
```
kubectl create secret generic open-amt-admin-acl --from-literal=kongCredType=acl --from-literal=group=open-amt-admin
```

MPS Web Username and Password:
```
kubectl create secret generic mpsweb --from-literal=user=<your-username> --from-literal=password=<your-password>
```

MPS Username and Password:
```
kubectl create secret generic mps --from-literal=user=<your-username> --from-literal=password<your-password>
```


## Update Configuration

Update the `kong:` section in the `values.yaml` file with the desired dns name you would like for your cluster (i.e. myopenamtk8s):

``` yaml
kong:
  proxy:
    annotations:
      service.beta.kubernetes.io/azure-dns-label-name: "<your-domain-name>"
```

Next, update the `commonName:` key in the `mps:` section in the `values.yaml` file with the FQDN for your cluster. For AKS, the format is `<your-domain-name>.<location>.cloudapp.azure.com`. This is value provided in the "outputs" section when you [Deploy AKS](#deploy-aks).

``` yaml
mps:
  commonName: "<your-domain-name>.<location>.cloudapp.azure.com"
```

## Deploy Open AMT Cloud Toolkit using Helm

Navigate to `./kubernetes` and deploy using Helm 
```
helm install openamtstack ./charts
```

## Initialize and Unseal Vault

Use the following instructions to initialize unseal and vault:  [https://learn.hashicorp.com/tutorials/vault/kubernetes-azure-aks?in=vault/kubernetes#initialize-and-unseal-vault](https://learn.hashicorp.com/tutorials/vault/kubernetes-azure-aks?in=vault/kubernetes#initialize-and-unseal-vault)


!!! important 
    Make sure you download your credentials and save them in a secure location.

After initializing and unsealing the vault, you need to enable the Key Value engine.
To do this:

  1. Click "Enable New Engine +"
  2. Choose "KV"
  3. Click "Next"
  4. Leave the default path and choose version 2 from the drop down. 
  5. Click "Enable Engine"

Once you have your vault token, we'll add the root token as a secret to the k8s cluster so the services can access it.

Vault Token:
```
kubectl create secret generic vault --from-literal=vaultKey=<your-root-token>
```

## Next Steps

Visit the portal using the FQDN name and continue from getting started steps [here](https://open-amt-cloud-toolkit.github.io/docs/1.3/General/loginToRPS/)

