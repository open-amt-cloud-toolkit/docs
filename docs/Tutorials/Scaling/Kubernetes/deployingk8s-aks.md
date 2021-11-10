--8<-- "References/abbreviations.md"

# Azure Kubernetes Service (AKS)

This tutorial demonstrates how to deploy the Open AMT Cloud Toolkit on a Kubernetes cluster using AKS. Alternatively, you can also perform a simpler, test deployment using a single-node cluster locally. See [Kubernetes (K8s)](./deployingk8s.md).

Azure Kubernetes Service (AKS) offers serverless Kubernetes, an integrated continuous integration and continuous delivery (CI/CD) experience, and enterprise-grade security and governance. Learn more about AKS [here](https://docs.microsoft.com/en-us/azure/aks/).

## Prerequisites

- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Azure CLI (v2.24.0+)](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Helm CLI (v3.5+)](https://helm.sh/)
- [PSQL CLI (11.13)](https://www.postgresql.org/download/)

## Get the Toolkit

1. Clone the Open AMT Cloud Toolkit.

    ```
    git clone --recursive https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit --branch v{{ repoVersion.oamtct }}
    ```

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

2. Provide a name and region to create a new resource group.

    ``` bash
    az group create --name <your-resource-group-name> --location <region>
    ```

3. Provide the name of your new resource group from the last step and start a deployment at that resource group based on `aks.json` in the `./open-amt-cloud-toolkit` directory.

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

    !!! important "Important - Using Strong Passwords"
        The password must meet standard, **strong** password requirements:

        - 8 to 32 characters
        - One uppercase, one lowercase, one numerical digit, one special character

### 5. Database connection strings


1. Configure the database connection strings used by MPS, RPS, and MPS Router.  


    Where:

    - **&lt;USERNAME&gt;** is the full username for the Postgres database (Ex: `<postgres-username>@<your-cluster-name>-sql`).
    - **&lt;PASSWORD&gt;** is the password for the Postgres database.
    - **&lt;SERVERURL&gt;** is the url for the Azure-hosted Postgres database (Ex: `<your-cluster-name>-sql.postgres.database.azure.com`).

2. Create RPS connection string secret.

    ```
    kubectl create secret generic rps --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/rpsdb?sslmode=require
    ```

3. Create MPS Router connection string secret.

    ```
    kubectl create secret generic mpsrouter --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/mpsdb?sslmode=require
    ```

4. Create MPS connection string secret.   

    ```
    kubectl create secret generic mps --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/mpsdb?sslmode=require
    ```



## Update Configuration

### Edit values.yaml

1. Open the `values.yaml` file in `./open-amt-cloud-toolkit/kubernetes/charts/`.

2. Update the `service.beta.kubernetes.io/azure-dns-label-name` key in the **kong** section with the desired subdomain name for your URL you would like for your cluster (i.e. myopenamtk8s).

    ``` yaml hl_lines="4"
    kong:
      proxy:
        annotations:
          service.beta.kubernetes.io/azure-dns-label-name: "<your-subdomain-name>"
    ```

3. Update the *mps*, *rps*, *webui*, and *mpsrouter* keys to point to your own container registries.

    ```yaml hl_lines="2-5"
    images:
        mps: "vprodemo.azurecr.io/mps:latest"
        rps: "vprodemo.azurecr.io/rps:latest"
        webui: "vprodemo.azurecr.io/webui:latest"
        mpsrouter: "vprodemo.azurecr.io/mpsrouter:latest"
    ```

4. Update the following keys in the `mps` section.

    | Key Name | Update to | Description |
    | -------------     | ------------------    | ------------ |
    | commonName        | FQDN for your cluster | For AKS, the format is `<your-subdomain-name>.<location>.cloudapp.azure.com`. This is the `fqdnSuffix` provided in the `outputs` section when you [Deploy AKS](#deploy-aks). |


    ``` yaml hl_lines="2"
    mps:
        commonName: "<your-subdomain-name>.<location>.cloudapp.azure.com"
        replicaCount: 1
        logLevel: "silly"
        jwtExpiration: 1440
    ```


5. Save and close the file.

## Create Databases and Schema 

### Enable Access to Database

1. Navigate to `Home > Resource Groups > Resource Group Name` using Microsoft Azure via online.

2. Select the Postgres DB. It will have a Type of `Azure Database for PostgreSQL Server`.

3. Under Settings in the left-hand menu, select **Connection Security**.

4. Under Firewall rules, select **Add current client IP address**.

5. Select Save.

6. Under the Overview tab, take note of the 'Server name' and 'Admin username'. They will be needed in the next steps.

    !!! note
        Remember to delete this firewall rule when finished.

### Create Databases

1. Use the database schema files to initialize the hosted Postgres DB in the following steps.

    Where:

    - **&lt;HOST&gt;** is the location of the Postgres database (Ex: `<your-cluster-name>-sql.postgres.database.azure.com`).
    - **&lt;USERNAME&gt;** is the admin username for the Postgres database (Ex: `<postgres-username>@<your-cluster-name>-sql`).

2. Create the RPS database.

    ```
    psql -h <HOST> -p 5432 -d postgres -U <USERNAME> -W -c "CREATE DATABASE rpsdb"
    ```

3. Create tables for the new 'rpsdb' database.

    ```
    psql -h <HOST> -p 5432 -d rpsdb -U <USERNAME> -W -f ./open-amt-cloud-toolkit/data/init.sql
    ```

4. Create the MPS database.

    ```
    psql -h <HOST> -p 5432 -d postgres -U <USERNAME> -W -f ./open-amt-cloud-toolkit/data/initMPS.sql
    ```

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
        ``` hl_lines="2 5 7"
        NAME                                                 READY   STATUS                       RESTARTS   AGE
        mps-69786bfb47-92mpc                                 0/1     CreateContainerConfigError   0          2m6s
        mpsrouter-9b9bc499b-2tkb2                            1/1     Running                      0          2m6s
        openamtstack-kong-68d6c84bcc-fp8dl                   2/2     Running                      0          2m6s
        openamtstack-vault-0                                 0/1     Running                      0          2m6s
        openamtstack-vault-agent-injector-6b564845db-zss78   1/1     Running                      0          2m6s
        rps-79877bf5c5-dsg5p                                 0/1     CreateContainerConfigError   0          2m6s
        webui-6cc48f4d68-6r8b5                               1/1     Running                      0          2m6s
        ```

## Initialize and Unseal Vault

!!! danger - "Danger - Download and Save Vault Keys"
    **Make sure to download your Vault credentials** and save them in a secure location when unsealing Vault.  If the keys are lost, a new Vault will need to be started and any stored data will be lost.

!!! tip "Tip - Finding the Vault UI External IP Address"
        The external IP of your Vault UI service can be found by running:

        ```
        kubectl get services openamtstack-vault-ui
        ```

1. Please refer to HashiCorp documentation on how to [Initialize and unseal Vault](https://learn.hashicorp.com/tutorials/vault/kubernetes-azure-aks?in=vault/kubernetes#initialize-and-unseal-vault). **Stop and return here after signing in to Vault with the `root_token`.**

2. After initializing and unsealing the vault, you need to enable the Key Value engine.

3. Click **Enable New Engine +**.

4. Choose **KV**.

5. Click **Next**.

6. Leave the default path and choose **version 2** from the drop down. 

7. Click **Enable Engine**.
  
### Vault Token Secret

1. Add the root token as a secret to the AKS cluster so that the services can access Vault.

    ```
    kubectl create secret generic vault --from-literal=vaultKey=<your-root-token>
    ```

    Where:

    - **&lt;your-root-token&gt;** is your `root_token` generated by Vault.

2. View the pods. All pods should now be Ready and Running.

    ```
    kubectl get pods
    ```

    !!! success
        ```
        NAME                                                 READY   STATUS      RESTARTS   AGE
        mps-69786bfb47-92mpc                                 1/1     Running     0          4m5s
        mpsrouter-9b9bc499b-2tkb2                            1/1     Running     0          4m5s
        openamtstack-kong-68d6c84bcc-fp8dl                   2/2     Running     0          4m5s
        openamtstack-vault-0                                 1/1     Running     0          4m5s
        openamtstack-vault-agent-injector-6b564845db-zss78   1/1     Running     0          4m5s
        rps-79877bf5c5-dsg5p                                 1/1     Running     0          4m5s
        webui-6cc48f4d68-6r8b5                               1/1     Running     0          4m5s
        ```

## Next Steps

Visit the Sample Web UI using the FQDN name and [**Continue from the Get Started steps**](../../../GetStarted/loginToUI.md)

