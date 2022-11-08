--8<-- "References/abbreviations.md"
## Release Highlights

<!-- <div style="text-align:center;">
 <iframe width="800" height="450" src="https://www.youtube.com/embed/gTDXOdsCRZk" title="Open AMT v2.5 Release Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br> -->

!!! note "Note From the Team"
    Hey everyone,

    Very quick and small release this week to deliver some new features and fixes!  Going forward, we'll be moving to a monthly cadence for Open AMT Cloud Toolkit with sub components releasing when they have features or fixes ready.  Our hope is that users of the Open AMT Cloud Toolkit will see the features they need delivered even faster.  In order to manage the overhead involved with this faster release cadence, we'll be moving to a monthly roll-up and release announcement starting at the end of November where we will summarize all of the releases during the previous month.  You can find the details of this release under [what's new](#whats-new) section.

    *Best wishes,*  
    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-new-box:** Feature: AMT Maintenance commands **

Three new maintenance commands have been added to RPC and RPS to support syncing the AMT Clock, syncing the IP settings, and changing the AMT password.

:material-star:** Customer Request: Unprovision AMT devices via MPS **

We've had several customer requests to add this feature to MPS and this release we are delivering.  We've added an API endpoint ( DELETE /api/v1/amt/deactivate/{guid} ) to MPS that will send the unprovision command to a connected AMT device and will then remove that AMT device from the MPS database.  In order to reconnect that AMT device to MPS again, RPC and RPS will need to be used.

:material-star:** Customer Request: Enable local Wi-Fi network synchronization by default **

We have updated RPS to enable AMT to sync Wi-Fi networks automatically if a local management service (LMS) is running.  This means if a user connects to a wireless network in the OS, this wireless network will automatically be synced to AMT.  When the OS is down, AMT will use this wireless network to connect to the network so that the device can be remotely managed.

## Get the Details

### Additions, Modifications, and Removals

#### RPS
- **appversion:** adds appversion to version api (#2fc8e01)
- **maintenance:** adds syncip command to the maintenance task ([#740](https://github.com/open-amt-cloud-toolkit/rps/issues/740)) (#036553b)
- **activation:** adds mebx password to secret provider on reconfigure (#03c47c5)
- **domains:** allow subdomains w/ matching root domain (#dacc97c)
- **amtPwd:** update to generate random password if not provided (#743) (#a3c3f26)
- **network:** by default enables local profile synchronization for wifi (#329f0bb)
- see change log for full list of changes

#### MPS
- **api:** add endpoint to unprovision devices ([#720](https://github.com/open-amt-cloud-toolkit/mps/issues/720)) (#6cab674)
- **serviceVersion:** adds version api endpoint (#02d064f)
- **amt features:** corrected CIM_KVMRedirection enum comparison (#1b9c864)
- **api:** remove hard limit of 25 from stats route (#a54e10e)
- **mps:** made secret manager hot swappable ([#709](https://github.com/open-amt-cloud-toolkit/mps/issues/709)) (#bc74c2c)
- see change log for full list of changes

#### RPC
- **maintenance:** add subcommands for syncip, syncclock, and changepassword
- **fix:** channel recipient channel should not be 0
- **fix:** remove extra log.error statement
- see change log for full list of changes

#### WSMAN-MESSAGES
- **amt:** update provisioning mode and set oemid optional (#276be25)
- **cim:** add 32768 and 32769 allowed values for wifiport (#0bd937e)
- **fix:** adds typed inputs to functions (#b30cb86)
- **enum:** rename MEBX_PASSWORD to PASSWORD (#6c61486)
- **BREAKING CHANGE:** Moved WiFiEndpointSettings to cim/models.  remove redundant models.  add tsdoc comments (#ed768fb)
- see change log for full list of changes

## Resolved Issues
#### Open AMT Cloud Toolkit
[Closed issues](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues?q=is%3Aissue+is%3Aclosed)
#### RPS
[Closed issues](https://github.com/open-amt-cloud-toolkit/rps/issues?q=is%3Aissue+is%3Aclosed)
#### MPS
[Closed issues](https://github.com/open-amt-cloud-toolkit/mps/issues?q=is%3Aissue+is%3Aclosed)
#### RPC
[Closed issues](https://github.com/open-amt-cloud-toolkit/rpc-go/issues?q=is%3Aissue+is%3Aclosed)
#### MPS Router
[Closed issues](https://github.com/open-amt-cloud-toolkit/mps-router/issues?q=is%3Aissue+is%3Aclosed)
#### Sample Web UI
[Closed issues](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues?q=is%3Aissue+is%3Aclosed)
#### UI Toolkit
[Closed issues](https://github.com/open-amt-cloud-toolkit/ui-toolkit/issues?q=is%3Aissue+is%3Aclosed)
#### WSMAN-MESSAGES
[Closed issues](https://github.com/open-amt-cloud-toolkit/wsman-messages/issues?q=is%3Aissue+is%3Aclosed)

## Open Issues and Requests
#### Open AMT Cloud Toolkit
[Open issues](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues)
#### RPS
[Open issues](https://github.com/open-amt-cloud-toolkit/rps/issues)
#### MPS
[Open issues](https://github.com/open-amt-cloud-toolkit/mps/issues)
#### RPC
[Open issues](https://github.com/open-amt-cloud-toolkit/rpc-go/issues)
#### MPS Router
[Open issues](https://github.com/open-amt-cloud-toolkit/mps-router/issues)
#### Sample Web UI
[Open issues](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues)
#### UI Toolkit
[Open issues](https://github.com/open-amt-cloud-toolkit/ui-toolkit/issues)
#### WSMAN-MESSAGES
[Open issues](https://github.com/open-amt-cloud-toolkit/wsman-messages/issues)
