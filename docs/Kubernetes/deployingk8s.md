--8<-- "References/abbreviations.md"

This tutorial demonstrates how to deploy the Open AMT Cloud Toolkit on a local Kubernetes single-node cluster. Alternatively, you can also deploy using a managed service through a Cloud Service Provider such as Azure Kubernetes Service (AKS). See [AKS](https://open-amt-cloud-toolkit.github.io/docs/1.4/Kubernetes/deployingk8s-aks/).

Kubernetes, also known as K8s, is an open-source system for automating deployment, scaling, and management of containerized applications.  Learn more about Kubernetes [here](https://kubernetes.io/docs/home/).

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop) with [Kubernetes Enabled](https://docs.docker.com/desktop/kubernetes/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm CLI (v3.5+)](https://helm.sh/)

!!!important "Important - For Linux"
    If deploying on a Linux machine, Docker Desktop is not available. You must use Docker Engine alongside a local Kubernetes cluster tool such as [minikube](https://minikube.sigs.k8s.io/docs/) or [kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/).

## Create Kubernetes Secrets 

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


## Update Configuration

1. Open the `values.yaml` file in `./open-amt-cloud-toolkit/kubernetes/charts/`.

2. Update the *mps*, *rps*, *webui*, and *mpsrouter* keys to point to your own container registries.

    ```yaml hl_lines="2-5"
    images:
        mps: "vprodemo.azurecr.io/mps:latest"
        rps: "vprodemo.azurecr.io/rps:latest"
        webui: "vprodemo.azurecr.io/webui:latest"
        mpsrouter: "vprodemo.azurecr.io/mpsrouter:latest"
        postgresdb: "postgres:13"
    ```

3. Update the *commonName* key in the `mps` section with the IP Address of your machine.

    ``` yaml hl_lines="2"
    mps:
        commonName: "<your-ip-address>"
        # storageClassName: ""
        storageAccessMode: "ReadWriteOnce"
        replicaCount: 1
        logLevel: "silly"
        connectionString: "postgresql://postgresadmin:admin123@postgres:5432/mpsdb"
        jwtExpiration: 1440
    ```

4. Save and close the file.

5. Provide a `PersistentVolume` that can match the `PersisentVolumeClaim` for MPS. For a local, single-node cluster, you can use the following example YAML. It is provided in `./kubernetes/charts/volumes/local.yaml`.

    !!! example "Provided local.yaml Example"
        ``` yaml
        apiVersion: v1
        kind: PersistentVolume
        metadata:
          name: mps-certs
          labels:
            type: local
        spec:
          accessModes:
          - ReadWriteOnce
          capacity:
            storage: 1Gi
          hostPath:
            path: "/mnt/data/mpscerts"
        ```

6. Apply it to your cluster.
    ```
    kubectl apply -f ./kubernetes/charts/volumes/local.yaml
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

3. View the pods. You might notice `openamtstack-vault-0` is not ready. This will change after we initialize and unseal Vault. All others should be Ready and Running.
    ```
    kubectl get pods
    ```

    !!! success
        ``` hl_lines="6"
        NAME                                                 READY   STATUS    RESTARTS   AGE
        mps-6984b7c69d-8d5gf                                 1/1     Running   0          5m
        mpsrouter-9b9bc499b-pwn9j                            1/1     Running   0          5m
        oactdb-697b55f885-8mdmg                              1/1     Running   0          5m
        openamtstack-kong-55b65d558c-gzv4d                   2/2     Running   0          5m
        openamtstack-vault-0                                 0/1     Running   0          5m
        openamtstack-vault-agent-injector-7fb7dcfcbd-dlqqg   1/1     Running   0          5m
        rps-79877bf5c5-hnv8t                                 1/1     Running   0          5m
        webui-784cd49976-bj7z5                               1/1     Running   0          5m
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
        NAME                                                 READY   STATUS    RESTARTS   AGE
        mps-6984b7c69d-8d5gf                                 1/1     Running   0          7m
        mpsrouter-9b9bc499b-pwn9j                            1/1     Running   0          7m
        oactdb-697b55f885-8mdmg                              1/1     Running   0          7m
        openamtstack-kong-55b65d558c-gzv4d                   2/2     Running   0          7m
        openamtstack-vault-0                                 1/1     Running   0          7m
        openamtstack-vault-agent-injector-7fb7dcfcbd-dlqqg   1/1     Running   0          7m
        rps-79877bf5c5-hnv8t                                 1/1     Running   0          7m
        webui-784cd49976-bj7z5                               1/1     Running   0          7m
        ```

## Next Steps

[**Continue from the Get Started steps**](https://open-amt-cloud-toolkit.github.io/docs/1.4/General/loginToRPS/)