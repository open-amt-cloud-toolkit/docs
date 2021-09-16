--8<-- "References/abbreviations.md"
# Release Notes
Please see the [release announcements](announcements.md) for additional information regarding this release.

## Key Feature Changes for 2.0
This section outlines key features changes between versions 1.5 and 2.0 for Open AMT Cloud Toolkit.

### Additions, Modifications, and Removals
#### Breaking Changes
- tenantId is a new field in the db and all queries now require it
#### Open AMT Cloud Toolkit
- env.template: optimized reuse of settings
- postgres: removed postgres deployment from K8S, AKS, and EKS.  Recommend using managed DB service from cloud provided for these deployments
- postgres: enabled ssl communication for db connections
- deployment: added EKS deployment scripts (Amazon Elastic Kubernetes Service)
- deployment: added support for [Kuma](https://konghq.com/blog/introducing-kuma-universal-service-mesh/) service mesh.  This enables MTLS between containers to enhance security as well as adding additional productivity capabilities.
#### RPS
- ciraconfig: allow null values for ciraconfigname in profile edit (#f3b2659)
- multitenancy: add support for multiple tenants (#bbbdf95)
- multitenancy: device creation with MPS now includes tenantId (#e01cd79)
- activation: update client response message (#23a7a0b)
- activation: now device is saved after activation in acm ([#416](https://github.com/open-amt-cloud-toolkit/rps/issues/416)) (#c1b02f4)
- mqtt: adds activation success message (#cfd6a34)
- network: now removes all the profiles with priority 0 ([#424](https://github.com/open-amt-cloud-toolkit/rps/issues/424)) (#b00e6a9)
- network: get wifi passphrase from vault ([#409](https://github.com/open-amt-cloud-toolkit/rps/issues/409)) (#35532d2)
- wireless: Updated passphrase key name in vault to sync with other keys ([#419](https://github.com/open-amt-cloud-toolkit/rps/issues/419)) (#313daa2)
#### MPS
- api: added api for request, cancel and send user consent code to AMT ([#332](https://github.com/open-amt-cloud-toolkit/mps/issues/332)) (#e4fbe58)
- api: cert now pulls from config instead of disk (#d9e04e3)
- multitenancy: add multi tenancy support (#4e323c8)
- docs: updated swagger documentation (#7aee48a)
#### RPC
- security: update to OpenSSL 1.1.1l
- wireless: add AMT wireless adapter info to amtinfo LAN settings.
- refactor: format json status messages
#### Sample Web UI
- amtfeatures: replaced enabled features box to work with checkboxes (#8a86c9f)
- ciraconfig: allow clearing out cira config in profile (#abf0bee)
- dashboard: add wireless config link to dashboard page (#5b4c61c)
- device: now displays AMT FW and Provisioning Mode (#fdd439a)
- devices: add power status to device list (#1b58bac)
- notification: updated power actions notifications and resolved merge conflicts ([#390](https://github.com/open-amt-cloud-toolkit/rps/issues/390)) (#5610e60)
- pagesize: updated page size options (#5b8b624)
- paging: implemented paging for cira, domains, devices, profiles and wifi ([#370](https://github.com/open-amt-cloud-toolkit/rps/issues/370)) (#bfc554d)
- userconsent: a dialog to enter user consent code ([#395](https://github.com/open-amt-cloud-toolkit/rps/issues/395)) (#269d1e2)
- errors: show better error messages for deleting associated ciraconfig and wifi config (#e4651c8)
- profile: fix no wifi config found message on input focus (#3802ea5)
- wireless: table now hidden when no data (#ce50bca)

## Resolved Issues in this release
#### Intel&reg; AMT
- **Intel&reg; AMT device fails to re-connect to MPS after MPS is not available for an extended period of time:** We have added this issue to our troubleshooting documentation
#### Open AMT Cloud Toolkit
- **[Power policy should be selected at BIOS under Intel®ME Power Control screen -Mobile: On in So, MEWake in S3, S4-5 –Power Package 2 for performing device poweron/off operations](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/19)**
- **[Scaling- KVM shows white screen](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/39)**
- **[Scaling- Connecting to SOL does not work correctly](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/40)**
#### RPS
- **[Wi-Fi config: Intel AMT system disconnects from mps stack after powering off the device](https://github.com/open-amt-cloud-toolkit/rps/issues/350)**
- **[Software Event Notifications](https://github.com/open-amt-cloud-toolkit/rps/issues/9)**
#### MPS
- **[AMT 12 dropping CIRA when sending command while system is off](https://github.com/open-amt-cloud-toolkit/mps/issues/196)**
- **[MPS API /ciracert always reads from file](https://github.com/open-amt-cloud-toolkit/mps/issues/294)**
#### UI-Toolkit
- **KVM freeze intermittently:** We have root caused and implemented the fix in the UI-Toolkit KVM module.
#### Sample-Web-UI
- **[AMT Responses should return status (i.e. NOT_READY) instead of "Sent Succesfully"](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/276)**
- **[Can't clear out CIRA config once selected in AMT Profile](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/367)**
- **[WiFi Profiles drop-down says "No Wifi configs found" before typing anything](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/368)**

## Open Issues in 2.0
#### RPS
- **[RPS should support wildcard domain suffix](https://github.com/open-amt-cloud-toolkit/rps/issues/97):** Enhancement
- **[Data shouldn't be added if vault calls fail](https://github.com/open-amt-cloud-toolkit/rps/issues/254):** Bug
- **[AMT Wi-Fi Configuration not supported on non-Windows systems](https://github.com/open-amt-cloud-toolkit/rps/issues/349):** Known Issue
- **[MQTT messaging needs to be updated for some of the events](https://github.com/open-amt-cloud-toolkit/rps/issues/381):** Enhancement
- **[Use database abstraction/ORM layer to support multiple SQL-based database](https://github.com/open-amt-cloud-toolkit/rps/issues/414):** Enhancement
#### MPS
- **[Direct Connection from MPS to AMT](https://github.com/open-amt-cloud-toolkit/mps/issues/10):** Enhancement
- **[Should return error on additional KVM connections for a single device](https://github.com/open-amt-cloud-toolkit/mps/issues/104):** Enhancement
- **[AMT does not connect to MPS after configuration](https://github.com/open-amt-cloud-toolkit/mps/issues/300):** Known Issue
- **[Audit Log calls never respond on specific versions of AMT](https://github.com/open-amt-cloud-toolkit/mps/issues/301):** Known Issue
- **[Use database abstraction/ORM layer to support multiple SQL-based database](https://github.com/open-amt-cloud-toolkit/mps/issues/360):** Enhancement


