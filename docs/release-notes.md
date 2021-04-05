# Release Notes

If you haven't had a chance - checkout the [Letter From Devs](./letter.md) for a message from our development team.
## Key Feature Changes for 1.2
This section outlines key features changes between versions 1.1 and 1.2 for [Open Active Management Technology (Open AMT) Cloud Toolkit.](Glossary.md#o) 

### Additions
#### [RPS](Glossary.md#r)
- **Hostname and Device Metadata tags:** We have added the ability to define metadata tags for a each Intel&reg; AMT profile.  These tags will be applied to each device that is configured using the profile.  Additionally, if RPC sends up the Intel&reg; AMT device OS hostname during activation, RPS will save this information as part of the device information.  When RPS configures a device, it will perform a POST call to MPS to register that device in MPS.  This works in conjunction with the improved metadata gathering that RPC added in 1.1.
- **Node 14 LTS support:** RPS has been updated to support running on Node 14 LTS. 

#### [RPC](Glossary.md#r)
- **Docker support added:** Added a dockerfile to RPC that allows customers to build and execute RPC in a docker container on the Intel&reg; AMT device.


#### [MPS](Glossary.md#m)
- **PostgreSQL integration added to MPS:** To support additional metadata we are adding to MPS, we have added a PostgreSQL reference implementation to MPS.
- **Hostname and Device Metadata tags:** MPS will store device hostname and metadata tag information it receives from RPS in its PostgreSQL DB.  When device information calls are made, the device hostname will be returned to the caller along with the other device information previously provided.  Additionally, the GET devices call now supports an additional tags field (comma-delimited list) that will filter the devices based on the set of tags provided.  This greatly improves scaling of this call with very large number of devices as well as reduces the need for filtering on the caller's side.
- **Node 14 LTS support:** RPS has been updated to support running on Node 14 LTS. 
- **MPS Scaling *preview* feature:** We've added a scaling configuration feature to MPS that will allow MPS to scale up multiple instances of MPS in a Kubernetes environment to support large deployments.  Both the CIRA connection side and the REST API side of MPS can be scaled up independently.  When an MPS instance goes down, Intel&reg; AMT device connections will be automatically reconnected to a different instance of MPS and the route to that device will be automatically updated.  The current implementation is designed to run in an Azure Kubernetes Service behind a load balancer.  As scaling is a preview feature, it currently doesn't support socket based Intel&reg; AMT connections (KVM and SOL) or the new Metadata (hostnames and tags) feature.  Other features such as PowerAction, HardwareInfo, EventLog, etc should all function in scaling mode.  We expect to have all AMT features supported in scaling mode in the 1.3 release.

#### [Sample UI](Glossary.md#s)
- **New look & feel** The Sample UI has had a full rewrite in the 1.2 release based on much feedback from our customers.  This updated UI supports the new hostname and metadata tag features.  While this is still just a reference implementation to showcase the features of the MPS and RPS components, this restructuring of the Sample UI will:
    * Aid developers as an example of how to use our APIs 
    * Help understand the value of Open AMT Cloud Toolkit.

### Modifications and Removals
#### [RPS](Glossary.md#r)
- **RPS API changes** We have performed some fundamental restructuring of the RPS REST APIs to better align with industry RESTful API standards.  With these changes you'll see a greatly simplified structure, error messages in proper JSON structure, consistent property names across request/response, and correct HTML status codes being returned.  *This is a breaking change for customers who have already implemented against the 1.1 API.*
#### [UI Toolkit](Glossary.md#u)
- **Deprecation announcement of non-socket UI Toolkit components:** We are removing the following UI Toolkit components in the 1.3 release: Audit Log, CIRA Config, Device Grid, Domain, and Profile.  All of these components are just UI implementations of our existing REST APIs and the need for a REACT component for these items is overkill.  We will continue to support and maintain the REACT components for KVM and SOL.  Additionally, we have plans on expanding the KVM and SOL components to support additional UI frameworks beyond REACT.
#### [MPS](Glossary.md#m) & [RPS](Glossary.md#r)
- **Deprecation announcement of Developer Mode for both RPS and MPS** We are making lots of strides in improving production mode deployments through the use of deployment scripts and docker containers.  Due to this work, the need for a "simple" developer deployment mode that doesn't use Vault or PostgreSQL is no longer required.  As such, we'll be removing this mode prior to our 1.4 release.  After the removal of developer mode, Vault and PostgreSQL will be required by default but the docker deployment scripts we have will make getting these services up and running easy.  Customers will still have the option to modify the Vault and PostgreSQL interfaces to point to the database service(s) of their choice.

## Resolved Issues
- **Vault Deployment:** When deploying in production, customers will want to run Vault in production mode.  We have added instruction on how to configure this [here](https://open-amt-cloud-toolkit.github.io/docs/1.2/Docker/dockerLocal_prodVault/).
- **Intel&reg; AMT connection to MPS reliability after configuration:**  We have added a small delay between when Intel&reg; AMT is activated and CIRA is configured that resolves the connection issues we were seeing in 1.1.

## Known Issues in 1.2
- **Intel&reg; AMT device fails to re-connect to MPS after MPS is not available for an extended period of time:** *UPDATE: There is a firmware fix available for this issue, however, we are still testing to ensure that it completely resolves this issue.  We'll let you know once this issue is resolved.*  If the MPS goes down for more than 2 days, Intel&reg; AMT devices will no longer attempt to connect to MPS. If this happens, there are two ways to prompt Intel&reg; AMT to attempt to re-connect to MPS:
    1.	Unplug and re-plug the network cable
    2.	Reboot the Intel&reg; AMT device

- **KVM freeze intermittently** Viewing a remote desktop with high amount of screen changes (video playback), the KVM session can intermittently freeze.
- A full list of current open issues can be found in the issues page for each repository