--8<-- "References/abbreviations.md"

# RPS Security Considerations

Remote Provision Service (RPS) is built to be a micro service that plays a component role in a larger set of services that makes up the device management software suite.  In this role, RPS uses and creates secrets that are required to be able to successfully activate and use Intel® AMT.  There are six key assets that must be protected:

* Remote admin password for Intel® AMT
* MEBX password for Intel® AMT
* Provisioning Certificate for each supported domain
* Password used to encrypt each Provisioning Certificate
* Device configuration information sent to Intel® AMT device
* MPS CIRA login credentials

In addition to the above assets, there are best practices that are recommended to help secure these assets as they are used within the system.  The following sections will cover each asset and the recommended practices to use to protect the assets.

---
## Security Assets

### 1 Remote Admin Password
This password is what is configured in the Intel® AMT firmware that allows a remote user to remotely control the Intel® AMT device (power actions, remote desktop, remote terminal, etc).  When RPS activates an Intel® AMT device, it sets this password in the Intel® AMT firmware.  This password can either be statically set or can be randomly generated based on the profile defined by the user.  It is highly recommended to use randomly generated passwords as this will make each Intel® AMT device more secure by using unique passwords per device.
In a default docker or Kubernetes deployment, RPS will save the Remote Admin Password to the deployed Vault instance.

### 2 MEBX Password
The Management Engine BIOS Extension (MEBX) password is the password that protects the pre-boot menu option that provides access to Intel® AMT settings.  To use this password a user needs to have physical access to the device.  It is highly recommended to change this password from the factory default settings upon receiving a new Intel® AMT device.  A RPS profile provides an option for either specifying a static password that is used for all devices configured with a given profile or a randomly generated password can be assigned uniquely per device.  The MEBX password set in each device is saved in Vault.
While a randomly generated password is more secure, in this case there is risk that if the Vault database is lost, access to the Intel® AMT device could be very difficult to recover.  It is recommended to use the high availability and backup options provided by the Vault solution to ensure that these secrets are not lost.

### 3 Provisioning Certificate
This certificate is unique per owned domain where RPS needs to provision Intel® AMT devices.  This certificate must be derived from a root certificate whose hash matches one of the trusted provisioning root certificate hashes that is listed in the Intel® AMT device firmware.  Generally, the provisioning certificate is purchased from a trusted certificate authority (VeriSign, GoDaddy, Comodo, etc).  The full list of supported CAs based on Intel® AMT version are listed [here](https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/WordDocuments/rootcertificatehashes.htm).  This certificate must contain the leaf certificate, root certificate, and all of the intermediate certificates to form a complete certificate chain.  Additionally, the certificate file must also include the private key for the certificate (.pfx format).  The leaf certificate for the provisioning certificate must match the domain suffix that the Intel® AMT device is connected as specified by DHCP option 15 or the Trusted DNS suffix in the Management Engine BIOS Extensions (MEBX).  Matching this is one of the ways in which the Intel® AMT firmware establishes trust with RPS. 
The provisioning certificate is provided by the user when defining an Intel® AMT profile.  RPS fetches the Provisioning Certificate from Vault when it is needed to activate an Intel® AMT device.  If users have provisioning certificates, they will need to understand which profile to use when configuring an Intel® AMT device based on the network to which the device is currently connected.

### 4 Password used to encrypt Provisioning Certificate
This is the password that is used to encrypt the provisioning certificate .pfx file that is discussed above.  RPS uses this password to decrypt the provisioning certificate so that it can use the certificate components and the private key to activate Intel® AMT devices.  
RPS fetches the password from Vault and will use it when it is needed to decrypt a provisioning certificate.

### 5 Device configuration information sent to Intel® AMT device
This data is a set of information that Intel® AMT firmware will use to establish trust and then activate the Intel® AMT device.  Contained in this information is the hashed remote admin password and the MEBX password.  It is important to protect this set of information while it is being used by RPS and while in transit to the Intel® AMT device.  Ensuring that a secure (TLS encrypted) WebSocket connection is used when RPS is communicating with the client device will protect this data while in transit.  This set of information utilizes nonces to prevent replay of this data.

### 6 MPS CIRA Login Credentials
In order for an Intel&reg; AMT device to connect to the MPS over a CIRA connection, it needs to provide the correct login credentials for MPS.  These credentials are specified as part of the AMT Profile created in RPS.  When a device is configured by RPS, the MPS CIRA credentials will be sent to MPS using the Devices POST API call where MPS will store the credentials.  These credentials are verfied by the MPS when the CIRA connection is established.

---
## Best Known Security Methods

### 1 Enable TLS on network connections
There are two potential places where TLS could be enable to protect the security assets:
* WebSocket connection between RPS and Intel® AMT client (recommended)
* Connection between RPS and Vault - If communication between RPS and Vault is outside a secure container environment (not recommended deployment, see item 2 below)

Securing these communication routes will help prevent security assets being exposed through network based attacks intercepting messages between components. It is recommended that the most modern version of TLS be used when encrypting communication.

### 2 Secure and isolate execution environment
RPS holds several of the described security assets in memory during execution.  In order to protect these assets while in the memory of RPS, it is recommended that RPS be run in a secure execution environment such as a dedicated container. Deploying into a secure conatiner environment eases the burden of individually securing the assets while in memory or in transit between Open AMT Cloud Toolkit services.  Running MPS, RPS, API Gateway, MPS Router, Vault, and Database all within the same secure container instance will help ensure that the communication between these services remains secure.

### 3 Utilize a Hashicorp Vault implementation to store security assets
Utilizing Hashicorp Vault to store security assets either created by or used by RPS will greatly increase the security of these assets.  Not only does Vault encrypt the data at rest, but it also manages access to the data itself.  As the Vault owner, you decide who gets access to the security assets stored there, not RPS.
