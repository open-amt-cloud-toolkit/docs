Secret Management is essential in a microservice architecture as it provides a secure repository for the services to access required sensitive assets. The Open AMT Cloud toolkit uses Hashicorp Vault as its tool for securely accessing these assets. A secret is anything that you want to tightly control access to, such as API keys, passwords, or certificates. Vault provides a unified interface to any secret, while providing tight access control and recording a detailed audit log. Similar to the database section above, when it comes time to scale Open AMT Cloud Toolkit for production, managing state can be difficult. While Vault has a comprehensive solution for managing and persisting state in a K8s cluster, we recommend leveraging a managed secret provider such as Azure Key Vault to offload this role and help reduce the overhead of managing this aspect of the toolkit. Additionally, you may consider that a Secret Provider is not necessary for your deployment and may wish to remove it leveraging some other backing store for secrets.

#### Reference Implementation
<img src="./../../assets/images/logos/vault.png" alt="vault" style="width:50px;"/>

- HashiCorp Vault


#### Example Replacements
- Azure Key Vault
- AWS Key Management Service      

## Services That Require Updating

- MPS
- RPS

## What you need to do


We'll walk through the primary steps required to swap out the secret provider with another provider. In this example, we'll be using Azure Key Vault.  At a high level, there are a few main tasks to accomplish:

- Review Vault Schema
- Add Secret Provider Dependency (if necessary)
- Configuration
- Code Implementation

### Review Vault Schema

Below are the paths/keys in the vault that are used by the Open AMT Cloud Toolkit.

```
# RPS
CIRAConfigs/[cira_config_name]/MPS_PASSWORD

certs/[domain_profile_name]/CERT
certs/[domain_profile_name]/CERT_PASSWORD

profiles/[profile_name]/AMT_PASSWORD
profiles/[profile_name]/MEBX_PASSWORD

wireless/[wireless_profile_name]/PSK_PASSPHRASE

# MPS
devices/[device_guid]/AMT_PASSWORD
devices/[device_guid]/MEBX_PASSWORD
devices/[device_guid]/MPS_PASSWORD
```

### Add Secret Provider Dependency

For this example, we'll swap out the Hashicorp Vault for Azure Key Vault. We first need to install the required dependencies. 
```
npm install @azure/keyvault-secrets
```
```
npm install @azure/identity
```
To read more about this dependency check out [https://www.npmjs.com/package/@azure/keyvault-secrets](https://www.npmjs.com/package/@azure/keyvault-secrets). 

!!! note
    This guide will assume Azure Key Vault is already configured and ready for use as it focuses on the code that needs to be implemented in the microservices.

### Configuration
For Hashicorp Vault, we have the following three properties that need to be configured. 
``` json
{
  "secrets_path": "secret/data/",
  "vault_address": "http://localhost:8200",
  "vault_token": "myroot",
}
```
For Azure Key Vault, we don't need all of these so we'll set just the address:
```json
{
  "secrets_path": "",
  "vault_address": "https://<YOUR KEYVAULT NAME>.vault.azure.net",
  "vault_token": "",
}
```
Additionally, the following three ENV variables must be set:
``` bash 
AZURE_TENANT_ID=<YOUR-TENANT-ID>
AZURE_CLIENT_ID=<YOUR-CLIENT-ID>
AZURE_CLIENT_SECRET=<YOUR-CLIENT-SECRET>
```
### Code

Let's take a look at our `ISecretManagerService` interface: 
``` typescript
export interface ISecretManagerService {
  getSecretFromKey: (path: string, key: string) => Promise<string>
  getSecretAtPath: (path: string) => Promise<any>
  listSecretsAtPath: (path: string) => Promise<any>
  readJsonFromKey: (path: string, key: string) => Promise<string>
  writeSecretWithKey: (path: string, key: string, keyvalue: any) => Promise<void>
  writeSecretWithObject: (path: string, data: any) => Promise<void>
  deleteSecretWithPath: (path: string) => Promise<void>
}
```
For this example, we'll focus on setup and implementing the `getSecretFromKey`.
``` typescript
const { DefaultAzureCredential } = require("@azure/identity")
const { SecretClient } = require("@azure/keyvault-secrets")

export class AzureSecretManagerService implements ISecretManagerService {
 vaultClient: SecretClient
 logger: ILogger

 constructor (logger: ILogger) {
    // DefaultAzureCredential expects the following three environment variables:
    // * AZURE_TENANT_ID: The tenant ID in Azure Active Directory
    // * AZURE_CLIENT_ID: The application (client) ID registered in the AAD tenant
    // * AZURE_CLIENT_SECRET: The client secret for the registered application
    const credential = new DefaultAzureCredential()

    // Lastly, create our secrets client and connect to the service
    const client = new SecretClient(EnvReader.GlobalEnvConfig.VaultConfig.address, credential);
 }

 async getSecretFromKey (path: string, key: string): Promise<string> {
    try {
      this.logger.verbose(`getting secret from vault: ${path}, ${key}`)
       const latestSecret = await client.getSecret(key);
      this.logger.debug(`got data back from vault: ${path}, ${key}`)
      return latestSecret
    } catch (error) {
      this.logger.error('getSecretFromKey error \r\n')
      this.logger.error(error)
      return null
    }
  }
}
```
After all the functions have been implemented, the last step is to wire it up. This is done in the `src/Configurator.ts` file.
``` typescript
constructor(){
    //existing
    //this.secretsManager = new SecretManagerService(new Logger('SecretManagerService'))
    this.secretsManager = new AzureSecretManagerService(new Logger('AzureSecretManagerService'))
}
```

That's it! After implementing the interface in both RPS and MPS. It's a good idea to run the Postman API tests located in `./src/test/collections` to ensure everything is in working order.

