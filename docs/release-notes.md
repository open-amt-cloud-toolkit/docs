--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center;">
 <iframe width="800" height="450" src="https://www.youtube.com/embed/gTDXOdsCRZk" title="Open AMT v2.5 Release Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

!!! note "Note From the Team"
    Hey everyone,

    We are very excited to release Open AMT Cloud Toolkit version 2.5. For this release, the team has been focused on improving our activation and configuration flows in RPS by implementing [xstate](https://xstate.js.org/). This state machine implementation makes handling and updating the many different options for activating and configuring Intel® AMT much more simple. Additionally, it helps provide more robust error messaging during activation to understand why an activation may fail. Our community contributors should really enjoy this change. Speaking of community contributors, the team would like to recognize and thank Orin Eman of [Laplink](https://everywhere.laplink.com/) for adding the new Alarm Clock feature to the Toolkit. This feature adds an API to set a one time or periodic wake up alarm clock in AMT. This is valuable if you want to have one or more devices wake up at a specific time every day. You can find more details under [what's new](#whats-new) section which outlines key features added to this release. Also, If you haven't had a chance yet, I encourage you to watch the release video where Mike provides some highlights from this release.

    *Best wishes,*  
    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-star:** Community Contribution: Intel® AMT Alarm Clock Feature**

Both WSMAN-Messages and MPS now support setting both one-time and periodic wake-up alarms in AMT. To demonstrate the new API, the Sample Web UI offers a new control on the device page, allowing a user to set alarm clocks for a given device. Thank you Orin Eman from [Laplink](https://everywhere.laplink.com/) for this community contribution.

:material-new-box:** Improvement: State Machine for Activation and Configuration**

In an effort to continuously improve Open AMT Cloud Toolkit, the team overhauled the activation and configuration flows inside of RPS. Utilizing [xstate](https://xstate.js.org/), we modularized each of the configuration actions so they can be called as needed by the state machine. This will add increased robustness to complex configuration flows as well as make it easier to add new configuration options in the future.

:material-new-box:** Customer Request: Set AMT Features During Configuration **

We have updated the AMT Profile API to include options for setting Redirection, User Consent, SOL, IDE-R, and KVM. Setting these in the profile will override the default AMT settings with the preferred settings from the profile at configuration time.

:material-new-box:** Improvement: Certificate Authentication in Domain Profile**

When creating a domain profile, we now validate that the password provided for the provisioning certificate works for the provided provisioning certificate. This allows users to fix an incorrect password entry instead of getting a failure during activation.

:material-new-box:** Improvement: RPC Quality of Life Improvements**

We have added several quality of life improvements to RPC. AMTINFO command now displays only the network adapter information that is available in the system instead of showing wireless if wireless is not present (and vice versa). Added an admin privilege check and AMT not found check. Added warnings if link status is down or dns suffix is not populated. We replaced our log.Fatal with log.Error and have replaced our os.Exit calls on error to allow better usability when RPC is compiled as a library.

:material-star:** Coming Soon: Deactivate AMT without deploying RPC and new Maintenance Options**

In our next release, we are enhancing our MPS delete devices API to deactivate AMT as well as removing it from the MPS database. This is a customer feature request to help with decommissioning or transferring devices out of service. We will also be adding additional AMT Maintenance commands to RPC that will help keep AMT updated and running smooth.

## Get the Details

### Additions, Modifications, and Removals
#### Open AMT Cloud Toolkit
- **docker-compose:** allow docker-compose pull to work with db (#16f5946)

#### RPS
- **domains:** cert password authentication on submit (#e0c068e)
- **profile:** adds amt features config state machine ([#706](https://github.com/open-amt-cloud-toolkit/rps/issues/706)) (#a778930)
- **fix:** certManager filename causing build failure in docker (#ce555dc)
- **api:** create endpoints now rollback db if vault fails (#99b2b56)
- **cira:** deletes certificates when unconfiguring previous settings ([#673](https://github.com/open-amt-cloud-toolkit/rps/issues/673)) (#0fd112b)
- **profile features:** corrected CIM_KVMRedirection enum comparison ([#711](https://github.com/open-amt-cloud-toolkit/rps/issues/711)) (#1245cb5)
- **activation:** adds specific error message to provision cert ([#727](https://github.com/open-amt-cloud-toolkit/rps/issues/727)) (#4bb6e11)
- **activation:** adds xstate framework for activation (#5e00101)
- **cira:** cira config uses xstate ([#698](https://github.com/open-amt-cloud-toolkit/rps/issues/698)) (#21a2792)
- **config:** remove unnused amtusername (#9b6044b)
- **deactivation:** update error message (#204299c)
- **deactivation:** adds checks for secret provider responses ([#730](https://github.com/open-amt-cloud-toolkit/rps/issues/730)) (#55791e4)
- **deactivation:** adds xstate framework for deactivation (#9f1b25e)
- **interfaces:** remove unused refactored code ([#694](https://github.com/open-amt-cloud-toolkit/rps/issues/694)) (#82dc0ee)
- **maintenance:** uses xstate for maintenance tasks ([#693](https://github.com/open-amt-cloud-toolkit/rps/issues/693)) (#50f8aa8)
- **networkConfiguration:** adds xstate framework to network configuration (#49a8b92)
- **reconfigure:** updated to reconfigure a device ([#712](https://github.com/open-amt-cloud-toolkit/rps/issues/712)) (#4b1de24)
- **status:** formats network status message (#cf76d89)
- **test:** adds unit tests to activation state machine ([#697](https://github.com/open-amt-cloud-toolkit/rps/issues/697)) (#25c5bcb)
- **tls:** tls configuration now uses xstate (#9a4d93b)
- see change log for full list of changes

#### MPS
- **feat:** adding AMT Alarm Clock APIs to MPS (#05be999)
- **fix:** updated wsman-messages to 2.4.0 (#8213ecb)
- **fix:** log CIRA channel open failure at 'error' rather than 'silly' level (#0777d33)
- **fix:** powerAction and powerCapabilites now transpile without errors (#2ed5337)
- **mps:** tls cipher selection ([#634](https://github.com/open-amt-cloud-toolkit/mps/issues/634)) (#54b0c5e)
- see change log for full list of changes

#### RPC
- **feat:** add warnings for link status and dns suffix
- **feat:** added admin privilege check and AMT not found error check
- **amtinfo:** display wired only when wired adapter is available
- **amtinfo:** shouldnt display warnings on amtinfo
- **tls:** tls configuration now completes after TLS configuration
- **return codes:** replace log.Fatal with log.Error replace os.Exit calls
- **status:** attempt to unmarshal error message
- see change log for full list of changes

#### UI Toolkit
- **fix:** issue 332 - A-Z and space not being sent over SOL (#96f80f7)
- **peer-deps:** correct the peer dependencies to react 16 from 18 (#e1a966e)
- see change log for full list of changes

#### Sample Web UI
- **feat:** support Alarm Service APIs ([#802](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/802)) (#ac16d71) 
- **amtprofilefeatures:** re-enable profile features (#74ef37a) 
- **fix:** icons now display correctly on dashboard (#e604379) 
- **build:** build now uses production config for docker (#01b1b5d) 
- **device:** corrects device deactivation command (#2466b25) 
- **kvm:** user consent code on enter was sending cancel (#f8b6b62) 
- **profile-detail:** cira profile is now selected on edit when static network is selected (#3cbf793) 
- **refactor:** fix warnings and update angular ([#863](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/863)) (#bce1893) 
- see change log for full list of changes

#### WSMAN-MESSAGES
- **api:** support for AMT_AlarmClockService and IPS_AlarmClockOccurrence (#e53e1d6)
- **fix:** encode wifi passcode to escape '&<>" (#e1356d6)
- see change log for full list of changes

## Resolved Issues
#### RPS
- **[Data shouldn't be added if vault calls fail](https://github.com/open-amt-cloud-toolkit/rps/issues/254):** Bug
- **[Support Intel AMT Alarm Clock feature](https://github.com/open-amt-cloud-toolkit/rps/issues/524):** Enhancement - implemented in MPS
#### MPS
- **[Strange compilation errors](https://github.com/open-amt-cloud-toolkit/mps/issues/657):** Bug
#### RPC
- **[Occasionally Receive APF_CHANNEL_OPEN_FAILURE](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/55):** Bug
#### UI Toolkit
- **[Command string generated from "Add a New Device" dialog does not activate a machine.](https://github.com/open-amt-cloud-toolkit/ui-toolkit/issues/451):** Bug
#### WSMAN-MESSAGES
- **[Certain WiFi pass phrases can result in invalid XML](https://github.com/open-amt-cloud-toolkit/wsman-messages/issues/213):** Bug

## Open Issues and Requests
#### Open AMT Cloud Toolkit
- **[Kustomize Install](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/103):** Enhancement
- **[Support for MongoDB in addition to PostgreSQL](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/117):** Enhancement
- **[Are there plans to support OCR??](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/133):** Enhancement
- **[v2.3.0 docker-compose.yml is using the latest tag for the docker images](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/129):** Tech-Debt
- **[Semantic Pull Request failures](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/138):** Known Issue
#### RPS
- **[RPS should support wildcard domain suffix](https://github.com/open-amt-cloud-toolkit/rps/issues/97):** Enhancement
- **[Use database abstraction/ORM layer to support multiple SQL-based database](https://github.com/open-amt-cloud-toolkit/rps/issues/414):** Enhancement
- **[Poor error msg related WiFi profile issues](https://github.com/open-amt-cloud-toolkit/rps/issues/594):** Enhancement
- **[Any plans for a MutualTLS implementation?](https://github.com/open-amt-cloud-toolkit/rps/issues/656):** Enhancement
- **[Reconfiguring an AMT device (without unprovisioning) fails for TLS Profiles](https://github.com/open-amt-cloud-toolkit/rps/issues/663):** Bug
- **[TLS Config/self signed cert not creating on edit of AMT profile](https://github.com/open-amt-cloud-toolkit/rps/issues/690):** Bug
- **[Feature Request: Add option to Profiles to enable/disable Wireless Local User Profile Synchronization](https://github.com/open-amt-cloud-toolkit/rps/issues/728):** Enhancement
#### MPS
- **[AMT does not connect to MPS after configuration](https://github.com/open-amt-cloud-toolkit/mps/issues/300):** Known Issue
- **[Use database abstraction/ORM layer to support multiple SQL-based database](https://github.com/open-amt-cloud-toolkit/mps/issues/360):** Enhancement
- **[MPS should wait for vault to be unsealed - CIRA connections fail](https://github.com/open-amt-cloud-toolkit/mps/issues/614):** Enhancement
- **[Feature requested: Add support and API to initiate remote unprovisioning](https://github.com/open-amt-cloud-toolkit/mps/issues/666):** Enhancement
- **[Copy/paste error in src/routes/amt/getHardwareInfo.ts](https://github.com/open-amt-cloud-toolkit/mps/issues/655):** Investigate
- **[Exception in parseBody (parseWSManResponseBody.ts)](https://github.com/open-amt-cloud-toolkit/mps/issues/661):** Investigate
- **[Writes to CIRA channel must not split a final '0\r\n\r\n' when chunked encoding is involved](https://github.com/open-amt-cloud-toolkit/mps/issues/662):** Investigate
- **[Exceptions in mps due to limited AMT resources](https://github.com/open-amt-cloud-toolkit/mps/issues/664):** Known Issue
- **[getAMTFeatures and setAMTFeatures both fail if KVM not supported](https://github.com/open-amt-cloud-toolkit/mps/issues/668):** Bug
- **[MPS Stats Total counter is capped at 25 devices](https://github.com/open-amt-cloud-toolkit/mps/issues/687):** Investigate
#### RPC
- **[activation failures would benefit from passing the RPS error code to the client](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/27):** Enhancement
- **[Gosh it would be excellent if rpc could tell the user that they don't have an AMT compatible network device](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/28):** Enhancement
- **[Library build of rpc-go should use return codes](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/57):** Enhancement
#### Sample Web UI
- **[UI always shows "Certificate Not Yet Uploaded"](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/483):** Enhancement
- **[Tests fail if RPS server isn't localhost](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/808):** Good First Issue
