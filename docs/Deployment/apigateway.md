--8<-- "References/abbreviations.md"

Open AMT uses Kong as its open-source API gateway. Kong provides an entry point for external clients, anything not a part of the microservice system, and a comprehensive suite of plugins for various scenarios. Various alternatives exist such as [Azure API Gateway](https://learn.microsoft.com/en-us/azure/architecture/microservices/design/gateway) or [Amazon API Gateway](https://aws.amazon.com/api-gateway/).

Details on which ports must be exposed and what protocols are used are found below.

## Protocols

### Open AMT Services Protocols

| Service         | Protocol  | Description                                                                          |
| --------------- | --------- | ------------------------------------------------------------------------------------ |
| Sample Web UI   | HTTPS     | Front-end Webserver                                                                  |
| MPS             | HTTPS     | REST API calls                                                                       |
|                 | WSS       | Redirection (KVM/SOL) sessions with AMT devices                                      |
| MPS Router      | HTTPS     |                                                                                      |
| RPS             | HTTPS     | REST API calls                                                                       |
|                 | WSS       | Device Activation, Configuration, and Maintenance over Websocket connection with RPC |

## Ports

### Open AMT Ports

#### Microservices

| Service         | Port  | Description                                                                            | Existing Kong Routes                    | 
| --------------- | ----- | -------------------------------------------------------------------------------------- | --------------------------------------- |
| Sample Web UI   | 80    | Serve the Sample Web UI to the browser                                                 | `/`                                     |
| MPS             | 3000  | Redirection and REST API calls                                                         | `/mps`, `/mps/login/api/v1/authorize`   |
|                 | 4433  | CIRA connection with AMT devices                                                       | N/A                                     |
| MPS Router      | 8003  | Routing calls to correct MPS instances. Relay for MPS Websocket connections            | `/mps`, `/mps/ws/relay/(.*)`            |
| RPS             | 8080  | Device Activation, Configuration, and Maintenance over Websocket connection with RPC   | `/activate`                             |
|                 | 8081  | REST API calls (e.g. CIRA Configs, Domains, Profiles)                                  | `/rps`                                  |

#### Client

| Service                    | Port   | Description                                                                                                           | 
| -------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------- |
| Intel AMT HTTP             | 16992  | Used for WS-Man messages to and from Intel AMT. Port is open over the network only when Intel AMT is configured or during configuration. It is always open locally.                                               |
| Intel AMT HTTPS            | 16993  | Used for WS-Man messages to and from Intel AMT when TLS is enabled.                                                   |
| Intel AMT Redirection/TCP  | 16994  | Used for redirection traffic (SOL, Storage Redirection, and KVM using Intel AMT authentication).                      |
| Intel AMT Redirection/TLS  | 16994  | Used for redirection traffic (SOL, Storage Redirection, and KVM using Intel AMT authentication) when TLS is enabled.  |

### Reference Services Ports

The following are ports used by the default reference solutions used by Open AMT. These may vary or change based on custom implementations of Open AMT.

| Service         | Port  | 
| --------------- | ----- |
| Postgres        | 5432  |
| Vault           | 8200  |
| Kong            | 8443  |
| Mosquitto       | 8883  |
