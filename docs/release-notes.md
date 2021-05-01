--8<-- "References/abbreviations.md"
# Release Notes

If you haven't had a chance - checkout the [Letter From Devs](./letter.md) for a message from our development team.
## Key Feature Changes for 1.3
This section outlines key features changes between versions 1.2 and 1.3 for Open AMT Cloud Toolkit. 

### Additions
#### RPS & MPS
- **Stateless Authentication:** The RESTful APIs for both RPS and MPS had their APIKEYS removed and now leverage [Kong Gateway](https://konghq.com/kong/) for user authentication.  This simplifies how API calls are made into the Open AMT Cloud Toolkit services by routing all API connections through a single URL:   
    Format:
    ```html
    https://example.url/
    ```
    Examples:

    ```html
    https://example.url/mps
    https://example.url/rps
    ```
    
    With the addition of [Kong Gateway](https://konghq.com/kong/) and its rich [plug-in support](https://docs.konghq.com/hub/), this opens up options for integrators to use a broader set of user authentication services (OAuth 2.0, OpenID, Okta, LDAP, etc).  By default, the MPS provides a JSON Web Token (JWT) via the ```/authorization``` endpoint. The new stateless authentication model will make integration of Open AMT Cloud Toolkit microservices into existing management consoles much more seamless.

### Modifications and Removals
#### RPS
- **RPS Activation Changes:** In 1.2 we added a short delay between the activation of a device and the configuration of Intel&reg; AMT features.  While RPS waits for Intel&reg; AMT to be ready, RPS and RPC send "heartbeats" back and forth to keep the connection alive.  This heartbeat rate was very fast in 1.2 and produced thousands of progress dots on the client terminal screen as well as spamming the server-side console log.  In 1.3 we have modified the heartbeat pace to send a heartbeat every 5 seconds.  Many dots (not to mention packets) were saved with this change.
#### UI Toolkit
- **Deprecation announcement of non-socket UI Toolkit components:** Following the deprecation announcement in 1.2, we have removed the following UI Toolkit components: Profile Editor, CIRA Editor, Domain Editor, Audit Log, and Device List.  KVM and SOL UI Toolkit modules will remain in the UI Toolkit.  Look for broader UI framework support coming in future releases.
#### MPS & RPS
- **Removal of Developer Mode:** As was announced in 1.2 release, we removed "Developer Mode".  In "Developer Mode" our services used a file-based approach to storing data.  Operating in this mode had several potentially serious issues from security of the data stored in the files, scaling performance, not to mention the additional code required to support both reading from a file and accessing a service API.  With this change, the MPS and RPS will exclusively use the DB and Vault interfaces for storing and accessing data.  The recommended deployment model going forward is to use a container infrastructure (Docker, Docker Swarm, Kubernetes, Azure Container Instance, etc).
- **API refactoring is complete:** In 1.2 we refactored the RPS REST APIs and in 1.3 we performed a similar refactoring the MPS REST APIs.  With the release of 1.3, these API breaking changes have been completed.  These changes align our APIs to industry standards for RESTful interfaces, normalizes responses, and simplifies the layout into logical groupings.  Special note: with the addition of Stateless Authentication, the API key in the header has been removed.  Please take a look at our updated Swagger documentation: 
    * [RPS on SwaggerHub](https://app.swaggerhub.com/apis-docs/rbheopenamt/rps/1.3.0#/)
    * [MPS on SwaggerHub](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/1.3.0#/)



## Resolved Issues

- **Vault Deployment:** When deploying in production, customers will want to run Vault in production mode.  We have added instruction on how to configure this [here](https://open-amt-cloud-toolkit.github.io/docs/1.2/Docker/dockerLocal_prodVault/).
- **Intel&reg; AMT connection to MPS reliability after configuration:**  We have added a small delay between when Intel&reg; AMT is activated and CIRA is configured that resolves the connection issues we were seeing in 1.1.

## Known Issues in 1.3
#### Intel&reg; AMT
- **Intel&reg; AMT device fails to re-connect to MPS after MPS is not available for an extended period of time:** *UPDATE: There is a firmware fix available for this issue, however, we are still testing to ensure that it completely resolves this issue.  We'll let you know once this issue is resolved.*  If the MPS goes down for more than 2 days, Intel&reg; AMT devices will no longer attempt to connect to MPS. If this happens, there are two ways to prompt Intel&reg; AMT to attempt to re-connect to MPS:
    1.	Unplug and re-plug the network cable
    2.	Reboot the Intel&reg; AMT device
#### UI-Toolkit
- **KVM freeze intermittently:** We have added a small delay in handling mouse interactions that prevents us from flooding the AMT channel.  There are still a few occasions where KVM could still freeze.  We are still root causing this new issue