--8<-- "References/abbreviations.md"

# Amazon Elastic Kubernetes Service (EKS)

This tutorial demonstrates how to deploy the Open AMT Cloud Toolkit on a Kubernetes cluster using EKS. To perform a simpler test deployment, use a single-mode cluster locally. See [Kubernetes (K8s)](./deployingk8s.md).

Amazon EKS offers serverless Kubernetes, an integrated continuous integration and continuous delivery (CI/CD) experience, and enterprise-grade security and governance. Learn more about EKS [here](https://aws.amazon.com/eks).

## Prerequisites

- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [AWS CLI](https://aws.amazon.com/cli/)
- [eksctl CLI](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html)
- [Helm CLI (v3.5+)](https://helm.sh/)
- [PSQL CLI (11.13)](https://www.postgresql.org/download/)


## Create a New EKS Cluster

1. Follow steps for [aws configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) to finish configuration of AWS CLI.


2. Follow steps to [Create a key pair using Amazon EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair) to create a SSH key for accessing the cluster.

3. Create a new EKS cluster and supporting components.

    ```
    eksctl create cluster --name <cluster-name> --region <region> --with-oidc --ssh-access --ssh-public-key <ssh-keypair-name> --managed
    ```

    Where:

    - **&lt;cluster-name&gt;** is the name of the new EKS cluster.
    - **&lt;region&gt;** is the AWS region to deploy the stack (Ex: `us-west-2`).
    - **&lt;ssh-keypair-name&gt;** is the name of the SSH key from the previous step.


## Create Postgres DB in RDS

1. Create a Postgres DB by following the steps for [Creating an Amazon RDS DB instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_CreateDBInstance.html).

    **Make sure to set the following configuration settings:**

    | Field                         | Set to | 
    | --------------------------    | ------------------      |
    | Virtual private cloud (VPC)   | Choose the VPC created from your cluster.  It should follow the format: 'eksctl-**&lt;cluster-name&gt;**-cluster/VPC' |
    | Public access                 | Yes. In the next steps, we will create Security rules to limit access.         |
    | VPC security group            | Choose existing         |
    | Existing VPC security groups  | default                 |


### Configure Virtual Private Cloud (VPC) for access

1. Go to [RDS home](https://console.aws.amazon.com/rds/home).
2. Select 'Databases' from the left-hand side menu.
3. Select your created database (Ex: database-1).
4. Under **Security** in **Connectivity & security**, click on the VPC under **VPC security groups** (Ex: `default (sg-01b4767ggdcb52825)`).  
5. Select **Inbound rules**.
6. Select **Edit inbound rules**.

    #### Add Two New Rules
    Rule One:

    1. Select **Add rule**.
    2. Under 'Type' select **PostgresSQL**.
    3. Under 'Source' select **My IP**.

    Rule Two:

    1. Select **Add rule**.
    2. Under 'Type' select **PostgresSQL**.
    3. Under 'Source' select **Custom**.
    4. In the search box, select the security group starting with the label 'eks-cluster-sg'.

7. Select **Save rules**.


### Create Databases and Schema

1. Clone the Open AMT Cloud Toolkit.

    ```
    git clone --recursive https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit --branch v{{ baseClone.version }}
    ```

2. Use the database schema files to initialize the hosted Postgres DB in the following steps.

    !!! note
        The following commands will prompt for the database password you chose [here](#create-postgres-db-in-rds).

    Where:

    - **&lt;HOST&gt;** is the location of the Postgres database (Ex: `database-1.jotd7t2abapq.us-west-2.rds.amazonaws.com`).
    - **&lt;USERNAME&gt;** is the username for the Postgres database.

3. Create the RPS database.

    ```
    psql -h <HOST> -p 5432 -d postgres -U <USERNAME> -W -c "CREATE DATABASE rpsdb"
    ```

4. Create tables for the new 'rpsdb'.

    ```
    psql -h <HOST> -p 5432 -d rpsdb -U <USERNAME> -W -f ./open-amt-cloud-toolkit/data/init.sql
    ```

5. Create the MPS database.

    ```
    psql -h <HOST> -p 5432 -d postgres -U <USERNAME> -W -f ./open-amt-cloud-toolkit/data/initMPS.sql
    ```

Where:

- **&lt;HOST&gt;** is the location of the Postgres database (Ex: `database-1.jotd7t2abapq.us-west-2.rds.amazonaws.com`).
- **&lt;USERNAME&gt;** is the username for the Postgres database.


## Connect to EKS Instance

Ensure your `kubectl` is connected to the EKS cluster you wish to deploy/manage.

1. Provide your region and cluster name.

    ```
    aws eks update-kubeconfig --region <region> --name <cluster-name>
    ```

    Where:

    - **&lt;cluster-name&gt;** is the name of your EKS cluster.
    - **&lt;region&gt;** is the AWS region where the cluster is (Ex: `us-west-2`).


## Create Secrets 

### 1. Private Docker Registry Credentials

If you are using a private docker registry, you'll need to provide your credentials to K8S. 

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
    - **&lt;SERVERURL&gt;** is the url for the AWS-hosted Postgres database (Ex: `database-1.jotd7t2abapq.us-west-2.rds.amazonaws.com`).

2. Create RPS connection string secret.

    ```
    kubectl create secret generic rps --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/rpsdb?sslmode=no-verify
    ```

3. Create MPS Router connection string secret.

    ```
    kubectl create secret generic mpsrouter --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/mpsdb?sslmode=no-verify
    ```

4. Create MPS connection string secret.   

    ```
    kubectl create secret generic mps --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/mpsdb?sslmode=disable
    ```


## Update Configuration

### Edit values.yaml

1. Open the `values.yaml` file in the `./open-amt-cloud-toolkit/kubernetes/charts/` directory.

2. Remove the **annotations** section and `service.beta.kubernetes.io/azure-dns-label-name` key in the `kong:` section. These are Azure-specific implementations.

    ``` yaml hl_lines="3 4"
    kong:
      proxy:
        annotations: # Delete this line
          service.beta.kubernetes.io/azure-dns-label-name: "<your-domain-name>" # Delete this line
    ```

3. Update the *mps*, *rps*, *webui*, and *mpsrouter* keys to point to your own container registries.

    ```yaml hl_lines="2-5"
    images:
        mps: "vprodemo.azurecr.io/mps:latest"
        rps: "vprodemo.azurecr.io/rps:latest"
        webui: "vprodemo.azurecr.io/webui:latest"
        mpsrouter: "vprodemo.azurecr.io/mpsrouter:latest"
    ```

4. Uncomment and update the `storageClassName` key in the **mps** section to **ebs-sc**.

    ``` yaml hl_lines="3"
    mps:
        commonName: ""
        storageClassName: "ebs-sc" # Change to "ebs-sc"
        storageAccessMode: "ReadWriteOnce"
        replicaCount: 1
        logLevel: "silly"
        jwtExpiration: 1440
    ```


5. Save and close the file.

### Apply Volumes

1. Provide a `StorageClass` that can match the `PersisentVolumeClaim` for MPS. For an EKS deployment, you can use the following example YAML. It is provided in `./kubernetes/charts/volumes/aws.yaml`.

    !!! example "Provided aws.yaml Example"

        ``` yaml
        kind: StorageClass
        apiVersion: storage.k8s.io/v1
        metadata:
          name: ebs-sc
        provisioner: ebs.csi.aws.com
        volumeBindingMode: WaitForFirstConsumer
        ```

2. Apply it to your cluster.

    ```
    kubectl apply -f ./kubernetes/charts/volumes/aws.yaml
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

1. Add the root token as a secret to the EKS cluster so that the services can access Vault.

    ```
    kubectl create secret generic vault --from-literal=vaultKey=<your-root-token>
    ```

    Where:

    - **&lt;your-root-token&gt;** is your `root_token` generated by Vault.

### Update commonName in values.yml

1. Get the External-IP for accessing the UI. Note and save the value under 'EXTERNAL-IP'.

    ```
    kubectl get service openamtstack-kong-proxy
    ```

2. Update the value for `commonName` in the **mps** section in the `values.yml` file with the External-IP from above.  Recall that `values.yml` is located in `./kubernetes/charts/`.

    ``` yaml hl_lines="2"
    mps:
        commonName: "" # update with External-IP from `kubectl get service`
        storageClassName: "ebs-sc"
        storageAccessMode: "ReadWriteOnce"
        replicaCount: 1
        logLevel: "silly"
        jwtExpiration: 1440
    ```

3. Update the stack using helm.

    ```
    helm upgrade openamtstack ./kubernetes/charts 
    ```

## Amazon EBS CSI driver

1. Follow steps 1-3 for [Deploying the Amazon EBS CSI driver to an Amazon EKS cluster](https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html). This will enable persistent storage in the cluster.  **Stop and return before deploying the sample application. This step is unnecessary.**


## Verify running pods

1. View the pods. All pods should now be Ready and Running.

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

!!! tip "Tip - Accessing the Sample Web UI"
    Find the External-IP/FQDN for the Sample Web UI by running:

    ```
    kubectl get services openamtstack-kong-proxy
    ```

!!! warning "Warning - Self-signed Certificates"
    Make sure to accept the self-signed certificate by going to port 443 during the first visit to the Sample Web UI.

Visit the Sample Web UI using the FQDN name and [**Continue from the Get Started steps**](../../../GetStarted/loginToUI.md).