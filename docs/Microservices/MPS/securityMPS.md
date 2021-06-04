--8<-- "References/abbreviations.md"
# MPS Security Considerations

Management Presence Server (MPS) is a cloud agnostic micro-service that enables Intel® AMT-based platforms connecting over the internet to connect securely to manageability consoles. In order for a client to securely perform actions on Intel® AMT devices using REST APIs, MPS uses secrets. There are five key areas that must be considered:

* Intel® AMT remote admin credentials
* Intel&reg; AMT CIRA credentials
* Authorize API end point
* Server Configuration
* Web User Credentials

In addition to the above assets, there are best practices that are recommended to help secure these assets as they are used within the system.  The following sections will cover each asset and the recommended practices to use to protect the assets.


## Security Assets

### 1. Intel&reg; AMT remote admin credentials
Intel&reg; AMT remote admin credentials allows a user to remotely control an Intel&reg; AMT device and these credentials are configured in AMT Firmware by a configuration server (ex. RPS). When a user performs an action on the device using REST API, MPS fetches the corresponding credentials of that device from the configured secrets store (ex. Vault) and uses it as part of digest authentication. It is highly recommended to use a strong password (as per AMT password requirements) that is unique per device to make it more secure.

### 2. Intel&reg; AMT CIRA credentials
When an Intel&reg; device attempts to establish a connection to the MPS, there are two checks that are performed by MPS prior to allowing the connection.  
1. The Intel&reg; AMT device's GUID must be listed in the MPS database.  This is typically added by using the Devices POST API.  
2. The Intel&reg; AMT device needs to supply the correct credentials to MPS.  These credentials are checked against the username (stored in the database) and password (stored in Vault).  It is highly recommended that every device use a unique password.

### 3. Authorize API end point
MPS has a default Authorize API end point for issuing a JWT for basic user authentication to the REST APIs.  This is in place so developers can easily start using the Open AMT Cloud Toolkit microservices without needing to setup a full user authentication service for evaluation of the software.  In production, it is recommended to use a robust user authentation service (ex. OAuth2, OpenID, LDAP, etc) and disable this Authorize API end point by leaving the MPS Web User credentials blank in the MPS configuration file.

### 4. Server Configuration
In order for MPS to use secure protocols, certificates will need to be configured, and the keys for these certificates need to be securely stored. If the keys are compromised then an attacker will be able to decrypt messages that are encrypted with these certificates.  For evaluation purposes, MPS will generate self-signed certificates used for encryption.  For production, it is recommended to purchase CA-signed certificates who's signatures can be independently verified.

### 5. Web User Credentials
The Open AMT Cloud Toolkit is designed to operate behind an API Gateway (ex. Kong API Gateway).  The API Gateway's responsibility is to validate the Auth Tokens provided by a user who is requesting access to an API end point.  Once verified the API Gateway will forward the request to the appropriate microservice (MPS or RPS).  In order to make evaluation easy, MPS has implemented an Authorize API end point (see item 3 above) that will issue a JWT when the proper web user credentials are provided.  The Web User credentials are global credentials that are configured in the MPS configuration file and do not provide any fine tuned permissions.  
*NOTE: This user auth model is very simple and is not recommended for production use.*  


## Best Known Security Methods

### 1. Enable TLS on network connections
There are three potential places where TLS could be enabled to protect the security assets:

* HTTPS/WSS connection between Web UI and MPS (recommended)
* Connection between MPS and Vault - If communication between MPS and Vault is outside a secure container environment (not recommended deployment, see item 2 below)
* Connection between MPS and Intel® AMT device (required and done automatically by MPS)

Securing these communication routes will help prevent security assets being exposed through network based attacks intercepting messages between components. It is recommended that the most modern version of TLS be used when encrypting communication.

### 2. Secure and isolate execution environment
MPS holds several of the described security assets in memory during execution.  In order to protect these assets while in the memory of MPS, it is recommended that MPS be run in a secure execution environment such as a dedicated container. Deploying into a secure conatiner environment eases the burden of individually securing the assets while in memory or in transit between Open AMT Cloud Toolkit services.  Running MPS, RPS, API Gateway, MPS Router, Vault, and Database all within the same secure container instance will help ensure that the communication between these services remains secure.

### 3. Utilize Vault for storing Credentials
Vault is a tool used to secure, store, and tightly control access to secrets. Utilizing Vault to store passwords used by MPS will greatly increase the security of these assets.

### 4. Utilize Kubernetes Secrets for storing dynamic configuration values (like environment variables)
Kubernetes Secrets help you to store and manage sensitive information like Tokens. Use Kubernetes secrets for storing environment variables required for configuring MPS rather than putting them in the image/pod. Vault token, Session secret key, and Server configuration assets required for MPS should be stored in Kubernetes secrets.

<br>
