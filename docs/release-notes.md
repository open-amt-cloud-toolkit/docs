--8<-- "References/abbreviations.md"
# Release Notes
Please see the [release announcements](announcements.md) for additional information regarding this release.

## Feature Changes for 2.1
This section outlines key features changes between versions 2.0 and 2.1 for Open AMT Cloud Toolkit.

### Noteworthy Features and Changes
**TLS Configuration:** In this release we have added the ability for a TLS configuration to be set for AMT devices not using an MPS to manage the Out-of-Band connection.  This feature encrypts communication between Intel(r) AMT devices and management consoles over a local network.  RPS automatically generates self-signed certificates to use for TLS in this version of the Toolkit.  To read more about the TLS feature please see our [TLS documentation](https://open-amt-cloud-toolkit.github.io/docs/2.1/Reference/createProfileTLSConfig/)

**AMT Clock Sync Maintenance Task:** Intel&reg; AMT requires periodic maintenance to keep the real-time clock synced so that accurate certificate checking can be performed.  In this release, we have added this capability to both RPS and RPC.  A new "maintenance" command has been added to our RPC-Go application that will call back to RPS and perform the clock sync task.

**Hostname Override:** In response to customer feedback, we have added the ability to override the hostname using a -h command in RPC-Go.  Instead of sending up the HostOS name, RPC will now send up the host name specified.  This is particularly helpful when running RPC from a container.

**CIRA Connection & Disconnection Events:** When devices connect and disconnect from the MPS, an event will now be sent to the MQTT broker.  

**Branch Renaming:** We have renamed "master" to "main" across all of our repositories.  To learn more about why we made this change, please see the [Diversity at Intel](https://www.intel.com/content/www/us/en/diversity/diversity-at-intel.html) web site.

### Additions, Modifications, and Removals
#### Breaking Changes
- No breaking changes this release.  Hurray!
#### Open AMT Cloud Toolkit
- mqtt: added mqtt configuration (#8e458db)
- mqtt: allow websocket connections for events in the UI (#d3e4435)
- tls-config: update SQL scripts and azure deploy (#b9ffaca)
- aks: leftover storage dependecy error (#6f96538)
- aks: remove storage account requirement (#eade357)
- docs: adds issue template (#35b10ab)
#### RPS
- maintenance: added a task to sync time on AMT [#459](https://github.com/open-amt-cloud-toolkit/rps/issues/459) (#faa4b2c)
- tls: configure amt device with tls (#6ed238e)
- activation: sets mebx password if not updated [#463](https://github.com/open-amt-cloud-toolkit/rps/issues/463) (#95cdf41)
- api: restricted 8 wi-fi profiles to amt profile [#452](https://github.com/open-amt-cloud-toolkit/rps/issues/452) (#8523955)
- device: update tags execute after device exists check (#783a7b1)
- vault: removed storing random ccm password in vault profile [#455](https://github.com/open-amt-cloud-toolkit/rps/issues/455) (#8107375)
- api: remove password validation from domain cert upload (#d456103)
- docs: adds issue template (#1958a08)
- docs: add contributing guidlines (#05b3843)
- github: add pull request template (#72aa4d8)
#### MPS
- telemetry: add events for CIRA Disconnect/Connection (#1cde473)
- fix: empty event log now returns empty array instead of null (#0c6dfc0)
- api: updated version api test uri (#054762d)
- certs: exit process if vault unavailable or error occurs on startup (#7df7a00)
- certs: now self-signed certs are stored in vault (#b2d61a4)
- login: username check should be case insensitive (#5767483)
- docs: adds issue template (#2373ba3)
- docs: add contributing guidelines (#c0673e9)
- github: add pull request template (#01051ae)
#### RPC-Go
- add environment variable support
- add heartbeat support
- hostname: can now override hostname of device by passing -h as command line arg
- maintenance: add time sync for AMT
- fix: dns suffix and trim string outputs for commands
- version: add version output to cli command
- docs: add contributing guidelines
- docs: add license and security guidelines
#### Sample Web UI
- devices: update user consent field to a dropdown (#4fee063)
- eventlog: add event log UI [#428](https://github.com/open-amt-cloud-toolkit/rps/issues/428) (#dd634ac)
- profile: alert impact of random passwords (#1498067)
- telemetry: event channel logs (#3eb6ca9)
- tls: added tls option to AMT Profile [#429](https://github.com/open-amt-cloud-toolkit/rps/issues/429) (#92c63a1)
- handle NOT_READY power action (#b398668)
- KVM/SOL no longer tries to connect if device is offline (#0d0d4c3)
- e2e: update e2e tests to coding standards (#1691c9c)
- mqtt: protocol now defaults to wss for MQTT [#459](https://github.com/open-amt-cloud-toolkit/rps/issues/459) (#993b201)
- userconsent: disable user consent selection in CCM activated devices (#dbdd22a)
- eventlog: show recent event logs in device details page (#90cba3f)
- docs: adds issue template (#73c7b3c)
- docs: add contributing guidlines (#f374893)
- github: add pull request template (#8d9c19c)
#### UI Toolkit
- docs: adds issue template (#3d2f2e0)
- docs: add contributing guidlines (#8311a3a)
- github: add pull request template (#85e95b8)

## Resolved Issues
#### Open AMT Cloud Toolkit
- **[Error: Not a supported method received from AMT device](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/101)**
#### RPS
- **[MQTT messaging needs to be updated for some of the events](https://github.com/open-amt-cloud-toolkit/rps/issues/381):** Enhancement
- **[Do not enforce password policy for domain certificate](https://github.com/open-amt-cloud-toolkit/rps/issues/456):** Enhancement
- **[Wrong version on swagger file](https://github.com/open-amt-cloud-toolkit/rps/issues/457):** Bug
#### MPS
- **[MPS won't start when tls_offload is set to true or https is set to false](https://github.com/open-amt-cloud-toolkit/mps/issues/288):** Bug
- **[MPS API /ciracert always reads from file](https://github.com/open-amt-cloud-toolkit/mps/issues/294):** Bug
#### Sample-Web-UI
- **[CIRA Config Name Smashed](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/278)**
- **[Logging out of Sample-Web-UI page while on an active KVM session does not take user back to login page](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/283):** Bug
- **[Logging out of UI if user performs power actions on a device with invalid amt password](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/301):** Bug
- **[Error message misleading when using KVM in CCM Mode](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/362)**
- **[Get 'Operation failed: Create [xxxx]' on Successful Creation](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/379):** Bug
- **[cant login](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/400)**

## Open Issues and Requests
#### Open AMT Cloud Toolkit
- **[Kustomize Install](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/103):** Enhancement
#### RPS
- **[RPS should support wildcard domain suffix](https://github.com/open-amt-cloud-toolkit/rps/issues/97):** Enhancement
- **[Data shouldn't be added if vault calls fail](https://github.com/open-amt-cloud-toolkit/rps/issues/254):** Bug
- **[AMT Wi-Fi Configuration not supported on non-Windows systems](https://github.com/open-amt-cloud-toolkit/rps/issues/349):** Known Issue
- **[Use database abstraction/ORM layer to support multiple SQL-based database](https://github.com/open-amt-cloud-toolkit/rps/issues/414):** Enhancement
- **[Remove mpsRootCertificate parameter from createCiraConfig route](https://github.com/open-amt-cloud-toolkit/rps/issues/461):** Question
- **[Use database abstraction/ORM layer to support multiple SQL-based database](https://github.com/open-amt-cloud-toolkit/rps/issues/414):** Enhancement
#### MPS
- **[Direct Connection from MPS to AMT](https://github.com/open-amt-cloud-toolkit/mps/issues/10):** Enhancement
- **[Should return error on additional KVM connections for a single device](https://github.com/open-amt-cloud-toolkit/mps/issues/104):** Enhancement
- **[AMT does not connect to MPS after configuration](https://github.com/open-amt-cloud-toolkit/mps/issues/300):** Known Issue
- **[Audit Log calls never respond on specific versions of AMT](https://github.com/open-amt-cloud-toolkit/mps/issues/301):** Known Issue
- **[Use database abstraction/ORM layer to support multiple SQL-based database](https://github.com/open-amt-cloud-toolkit/mps/issues/360):** Enhancement
#### Sample Web UI
- **[UI always shows "Certificate Not Yet Uploaded"](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/483):** Question


