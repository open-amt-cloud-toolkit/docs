--8<-- "References/abbreviations.md"

## Prerequisites

- Docker Desktop w/ kubectl
- Helm CLI (v3.5+)     


## Create Secrets 

If you are using a private docker registry, you'll need to provide your credentials to K8S. 
``` bash
kubectl create secret docker-registry registrycredentials --docker-server=<your-registry-server> --docker-username=<your-username> --docker-password=<your-password>
```

Additionally, you'll need to provide secrets for the following:

### MPS/KONG JWT

This is the secret used for generating and verifying JWTs.
```
kubectl create secret generic open-amt-admin-jwt --from-literal=kongCredType=jwt --from-literal=key="admin-issuer" --from-literal=algorithm=HS256 --from-literal=secret="<your-secret>"
```
### KONG ACL for JWT

This configures KONG with an ACL to allow an admin user `open-amt-admin` to access endpoints using the JWT retrieved when logging in.
```
kubectl create secret generic open-amt-admin-acl --from-literal=kongCredType=acl --from-literal=group=open-amt-admin
```

### MPS Web Username and Password
This is the username and password that is used for requesting a JWT. These credentials are also used for logging in to the UI.
```
kubectl create secret generic mpsweb --from-literal=user=<your-username> --from-literal=password=<your-password>
```


## Update Configuration

### MPS

Next, update the `commonName:` key in the `mps:` section in the `values.yaml` file with the ip address of your machine

``` yaml
mps:
  commonName: "<your-ip-address>"
```

Lastly, you'll need to provide a `PersistentVolume` that can match the `PersisentVolumeClaim` for MPS. For a local, one node cluster, you can use the following YAML: 

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

This is provided in `./kubernetes/charts/volumes/local.yaml` and can be applied to your cluster with
```
kubectl apply -f ./kubernetes/charts/volumes/local.yaml
```
## Deploy Open AMT Cloud Toolkit Using Helm

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

Continue from getting started steps [here](https://open-amt-cloud-toolkit.github.io/docs/1.3/General/loginToRPS/)

