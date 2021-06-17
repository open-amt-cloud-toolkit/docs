--8<-- "References/abbreviations.md"
# Release Notes

If you haven't had a chance - checkout the [Letter From Devs](./letter.md) for a message from our development team.
## Key Feature Changes for 1.4
This section outlines key features changes between versions 1.3 and 1.4 for Open AMT Cloud Toolkit. 

### Additions
#### RPS & MPS
- **Containerized Scaling Support:**  In 1.2 we released a preview version of scaling, a first look at supporting large-scale deployments. In 1.4 we've updated scaling capabilities with support for Docker Swarm and Kubernetes deployments.
With this feature, scale the MPS and RPS microservices as needed to support an entire fleet of Intel® AMT devices.

The toolkit enables robust scaling through:
    * A new component (MPS Router) that acts as a reverse proxy between the API Gateway and the MPS. More on MPS Router below.
    * Support for deploying cloud based components and dependencies to Docker Swarm and Kubernetes. Components include MPS, RPS, MPS Router, API Gateway, Vault, PostgreSQL.  
    * Cloud provider agnostic [deployment documentation](https://open-amt-cloud-toolkit.github.io/docs/1.4/Kubernetes/kubernetes/).
    * Improved routing of KVM and SOL sessions when multiple instances of MPS are deployed.
    * An increase in the number of CIRA connections that can be handled per MPS instance. Detailed guidance will be provided with the LTS release.

#### MPS Router
- **Reverse Proxy:** In this release we are adding a new required component to the toolkit deployment, the MPS Router.  This small containerized GO serivce acts as a reverse proxy between the API Gateway and MPS.  When Intel&reg; AMT devices make a CIRA connection with MPS, the MPS registers the device GUID and its MPS instance ID with the MPS Router.  All MPS API calls coming from the API Gateway are first sent to the MPS Router before being forwarded to the correct MPS instance.  As with all components of the Open AMT Cloud Toolkit, this service is open source and is located in the [MPS Router](https://github.com/open-amt-cloud-toolkit/mps-router) repository.

#### Service Event Messages
- **MPS Events:** In 1.4 we are adding a messaging system using MQTT for notifying other services when events occur in the Open AMT Cloud Toolkit microservices.  When the optional MQTT broker is deployed, events from the Open AMT Cloud Toolkit will be sent to the MQTT broker where other services can subscribe to topics in the broker and be notified when these events occur.  For example, when MPS executes a power action on a device, a MQTT message will be sent to the broker stating the action taken, if it was successful or not, the method(s) that were executed, and AMT GUID of the device.  These MQTT messages are currently only sent when the AMT REST APIs are called, but we will be expanding the scope of events in future releases.  The Service Event Messages are being added to MPS first, but we will be rolling this feature out to RPS in our next release. 

### Modifications and Removals
#### MPS
- **AllowList:** Allowlist enables administrators to specify which devices (GUIDs) can connect to MPS. Removing "developer mode" in a previous version broke Allowlist functionality. In this release, MPS AllowList functionality allows devices to connect if they are listed in the MPS database and present the proper credentials. If a device either is not listed in the MPS database or has the wrong credentials, MPS will refuse the connection. Along with this change, we have improved the MPS Devices API to make it very easy to add, edit, and remove devices from the MPS database. MPS API documentation can be found out on [Swagger](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/1.4.0#/)

## Resolved Issues

## Known Issues in 1.4
#### Intel&reg; AMT
- **Intel&reg; AMT device fails to re-connect to MPS after MPS is not available for an extended period of time:** *UPDATE: There is a firmware fix available for this issue, however, we are still testing to ensure that it completely resolves this issue.  We'll let you know once this issue is resolved.*  If the MPS goes down for more than 2 days, Intel&reg; AMT devices will no longer attempt to connect to MPS. If this happens, there are two ways to prompt Intel&reg; AMT to attempt to re-connect to MPS:
    1.	Unplug and re-plug the network cable
    2.	Reboot the Intel&reg; AMT device
#### UI-Toolkit
- **KVM freeze intermittently:** We have added a small delay in handling mouse interactions that prevents us from flooding the AMT channel.  There are still a few occasions where KVM could still freeze.  We are still root causing this new issue
#### RPS
- **Failure to add Device:** If an RPS call to add new device information and credentials to Vault fails, the RPS should revert the changes to the other service and emit an error message. Currently RPS will provide an error, but it does not revert the changes. Resolving the failing issue with the service and then re-running the activation restores the data integrity between the database and Vault.