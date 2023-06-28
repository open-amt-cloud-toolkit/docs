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


## Get the Toolkit

1. Clone the Open AMT Cloud Toolkit.

    ```
    git clone https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit --branch v{{ repoVersion.oamtct }}
    ```

## Create a New EKS Cluster

1. Follow steps for [aws configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) to finish configuration of AWS CLI.

2. Follow steps to [Create a key pair using Amazon EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html) to create a SSH key for accessing the cluster.

3. Create a new EKS cluster and supporting components.

    ```
    eksctl create cluster --name <cluster-name> --region <region> --with-oidc --ssh-access --ssh-public-key <ssh-keypair-name> --managed
    ```

    Where:

    - **&lt;cluster-name&gt;** is the name of the new EKS cluster.
    - **&lt;region&gt;** is the AWS region to deploy the stack (Ex: `us-west-2`).
    - **&lt;ssh-keypair-name&gt;** is the name of the SSH key from the previous step.

## Configure EKS Instance

Ensure your `kubectl` is connected to the correct EKS cluster to manage.

1. Provide your region and cluster name.

    ```
    aws eks update-kubeconfig --region <region> --name <cluster-name>
    ```

    Where:

    - **&lt;cluster-name&gt;** is the name of your EKS cluster.
    - **&lt;region&gt;** is the AWS region where the cluster is (Ex: `us-west-2`).

### Update Access Permissions

