--8<-- "References/abbreviations.md"

This tutorial demonstrates how to deploy the Open AMT Cloud Toolkit on a local Kubernetes single-node cluster. Alternatively, you can also deploy using a managed service through a Cloud Service Provider such as Azure Kubernetes Service (AKS). See [AKS](./deployingk8s-aks.md).

Kubernetes, also known as K8s, is an open-source system for automating deployment, scaling, and management of containerized applications.  Learn more about Kubernetes [here](https://kubernetes.io/docs/home/).


## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop) with [Kubernetes Enabled](https://docs.docker.com/desktop/kubernetes/)

    !!!important "Important - For Linux"
        If deploying on a Linux machine, Docker Desktop is not available. You must use Docker Engine alongside a local Kubernetes cluster tool such as [minikube](https://minikube.sigs.k8s.io/docs/) or [kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/).

- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm CLI (v3.5+)](https://helm.sh/)
- PostgreSQL Docker Container or [Local PostgreSQL server](https://www.postgresql.org/download/)

    !!!note "Note - Database Required"
        This guide requires a standalone database for storage. This can be done either as a Docker container or as a local Postgres server on your local IP. For production, a managed database instance, either by a cloud service provider or your enterprise IT, is highly recommended.

    
    ??? note "Optional - How to Set up local PostgreSQL DB using Docker"
    
        ### Build and Start
    
        1. Clone the Open AMT Cloud Toolkit.

            ```
            git clone https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit --branch v{{ repoVersion.oamtct }}
            ```
    
        2. Copy the `.env.template` file to `.env`.

            === "Windows (Cmd Prompt)"
                ```
                copy .env.template .env
                ```

            === "Linux/Powershell"
                ```
                cp .env.template .env
                ```

        3. Set the POSTGRES_USER and POSTGRES_PASSWORD to the credentials you want.

        4. Build and start the container.

            ```
            docker-compose  -f "docker-compose.yml" up -d db
            ```

        5. Continue from [Create Kubernetes Secrets](#create-kubernetes-secrets).


    ??? note "Optional (Not Recommended) - How to Set up Local PostgreSQL server on local IP Address"
    
        ### Download and Configure
    
        1. [Download and Install PostgreSQL](https://www.postgresql.org/download/). You may have to add `.\bin` and `.\lib` to your PATH on Windows.
    
        2. Open the `pg_hba.conf` file under `.\PostgreSQL\14\data`.
    
        3. Add your device's IP Address under **IPv4 local connections**.
    
            ???+ example "Example - pg_hba.conf File"
    
                ``` hl_lines="7"
    
                # TYPE  DATABASE        USER            ADDRESS                 METHOD
    
                # "local" is for Unix domain socket connections only
                local   all             all                                             scram-sha-256
                # IPv4 local connections:
                host    all             all             127.0.0.1/32                    scram-sha-256
                host    all             all             <Your-IP-Address>/24            scram-sha-256
                # IPv6 local connections:
                host    all             all             ::1/128                         scram-sha-256
                # Allow replication connections from localhost, by a user with the
                # replication privilege.
                local   replication     all                                             scram-sha-256
                host    replication     all             127.0.0.1/32                    scram-sha-256
                host    replication     all             ::1/128                         scram-sha-256
                ```
    
        4. Reload the configuration file to use the updated values.
    
            ```
            psql -U <user> -p 5432 -c "SELECT pg_reload_conf();"
            ```
    
        5. **From here, use your IP Address as the &lt;SERVERURL&gt;. DO NOT use localhost or 127.0.0.1. **

## Get the Toolkit

1. Clone the Open AMT Cloud Toolkit.

    ```
    git clone https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit --branch v{{ repoVersion.oamtct }}
    ```


## Create Kubernetes Secrets 

### 1. Private Docker Registry Credentials

**If you are using a private docker registry**, you'll need to provide your credentials to K8S. 

```
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

    - **&lt;USERNAME&gt;** is the username for the Postgres database.
    - **&lt;PASSWORD&gt;** is the password for the Postgres database.
    - **&lt;SERVERURL&gt;** is the loction for the Postgres database.

    !!! warning "Warning - Using an SSL Connection"
        This tutorial uses the connection string setting of 'no-verify' for ease of setup. **For production, it is recommended to use a SSL connection.**

2. Create RPS connection string secret.

    ```
    kubectl create secret generic rps --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/rpsdb?sslmode=no-verify
    ```

3. Create MPS Router connection string secret.

    ```
    kubectl create secret generic mpsrouter --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/mpsdb?sslmode=disable
    ```

4. Create MPS connection string secret.   

    ```
    kubectl create secret generic mps --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/mpsdb?sslmode=no-verify
    ```

## Update Configuration

### Edit values.yaml

1. Open the `values.yaml` file in `./open-amt-cloud-toolkit/kubernetes/charts/`.

2. Update the *mps*, *rps*, *webui*, and *mpsrouter* keys to point to your own container registries.

    ```yaml hl_lines="2-5"
    images:
        mps: "vprodemo.azurecr.io/mps:latest"
        rps: "vprodemo.azurecr.io/rps:latest"
        webui: "vprodemo.azurecr.io/webui:latest"
        mpsrouter: "vprodemo.azurecr.io/mpsrouter:latest"
    ```

3. Update the `commonName` key in the **mps** section with the IP Address of your development device.

    ``` yaml hl_lines="2"
    mps:
        commonName: "<your-ip-address>"
        replicaCount: 1
        logLevel: "silly"
        jwtExpiration: 1440
    ```

4. Save and close the file.

## Create Databases and Schema 

1. Use the database schema files to initialize the hosted Postgres DB in the following steps.

    Where:

    - **&lt;SERVERURL&gt;** is the location of the Postgres database.
    - **&lt;USERNAME&gt;** is the username for the Postgres database.

2. Create the RPS database.

    ```
    psql -h <SERVERURL> -p 5432 -d postgres -U <USERNAME> -W -c "CREATE DATABASE rpsdb"
    ```

3. Create tables for the new 'rpsdb'.

    ```
    psql -h <SERVERURL> -p 5432 -d rpsdb -U <USERNAME> -W -f ./data/init.sql
    ```

4. Create the MPS database.

    ```
    psql -h <SERVERURL> -p 5432 -d postgres -U <USERNAME> -W -f ./data/initMPS.sql
    ```

## Deploy Open AMT Cloud Toolkit Using Helm

1. Deploy using Helm.
    ```
    helm install openamtstack ./kubernetes/charts
    ```

    !!! success
        ```
        NAME: openamtstack
        LAST DEPLOYED: Wed Jul 14 12:59:29 2021
        NAMESPACE: default
        STATUS: deployed
        REVISION: 1
        TEST SUITE: None
        ```

3. View the pods. You might notice `openamtstack-vault-0` is not ready. This will change after we initialize and unseal Vault. MPS and RPS will both have a status of CreateContainerConfigError until Vault is Ready.
    ```
    kubectl get pods
    ```

    !!! success
        ``` hl_lines="5"
        NAME                                                 READY   STATUS                       RESTARTS   AGE
        mps-6984b7c69d-8d5gf                                 0/1     CreateContainerConfigError   0          5m
        mpsrouter-9b9bc499b-pwn9j                            1/1     Running                      0          5m
        openamtstack-kong-55b65d558c-gzv4d                   2/2     Running                      0          5m
        openamtstack-vault-0                                 0/1     Running                      0          5m
        openamtstack-vault-agent-injector-7fb7dcfcbd-dlqqg   1/1     Running                      0          5m
        rps-79877bf5c5-hnv8t                                 0/1     CreateContainerConfigError   0          5m
        webui-784cd49976-bj7z5                               1/1     Running                      0          5m
        ```

## Initialize and Unseal Vault

!!! danger - "Danger - Download and Save Vault Keys"
    **Make sure to download your Vault credentials** and save them in a secure location when unsealing Vault.  If the keys are lost, a new Vault will need to be started and any stored data will be lost.

1. Connect to the Vault UI using a web browser.

    ```
    http://localhost:8200
    ```

    !!!note "Troubleshoot - Vault UI External IP"
        If you cannot connect, verify the External IP Address by running:
        ```
        kubectl get services openamtstack-vault-ui
        ```

2. Please refer to HashiCorp documentation on how to [Initialize and unseal Vault](https://learn.hashicorp.com/tutorials/vault/kubernetes-azure-aks?in=vault/kubernetes#initialize-and-unseal-vault). **Stop and return here after signing in to Vault with the `root_token`.**

3. After initializing and unsealing the vault, you need to enable the Key Value engine.

4. Click **Enable New Engine +**.

5. Choose **KV**.

6. Click **Next**.

7. Click **Enable Engine**.
  
### Vault Token Secret

1. Add the root token as a secret to the k8s cluster so that the services can access Vault.

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
        NAME                                                 READY   STATUS    RESTARTS   AGE
        mps-6984b7c69d-8d5gf                                 1/1     Running   0          7m
        mpsrouter-9b9bc499b-pwn9j                            1/1     Running   0          7m
        openamtstack-kong-55b65d558c-gzv4d                   2/2     Running   0          7m
        openamtstack-vault-0                                 1/1     Running   0          7m
        openamtstack-vault-agent-injector-7fb7dcfcbd-dlqqg   1/1     Running   0          7m
        rps-79877bf5c5-hnv8t                                 1/1     Running   0          7m
        webui-784cd49976-bj7z5                               1/1     Running   0          7m
        ```

## Next Steps

[**Continue from the Get Started steps**](../../../GetStarted/loginToUI.md)
