--8<-- "References/abbreviations.md"
# Release Notes

If you haven't had a chance - checkout the [Letter From Devs](./letter.md) for a message from our development team.

## Announcements
### Long Term Support Release
The Long Term Support (LTS) release of Open AMT Cloud Toolkit is official and is planned for Q3 2021. With the release of LTS, the version of Open AMT Cloud Toolkit and all of the components will be moving to 2.0.0. Why the major version change? During the 1.X development period, we made many breaking changes as we were improving our external interfaces, database schemas, and communication protocols. Starting with 2.0, we will no longer be introducing breaking changes in minor version releases. This means that any 2.X component will be compatible with other 2.X components. With this adherence to [semantic versioning](https://semver.org/) our goal is to allow our customers the flexibility to upgrade versions with confidence and clarity of compatibility.

## Key Feature Changes for 1.4
This section outlines key features changes between versions 1.3 and 1.4 for Open AMT Cloud Toolkit.

### Breaking Changes
#### MPS & RPS: 
   - **WebSocket Authentication Updated:** Kong Authenication for Websockets is now required for KVM and SOL connections.  The same JWT that is used for REST calls is also used for KVM and SOL connections.
   - **Environment Variables Removed:** The following environment variables have been removed from MPS:
        * username
        * pass
        * use_global_credentials
        * use_allowlist
   - **Default Credentials Removed:** The default values for web_admin_user and web_admin_password have been removed from the MPS configuration file.  This disables the ability to request a JWT from MPS using the "authorize" REST API.  When deploying MPS, user specified credentials will need to be supplied in the configuration file or a 3rd party user authentication service will need to be setup to issue auth tokens.
   - **Vault Schema Updated:** Vault KeyName for RPS has been changed to remove the profile prefix from the key name.

### Additions
#### RPS & MPS
- **Containerized Scaling Support:**  In 1.2 we released a preview version of scaling, a first look at supporting large-scale deployments. In 1.4 we've updated scaling capabilities with support for Docker Swarm and Kubernetes deployments.  With this feature, scale the MPS and RPS microservices as needed to support an entire fleet of Intel® AMT devices.  The toolkit enables robust scaling through:
   *  A new component (MPS Router) that acts as a reverse proxy between the API Gateway and the MPS. More on MPS Router below.
   *  Support for deploying cloud based components and dependencies to Docker Swarm and Kubernetes. Components include MPS, RPS, MPS Router, API Gateway, Vault, PostgreSQL.  
   *  Cloud provider agnostic [deployment documentation](https://open-amt-cloud-toolkit.github.io/docs/1.4/Kubernetes/kubernetes/).
   *  Improved routing of KVM and SOL sessions when multiple instances of MPS are deployed.
   *  An increase in the number of CIRA connections that can be handled per MPS instance. Detailed guidance will be provided with the LTS release.

#### MPS Router
- **Reverse Proxy:** In this release we are adding a new required component to the toolkit deployment, the MPS Router.  This small containerized Golang-based serivce acts as a reverse proxy between the API Gateway and MPS.  When Intel&reg; AMT devices make a CIRA connection with MPS, the MPS registers the device GUID and its MPS instance ID with the MPS Router.  All MPS API calls coming from the API Gateway are first sent to the MPS Router before being forwarded to the correct MPS instance.  As with all components of the Open AMT Cloud Toolkit, this service is open source and is located in the [MPS Router](https://github.com/open-amt-cloud-toolkit/mps-router) repository.

#### Service Event Messages
- **MPS Events:** In 1.4 we are adding a new *preview feature* messaging system using MQTT for notifying other services when events occur in the Open AMT Cloud Toolkit microservices.  When the optional MQTT broker is deployed, events from the Open AMT Cloud Toolkit will be sent to the MQTT broker where other services can subscribe to topics in the broker and be notified when these events occur.  For example, when MPS executes a power action on a device, a MQTT message will be sent to the broker stating the action taken, if it was successful or not, the method(s) that were executed, and AMT GUID of the device.  These MQTT messages are currently only sent when the AMT REST APIs are called, but we will be expanding the scope of events in future releases.  The Service Event Messages are being added to MPS first, but we will be rolling this feature out to RPS in our next release. 

#### UI Toolkit
- **UI Toolkit on NPM:** For those who don’t know, the UI-Toolkit is a set of ready-to-use UI components that allow software developers to easily add AMT KVM and Serial-Over-LAN functionality to their UI without having to understand the deep technical AMT details for enabling these features. In this release we’re making it easier for our customers to deploy and use the UI-Toolkit components in a stand-alone react app. Get started with the UI-Toolkit on [NPM](https://www.npmjs.com/package/@open-amt-cloud-toolkit/ui-toolkit).

### Modifications and Removals
#### MPS
- **AllowList:** Allowlist enables administrators to specify which devices (GUIDs) can connect to MPS. Removing "developer mode" in a previous version broke Allowlist functionality. In this release, MPS AllowList functionality allows devices to connect if they are listed in the MPS database and present the proper credentials. If a device either is not listed in the MPS database or has the wrong credentials, MPS will refuse the connection. Along with this change, we have improved the MPS Devices API to make it very easy to add, edit, and remove devices from the MPS database. MPS API documentation can be found out on [Swagger](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/1.4.0#/)
- **Simplified API:** The MPS API received some additional attention in this release. In 1.2 we added the ability to add metadata to the MPS database for tracking device hostname and tags. In the API, we had this as a separate “metadata” endpoint. In 1.4 we merged the “metadata” endpoint into the “devices” endpoint to greatly simplify the MPS API organization structure. The “devices” endpoint supports GET, POST, and PATCH for managing all device information, including metadata. You can find updated API documentation on SwaggerHub for both [RPS](https://app.swaggerhub.com/apis-docs/rbheopenamt/rps/1.4.0) and [MPS](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/1.4.0). 

#### Sample Web UI
- **Improvements:** We have made some minor changes and improvements in the Sample Web UI to stream line profile creation and provide additional information on the devices page.
   * The UI now sets the password length for new random passwords, removing the need for the password length field in the CIRA Config and Profiles. The REST APIs still support user defined values from 8 to 32 for password length.
   * On the devices page, we have added the device hostname, GUID, and tags to help with easily finding this information for each device.

## Resolved Issues

## Known Issues in 1.4
#### Intel&reg; AMT
- **Intel&reg; AMT device fails to re-connect to MPS after MPS is not available for an extended period of time:** *UPDATE: There is a firmware fix available for this issue, however, we are still testing to ensure that it completely resolves this issue.  We'll let you know once this issue is resolved.*  If the MPS goes down for more than 2 days, Intel&reg; AMT devices will no longer attempt to connect to MPS. If this happens, there are two ways to prompt Intel&reg; AMT to attempt to re-connect to MPS:
    1.	Unplug and re-plug the network cable
    2.	Reboot the Intel&reg; AMT device
#### UI-Toolkit
- **KVM freeze intermittently:** We have added a small delay in handling mouse interactions that prevents us from flooding the AMT channel.  There are still a few occasions where KVM could still freeze.  We are still root causing this new issue
#### RPS
- **[Data shouldn't be added if vault calls fail](https://github.com/open-amt-cloud-toolkit/rps/issues/254):** Currently, if vault calls fail (e.g., during the creation of domain), the domain is successfully added to the database despite not being added to vault. Ideally, the database entry should be rolled back if vault call fails.
#### Sample-Web-UI
- **[CIRA Config Name Smashed](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/278):** Longer config names run into the IP Address field
- **[AMT Responses should return status (i.e. NOT_READY) instead of "Sent Succesfully"](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/276):** Messages should provide a bit more information as to the response of the AMT call instead of success/fail.
