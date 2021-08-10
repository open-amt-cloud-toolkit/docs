--8<-- "References/abbreviations.md"

# RPS Configuration 

| Environment Variable         | Default                               | Description |
| :--------------------------- | :------------------------------------ | :---------- |
| RPS_IMAGE                    | `rps-microservice:v1`   | Only used when using docker-compose.yml. Specifies image to use for RPS |
| RPS_CONNECTION_STRING        | `postgresql://postgresadmin:admin123@localhost:5432/rpsdb` | The database connection string | 
| RPS_WEB_PORT                 | `8081`                  | Specifies the Web API port to listen on |
| RPS_WEBSOCKETPORT            | `8080`                  | Specifies the Websocket port to listen on |
| RPS_VAULT_ADDRESS            | `http://vault:8200`    | Address of where the vault is hosted |
| RPS_VAULT_TOKEN              | `myroot`                | Token used to access the vault |
| RPS_SECRETS_PATH             | `secret/data/`          | Specifies the path for where secrets are stored in the vault |
| RPS_LOG_LEVEL                | `info`                  | Controls the level of logging provided in the service. Options are (in order of increasing detail): `error`, `warn`, `info`, `verbose`, `debug`, and `silly`  |
| RPS_MPS_SERVER               | `http://localhost:3000` | Specifies where the MPS is hosted -- required for metadata registration (i.e. hostname, and tags) |
| RPS_DELAY_TIMER              | `12`                   | Sets the number of seconds to wait after activation but before proceeding with final steps. By default it is set to 12 seconds. During this waiting period, RPS sends heartbeats to RPC to keep the connection alive. |
| RPS_MQTT_ADDRESS            | No Value   | Address of where the mqtt broker is hosted. Mqtt container is named `mosquitto` and is open to port `8883`. Thus unless setting are changed the value should be either empty (off) or `mqtt://mosquitto:8883` (on) |