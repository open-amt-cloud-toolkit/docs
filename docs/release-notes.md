--8<-- "References/abbreviations.md"
# Release Notes

If you haven't had a chance - checkout the [Letter From Devs](./letter.md) for a message from our development team.
## Key Feature Changes for 1.4
This section outlines key features changes between versions 1.3 and 1.4 for Open AMT Cloud Toolkit. 

### Additions
#### RPS & MPS
- **Containerized Scaling Support:** In 1.2 we released a preview version of scaling.  This was a highly valuable exercise to learn how best to handle large scale deployments.  In 1.4 we are releasing our updated scaling capabilities with support for Docker Swarm and Kubernetes deployments.  This scaling feature will allow customers to scale out the MPS and RPS service as wide as needed to support their entire fleet of Intel&reg; AMT devices.  The following is a summary of some of the changes we have made to enable robust scaling:
    * A new component (MPS Router) was added which acts as a reverse proxy between the API Gateway and the MPS.  More on MPS Router below.
    * Support for deploying cloud based components and dependencies to Docker Swarm and Kubernetes (MPS, RPS, MPS Router, API Gateway, Vault, PostgreSQL).
    * Updated the [deployment documentation](https://open-amt-cloud-toolkit.github.io/docs/1.4/Kubernetes/kubernetes/) to be cloud provider agnostic. 
    * Improved routing of KVM and SOL sessions when multiple instances of MPS are deployed.
    * Increased the number of supported CIRA connections that can be handled per MPS instance.  Detailed guidance will be provided with the LTS release.


#### MPS Router
- **Reverse Proxy:** In this release we are adding a new required component to the toolkit deployment, the MPS Router.  This small containerized GO serivce acts as a reverse proxy between the API Gateway and MPS.  When Intel&reg; AMT devices make a CIRA connection with MPS, the MPS registers the device GUID and its MPS instance ID with the MPS Router.  All MPS API calls coming from the API Gateway are first sent to the MPS Router before being forwarded to the correct MPS instance.  As with all components of the Open AMT Cloud Toolkit, this service is open source and is located in the [MPS Router](https://github.com/open-amt-cloud-toolkit/mps-router) repository.

### Modifications and Removals
#### MPS
- **AllowList:** As noted in the 1.3 release notes, the AllowList was not working as designed.  What it was suppose to do is to give the ability to only allow specified devices (GUIDs) to connect to MPS.  When we removed "developer mode" this broke the AllowList functionality.  In this release we have updated MPS to only allow devices to connect if they are listed in the MPS database and present the proper credentials.  If a device either is not listed in the MPS database or has the wrong credentials, MPS will refuse the connection.  Along with this change, we have improved the MPS Devices API to make it very easy to add, edit, and remove devices from the MPS database.  MPS API documentation can be found out on [Swagger](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/1.4.0#/)

## Resolved Issues

## Known Issues in 1.4
#### Intel&reg; AMT
- **Intel&reg; AMT device fails to re-connect to MPS after MPS is not available for an extended period of time:** *UPDATE: There is a firmware fix available for this issue, however, we are still testing to ensure that it completely resolves this issue.  We'll let you know once this issue is resolved.*  If the MPS goes down for more than 2 days, Intel&reg; AMT devices will no longer attempt to connect to MPS. If this happens, there are two ways to prompt Intel&reg; AMT to attempt to re-connect to MPS:
    1.	Unplug and re-plug the network cable
    2.	Reboot the Intel&reg; AMT device
#### UI-Toolkit
- **KVM freeze intermittently:** We have added a small delay in handling mouse interactions that prevents us from flooding the AMT channel.  There are still a few occasions where KVM could still freeze.  We are still root causing this new issue
#### RPS
- **Failure to add Device:** When RPS is adding new device information to the database and the credentials to Vault, if one of these calls fail (ex. Vault not available), then RPS should revert the changes to the other service and emit an error message.  Currently RPS will provide an error, but it does not revert the changes.  Resolving the failing issue with the service and then re-running the activation will restore the data integrity between the database and Vault.