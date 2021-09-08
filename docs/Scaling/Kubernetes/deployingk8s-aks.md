--8<-- "References/abbreviations.md"

# Azure Kubernetes Service (AKS)

This tutorial demonstrates how to deploy the Open AMT Cloud Toolkit on a Kubernetes cluster using AKS. Alternatively, you can also perform a simpler, test deployment using a single-node cluster locally. See [Kubernetes (K8s)](./deployingk8s.md).

Azure Kubernetes Service (AKS) offers serverless Kubernetes, an integrated continuous integration and continuous delivery (CI/CD) experience, and enterprise-grade security and governance. Learn more about AKS [here](https://docs.microsoft.com/en-us/azure/aks/).

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Azure CLI (v2.24.0+)](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Helm CLI (v3.5+)](https://helm.sh/)
- [PSQL CLI (11.13)](https://www.postgresql.org/download/)

## Create SSH Key
This key is required by Azure to create VMs that use SSH keys for authentication. For more details, see [Detailed steps: Create and manage SSH keys](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-ssh-keys-detailed).

1. Create a new ssh key.

    ```
    ssh-keygen -t rsa -b 2048
    ```

2. Take note of the location it was saved at. You will need the public key (`.pub` file) in a following step. 

## Deploy AKS

1. Login to Azure.
  ```
  az login
  ``` 

    Additionally, you can verify the correct subscription is set.
    ```
    az account show
    ```

2. Provide a name to create a new resource group.

    ``` bash
    az group create --name <your-resource-group-name> --location eastus
    ```

3. Provide the name of your new resource group from the last step and start a deployment at that resource group based on `aks.json`.

    ```
    az deployment group create --resource-group <your-resource-group-name> --template-file aks.json
    ```

4. After running the previous command, you will be prompted for 3 different strings. After the final prompt, it will take about 5 minutes to finish running.
    - Provide a name for the AKS Cluster.
    - Provide a name (e.g. your name) for the linux user admin name.
    - Provide the string of the ssh key from the `.pub` file.

5. Take note of the `fqdnSuffix` in the `outputs` section of the JSON response (e.g. `eastus.cloudapp.azure.com`)

    ```json hl_lines="8"
    "outputs": {
      "controlPlaneFQDN": {
        "type": "String",
        "value": "bwcluster-9c68035a.hcp.westus.azmk8s.io"
      },
      "fqdnSuffix": {
        "type": "String",
        "value": "eastus.cloudapp.azure.com"
      }
    },
    ```

## Connect to AKS Instance

Ensure your `kubectl` is connected to the Kubernetes cluster you wish to deploy/manage.

1. Provide your resource group name and cluster name, respectively.

    ```
    az aks get-credentials --resource-group <your-resource-group-name> --name <your-cluster-name>
    ```

## Create Secrets 

### 1. Private Docker Registry Credentials

If you are using a private docker registry, you'll need to provide your credentials to K8S. 
``` bash
kubectl create secret docker-registry registrycredentials --docker-server=<your-registry-server> --docker-username=<your-username> --docker-password=<your-password>
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


### 5. Azure Storage Account Key 
Currently, we leverage Azure Storage Accounts for persistent storage of MPS certificates that can be shared by multiple instances of MPS. This creates the secret to access the provisioned Azure Storage account for use in a persistent volume (PV).

!!! note 
    This will likely change in a future release

```
kubectl create secret generic azure-secret --from-literal=azurestorageaccountname=<your-cluster-name>stg --from-literal=azurestorageaccountkey=<your-storage-key>
```

Where:

- **&lt;your-cluster-name&gt;** is the cluster name chosen in [Deploy AKS](#deploy-aks).
- **&lt;your-storage-key&gt;** is one of the generated access keys of the storage account.

    !!! important "Important - Finding Access Keys"
        An access key can be found by either:

        - Run `az storage account keys list --account-name <your-cluster-name>stg` to view access keys.

        - Navigate to `Home > Storage accounts > cluster-name > Access keys` using Microsoft Azure via online.

### 6. Database connection strings

Configure the database connection strings used by MPS, RPS, and MPS Router.

```
kubectl create secret generic rps --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/rpsdb?sslmode=require
```

```
kubectl create secret generic mpsrouter --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/mpsdb?sslmode=require
```

```
kubectl create secret generic mps --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/mpsdb?sslmode=require
```

Where:

- **&lt;USERNAME&gt;** username for the postgres database in the form of &lt;USERNAME&gt;@&lt;your-cluster-name&gt;-sql
- **&lt;PASSWORD&gt;** password for the postgres database.
- **&lt;SERVERURL&gt;** url for the Azure hosted postgres database in the form of &lt;your-cluster-name&gt;-sql.postgres.database.azure.com.

## Update Configuration

1. Open the `values.yaml` file in `./open-amt-cloud-toolkit/kubernetes/charts/`.

2. Update the *service.beta.kubernetes.io/azure-dns-label-name* key in the `kong:` section with the desired DNS name you would like for your cluster (i.e. myopenamtk8s).

    ``` yaml hl_lines="4"
    kong:
      proxy:
        annotations:
          service.beta.kubernetes.io/azure-dns-label-name: "<your-domain-name>"
    ```

3. Update the *mps*, *rps*, *webui*, and *mpsrouter* keys to point to your own container registries.

    ```yaml hl_lines="2-5"
    images:
        mps: "vprodemo.azurecr.io/mps:latest"
        rps: "vprodemo.azurecr.io/rps:latest"
        webui: "vprodemo.azurecr.io/webui:latest"
        mpsrouter: "vprodemo.azurecr.io/mpsrouter:latest"
        postgresdb: "postgres:13"
    ```

4. Update the following keys in the `mps` section.

    | Key Name | Update to | Description |
    | -------------     | ------------------    | ------------ |
    | commonName        | FQDN for your cluster | For AKS, the format is `<your-domain-name>.<location>.cloudapp.azure.com`. This is the `fqdnSuffix` provided in the `outputs` section when you [Deploy AKS](#deploy-aks). |
    | storageAccessMode | ReadWriteMany         | Must set to `ReadWriteMany` to scale. The default access mode for storage (`storageAccessMode`) is set to `ReadWriteOnce`. This only works with a one node cluster. |


    ``` yaml hl_lines="2 4"
    mps:
        commonName: "<your-domain-name>.<location>.cloudapp.azure.com"
        # storageClassName: ""
        storageAccessMode: "ReadWriteOnce" #Change to ReadWriteMany
        replicaCount: 1
        logLevel: "silly"
        jwtExpiration: 1440
    ```


5. Save and close the file.

6. Provide a `PersistentVolume` that can match the `PersisentVolumeClaim` for MPS. For an AKS deployment, you can use the following example YAML. It is provided in `./kubernetes/charts/volumes/azure.yaml`.

    !!! note
        Changing storageAccessMode will update the PersistentVolumeClaim to request `ReadWriteMany`, this means you'll need to provide a `PersistentVolume` that can match that claim. The Azure deployment performed in [Deploy AKS](#deploy-aks) creates a Storage Account that can be used. Use the following yaml to provision the volume for the cluster.

    !!! example "Provided azure.yaml Example"
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

7. Apply it to your cluster.
    ```
    kubectl apply -f ./kubernetes/charts/volumes/azure.yaml
    ```
## Create database schema 
### Enable access to database

- Navigate to `Home > Resource Groups > Resource Group Name > Azure Database for PostgreSQL Server` using Microsoft Azure via online
- Settings -> Connection Security
- Under firewall rules, select 'add current client ip address'
- Select Save

- Under the general tab, take note of the 'server name' and 'admin username', they will be needed in the next step.

NOTE: Please remember to delete this firewall rule when finished.

### Create databases

Use the database schema files to initialize the hosted postgres db.

NOTE: The following commands will prompt for the database password.

```
psql -h <HOST> -p 5432 -d postgres -U <USERNAME> -W -c "CREATE DATABASE rpsdb"
```

```
psql -h <HOST> -p 5432 -d rpsdb -U <USERNAME> -W -f <SCRIPTLOCATION>\init.sql
```

```
psql -h <HOST> -p 5432 -d postgres -U <USERNAME> -W -f <SCRIPTLOCATION>\initMPS.sql
```

Where:

- **&lt;USERNAME&gt;** username for the postgres database in the form of &lt;USERNAME&gt;@&lt;your-cluster-name&gt;-sql
- **&lt;HOST&gt;** location of the postgres database in the form of &lt;your-cluster-name&gt;-sql.postgres.database.azure.com 
- **&lt;SCRIPTLOCATION&gt;** location of the sql scripts '\open-amt-cloud-toolkit\data'

## Deploy Open AMT Cloud Toolkit using Helm

1. Deploy using Helm.
    ```
    helm install openamtstack ./kubernetes/charts
    ```

    !!! success
        ```
        NAME: openamtstack
        LAST DEPLOYED: Thu Jul 15 11:17:38 2021
        NAMESPACE: default
        STATUS: deployed
        REVISION: 1
        TEST SUITE: None
        ```

2. View the pods. You might notice `mps`, `rps`, and `openamtstack-vault-0` are not ready. This will change after we initialize and unseal Vault. All others should be Ready and Running.
    ```
    kubectl get pods
    ```

    !!! success
        ``` hl_lines="2 6 8"
        NAME                                                 READY   STATUS                       RESTARTS   AGE
        mps-69786bfb47-92mpc                                 0/1     CreateContainerConfigError   0          2m6s
        mpsrouter-9b9bc499b-2tkb2                            1/1     Running                      0          2m6s
        oactdb-697b55f885-g6l58                              1/1     Running                      0          2m6s
        openamtstack-kong-68d6c84bcc-fp8dl                   2/2     Running                      0          2m6s
        openamtstack-vault-0                                 0/1     Running                      0          2m6s
        openamtstack-vault-agent-injector-6b564845db-zss78   1/1     Running                      0          2m6s
        rps-79877bf5c5-dsg5p                                 0/1     CreateContainerConfigError   0          2m6s
        webui-6cc48f4d68-6r8b5                               1/1     Running                      0          2m6s
        ```

## Initialize and Unseal Vault

1. Please refer to HashiCorp documentation on how to [Initialize and unseal Vault](https://learn.hashicorp.com/tutorials/vault/kubernetes-azure-aks?in=vault/kubernetes#initialize-and-unseal-vault).

    !!! important 
        Make sure you download your credentials and save them in a secure location.

    !!! note "Note - Finding the Vault UI External IP Address"
        The external IP of your Vault UI service can be found by either:

        - Run `kubectl get services` and view under the `openamtstack-vault-ui` service.

        - Navigate to `Home > Kubernetes services > cluster-name > Services and ingresses` using Microsoft Azure via online.

After initializing and unsealing the vault, you need to enable the Key Value engine:

1. Click "Enable New Engine +".

2. Choose "KV".

3. Click "Next".

4. Leave the default path and choose version 2 from the drop down. 

5. Click "Enable Engine".
  
### Vault Token Secret

1. Add the root token as a secret to the k8s cluster so that the services can access Vault.

    ```
    kubectl create secret generic vault --from-literal=vaultKey=<your-root-token>
    ```

    Where:

    - **&lt;your-root-token&gt;** is your *root_token* generated by Vault.

2. View the pods. All pods should now be Ready and Running.
    ```
    kubectl get pods
    ```

    !!! success
        ```
        NAME                                                 READY   STATUS      RESTARTS   AGE
        mps-69786bfb47-92mpc                                 1/1     Running     0          4m5s
        mpsrouter-9b9bc499b-2tkb2                            1/1     Running     0          4m5s
        oactdb-697b55f885-g6l58                              1/1     Running     0          4m5s
        openamtstack-kong-68d6c84bcc-fp8dl                   2/2     Running     0          4m5s
        openamtstack-vault-0                                 1/1     Running     0          4m5s
        openamtstack-vault-agent-injector-6b564845db-zss78   1/1     Running     0          4m5s
        rps-79877bf5c5-dsg5p                                 1/1     Running     0          4m5s
        webui-6cc48f4d68-6r8b5                               1/1     Running     0          4m5s
        ```

## Next Steps

Visit the Sample Web UI using the FQDN name and [**Continue from the Get Started steps**](../../General/loginToRPS.md)