In order to be able to see cluster details like resources, networking, and more with the Amazon EKS console, we must configure permissions in the `ConfigMap`. More information can be found at [How do I resolve the "Your current user or role does not have access to Kubernetes objects on this EKS cluster" error in Amazon EKS?](https://aws.amazon.com/premiumsupport/knowledge-center/eks-kubernetes-object-access-error/)

1. Get the configuration of your AWS CLI user or role.

    ```
    aws sts get-caller-identity
    ```

2. Edit `aws-auth ConfigMap` in a text editor.

    ```
    kubectl edit configmap aws-auth -n kube-system
    ```

3. Add the IAM user **OR** IAM role to the ConfigMap. To allow superuser access for performing any action on any resource, add `system:masters` instead of `system:bootstrappers` and `system:nodes`.

    === "Add a Role"
        ```
        # Add under existing mapRoles section
        # Replace [ROLE-NAME] with your IAM Role

        mapRoles: |
          - rolearn: arn:aws:iam::XXXXXXXXXXXX:role/[ROLE-NAME]
          username: [ROLE-NAME]
          groups:
          - system:bootstrappers
          - system:nodes
        ```
    === "Add a User"
        ```
        # Alternatively, you can create permissions for a single User rather than a Role
        # Create a new mapUsers section
        # Replace [USER-NAME] with your IAM User

        mapUsers: |
          - rolearn: arn:aws:iam::XXXXXXXXXXXX:role/[USER-NAME]
          username: [USER-NAME]
          groups:
          - system:bootstrappers
          - system:nodes
        ```

4. Save and close the text editor window. A success or error message will print to the console after closing the text editor window. If an error shows, verify the correct syntax was used. Additionally, a more detailed error message will be printed within the ConfigMap text file.

### Add EBS CSI driver to Cluster

The Amazon EBS CSI plugin requires IAM permissions to make calls to Amazon APIs on your behalf. This is required for Vault. Without the driver, Vault will be stuck pending since its volume will be unable to be created. This is a new requirement starting in Kubernetes 1.23 and later.

Find additional information at [Creating the Amazon EBS CSI driver IAM role for service accounts](https://docs.amazonaws.cn/en_us/eks/latest/userguide/csi-iam-role.html).

1. Create a new IAM role and attach the required Amazon managed policy. Replace `<cluster-name>` with the name of your cluster.

    ```
    eksctl create iamserviceaccount \
        --name ebs-csi-controller-sa \
        --namespace kube-system \
        --cluster <cluster-name> \
        --attach-policy-arn arn:aws-cn:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
        --approve \
        --role-only \
        --role-name AmazonEKS_EBS_CSI_DriverRole
    ```

2. Add the EBS CSI add-on to the cluster. Replace `<cluster-name>` with the name of your cluster and `<account-ID>` with your Account ID. Find more information at [Managing the Amazon EBS CSI driver as an Amazon EKS add-on](https://docs.aws.amazon.com/eks/latest/userguide/managing-ebs-csi.html).

    ```
    eksctl create addon --name aws-ebs-csi-driver --cluster <cluster-name> --service-account-role-arn arn:aws:iam::<account-ID>:role/AmazonEKS_EBS_CSI_DriverRole --force
    ```

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

1. Use the database schema files to initialize the hosted Postgres DB in the following steps.

    !!! note
        The following commands will prompt for the database password you chose [here](#create-postgres-db-in-rds).

    Where:

    - **&lt;SERVERURL&gt;** is the location of the Postgres database (Ex: `database-1.jotd7t2abapq.us-west-2.rds.amazonaws.com`).
    - **&lt;USERNAME&gt;** is the username for the Postgres database.

2. Create the RPS database.

    ```
    psql -h <SERVERURL> -p 5432 -d postgres -U <USERNAME> -W -c "CREATE DATABASE rpsdb"
    ```

3. Create tables for the new 'rpsdb'.

    ```
    psql -h <SERVERURL> -p 5432 -d rpsdb -U <USERNAME> -W -f ./open-amt-cloud-toolkit/data/init.sql
    ```

4. Create the MPS database.

    ```
    psql -h <SERVERURL> -p 5432 -d postgres -U <USERNAME> -W -f ./open-amt-cloud-toolkit/data/initMPS.sql
    ```

## Create Secrets 

### 1. MPS/KONG JWT

This is the secret used for generating and verifying JWTs.

```
kubectl create secret generic open-amt-admin-jwt --from-literal=kongCredType=jwt --from-literal=key="admin-issuer" --from-literal=algorithm=HS256 --from-literal=secret="<your-secret>"
```

Where:

- **&lt;your-secret&gt;** is your chosen strong secret.

### 2. KONG ACL for JWT

This configures KONG with an Access Control List (ACL) to allow an admin user `open-amt-admin` to access endpoints using the JWT retrieved when logging in.

```
kubectl create secret generic open-amt-admin-acl --from-literal=kongCredType=acl --from-literal=group=open-amt-admin
```

### 3. MPS Web Username and Password
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


### 4. Database connection strings

???+ warning "Warning - Using SSL/TLS with AWS RDS"
    
    **Postgres 14**

    By default, AWS pre-selects Postgres 14. This tutorial uses the connection string setting of `no-verify` for ease of setup. To fully configure SSL, follow the links below. **For production, it is recommended to use a SSL connection.**
    
    Find more information at [Using SSL with a PostgreSQL DB instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/PostgreSQL.Concepts.General.SSL.html) and [Updating applications to connect to PostgreSQL DB instances using new SSL/TLS certificates](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/ssl-certificate-rotation-postgresql.html).

    **Postgres 15**

    Alternatively, if Postgres 15 is preferred and selected, the `sslmode` in the connection strings **must** be updated from `no-verify`/`disable` to `require` for the services to be able to connect to the database.  No other work is required for a test environment.
    
    **Note:** For a fully secured, certificate-based SSL connection, the following steps must be taken in [Using SSL with a PostgreSQL DB instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/PostgreSQL.Concepts.General.SSL.html).  It will also require updating `sslmode` to `verify-full` or `verify-ca`.  **For production, it is highly recommended.**

1. Configure the database connection strings used by MPS, RPS, and MPS Router.  

    Where:

    - **&lt;USERNAME&gt;** is the username for the Postgres database.
    - **&lt;PASSWORD&gt;** is the password for the Postgres database.
    - **&lt;SERVERURL&gt;** is the url for the AWS-hosted Postgres database (Ex: `database-1.jotd7t2abapq.us-west-2.rds.amazonaws.com`).

2. Create RPS connection string secret.

    === "Postgres 14"
        ```
        kubectl create secret generic rps --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/rpsdb?sslmode=no-verify
        ```
    === "Postgres 15"
        ```
        kubectl create secret generic rps --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/rpsdb?sslmode=require
        ```

3. Create MPS Router connection string secret.

    === "Postgres 14"
        ```
        kubectl create secret generic mpsrouter --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/mpsdb?sslmode=disable
        ```
    === "Postgres 15"
        ```
        kubectl create secret generic mpsrouter --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/mpsdb?sslmode=require
        ```

4. Create MPS connection string secret.   

    === "Postgres 14"
        ```
        kubectl create secret generic mps --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/mpsdb?sslmode=no-verify
        ```
    === "Postgres 15"
        ```
        kubectl create secret generic mps --from-literal=connectionString=postgresql://<USERNAME>:<PASSWORD>@<SERVERURL>:5432/mpsdb?sslmode=require
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

3. Save and close the file.


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
        commonName: "" # update with External-IP from `kubectl get services`
        replicaCount: 1
        logLevel: "silly"
        jwtExpiration: 1440
    ```

3. Update the stack using helm.

    ```
    helm upgrade openamtstack ./kubernetes/charts 
    ```


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

2. Check that the MPS Certificate is correct in your browser. Go to your FQDN at port 4433.

    ```
    https://<Your-AWS-FQDN>:4433
    ```

3. Verify the MPS Certificate in your browser has the correct Issuer information and is Issued to your FQDN.

    ??? warning "Troubleshoot - `Issued to` field showing NaN or blank"

        **If your certificate is incorrect, the AMT device will not connect to the MPS server. See Figure 1.**

        Follow the steps below to correct the problem.

        !!! example "Example - Incorrect MPS Certificate"
            <figure class="figure-image">
                <img src="..\..\..\..\assets\images\MPS_Certificate.png" alt="Figure 1: Incorrect Certificate">
                <figcaption>Figure 1: Incorrect Certificate</figcaption>
            </figure>
            
        1. Open and Login to Vault UI.

        2. Go to `kv/data/MPSCerts/` directory.

        3. Delete the existing MPS Certificate.

        4. In a terminal, run the following command.

            ```
            kubectl rollout restart deployment mps 
            ```

        5. A new, correct MPS Cert should be generated.

        6. Go back to the webserver in your browser.

            ```
            https://<Your-AWS-FQDN>:4433
            ```
        
        7. Verify the `Issued to:` field is no longer NaN/blank and now shows the correct FQDN.

        8. Continue to Next Steps section.


## Next Steps

Visit the Sample Web UI using the FQDN name and [**Continue from the Get Started steps**](../../../GetStarted/loginToUI.md).