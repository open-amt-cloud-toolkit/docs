# MPS Configuration Options

| Environment Variable       | Default                | Description |
| :------------------------- | :--------------------- | :-- |
| MPS_IMAGE                  | mps-microservice:v1  | Only used when using docker-compose.yml. Specifies image to use for MPS |
| MPS_USE_VAULT              | true                 | Whether or not the vault should be used |
| MPS_VAULT_ADDRESS          | http://vault:8200    | Address of where the vault is hosted |
| MPS_VAULT_TOKEN            | myroot               | Token used to access the vault |
| MPS_SECRETS_PATH           | secret/data/         | Path to where secrets are stored in the vault |
| MPS_NODE_ENV               | dev                  | Node Environment. Set to `PRODUCTION` when ready to deploy to production |
| MPS_GENERATE_CERTS         | true                 | Enables/Disables generation of self signed certificates based on MPS_COMMON_NAME |
| MPS_COMMON_NAME            | localhost            |  Development system's IP address. <br> **Note:** For this guide, you **cannot** use localhost because the managed device would be unable to reach the MPS and RPS servers. | For this guide, the address will be used in a self-signed certificate. It may be an IP address or FQDN in real world deployment. |
| MPS_USE_ALLOWLIST          | true                 | A value of false disables the allowlist functionality. For information about allowlist, see the allowlist [tutorial](../../Tutorials/allowlist.md)  |
| MPS_PORT                   | 4433                 | |
| MPS_WEB_PORT               | 3000                 | |
| MPS_USER                   | standalone           | Specifies the username client devices use to connect to MPS   |
| MPS_PASSWORD               | G@ppm0ym             | Specifies the password client devices use to connect to MPS  |
| MPS_USE_GLOBAL_CREDENTIALS | true                 | Each device can have its own MPS username and password. If this flag is enabled in MPS, it will use the same username and password as specified my MPS_USER and MPS_PASSWORD for all devices |
| MPS_ENABLE_LOGGING         | true                 | |
| MPS_DEBUG                  | true                 | |
| MPS_WEB_ADMIN_USER         | standalone           | Specifies the username for API authentication |
| MPS_WEB_ADMIN_PASSWORD     | G@ppm0ym             | Specifies the password for API authentication |
| MPS_HTTPS                  | true                 | Specifies whether or not to enable https      |
| MPS_XAPIKEY                | APIKEYFORMPS123!     | RESTful API Header Key. This header must be present on all RESTful calls made against MPS |
| MPS_LISTEN_ANY             | true                 | |
| MPS_TLS_OFFLOAD            | false                | |
| MPS_SESSION_ENCRYPTION_KEY | <YourStrongSessionEncryptionKey123!> | |
| MPS_LOG_LEVEL              | info                 | Controls the level of logging provided in the service. Options are (in order of increasing detail): `error`, `warn`, `info`, `verbose`, `debug`  |
| MPS_AUTH_ENABLED           | false                | |
