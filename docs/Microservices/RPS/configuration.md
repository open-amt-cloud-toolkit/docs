# RPS Configuration 

| Environment Variable         | Default                               | Description |
| :--------------------------- | :------------------------------------ | :---------- |
| RPS_IMAGE                    | rps-microservice:v1                   | Only used when using docker-compose.yml. Specifies image to use for RPS  |                          
| RPS_USE_VAULT                | true                                  | Whether or not the vault should be used                    |           
| RPS_USE_DB_PROFILES          | true                                  |             |           
| RPS_NODE_ENV                 | dev                                   | Node Environment. Set to `PRODUCTION` when ready to deploy to production            |          
| RPS_HTTPS                    | true                                  | Specifies whether or not to enable https                   |           
| RPS_DB_HOST                  | rpsdb                                 | The Database host address                                  |            
| RPS_DB_NAME                  | postgresdb                            | The name of the postgres database to connect to            |                 
| RPS_DB_PORT                  | 5432                                  |             |           
| RPS_DB_USER                  | postgresadmin                         | Database username to log in to postgres with               |          
| RPS_DB_PASSWORD              | admin123                              | Database password to log in to postgres with               |     
| RPS_WEBSOCKETTLS             | true                                  |             |           
| RPS_WEB_PORT                 | 8081                                  | Specifies the Web API port to listen on            |           
| RPS_WEBSOCKETPORT            | 8080                                  | Specifies the Websocket port to listen on            |           
| RPS_XAPIKEY                  | APIKEYFORRPS123!                      | RESTful API Header Key. This header must be present on all RESTful calls made against RPS |                      
| RPS_VAULT_ADDRESS            | http://vault:8200                     | Address of where the vault is hosted            |                        
| RPS_VAULT_TOKEN              | myroot                                | Token used to access the vault                        |             
| RPS_SECRETS_PATH             | secret/data/                          | Specifies the path for where secrets are stored in the vault   |                   
| RPS_CREDENTIALS_PATH         | ../../../config/credentials.json      |             |                                       
| RPS_AMT_USER                 | admin                                 |             |            
| RPS_WEB_TLS_CERT             | ../private/mpsserver-cert-public.crt  | Path to public certificate           |                                           
| RPS_WEB_TLS_CERT_KEY         | ../private/mpsserver-cert-private.key | Path to private key                  |                                            
| RPS_ROOT_CA_CERT             | ../private/root-cert-public.crt       | Path to public root cert             |                                      
| RPS_MPS_USER                 | standalone                            | If RPS is aware of MPS. This is the username used to log into MPS. This should match the value provided for MPS_USER     |                 
| RPS_MPS_PASSWORD             | G@ppm0ym                              | If RPS is aware of MPS. This is the password used to log into MPS. This should match the value provided for MPS_PASSWORD |               
| RPS_LOG_LEVEL                | info                                  | Controls the level of logging provided in the service. Options are (in order of increasing detail): `error`, `warn`, `info`, `verbose`, `debug` |  
