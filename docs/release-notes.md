--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center;">
 <iframe width="800" height="450" src="https://www.youtube.com/embed/lPTgxAab0cQ" title="Open AMT May Release Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

!!! note "Note From the Team"
    Hey everyone,

    May has flown by and we have a whole set of improvements based on issues filed by our customers! You will also notice that instead of one monthly release, each component has several releases this month.  As our team continues to improve our release process this will be the new norm: continuous releases throughout the month with a roll-up announcement at the beginning of the following month.  Check out the release video where Bryan talks about the highlights from this month and see below for changes in each component.

    The Open AMT Cloud Toolkit team has moved to [Discord](https://discord.gg/yrcMp2kDWh).  Come join the discussion!

    *Best wishes,*  
    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-star:** Database update required **
An upgrade to the `rpsdb` database is required. Please run the following SQL script to add the new column and constraint before upgrading the services:

``` sql
ALTER TABLE IF EXISTS profiles
ADD COLUMN IF NOT EXISTS ip_sync_enabled BOOLEAN NULL;
```

[More information or detailed steps can be found in Upgrade Toolkit Version](../Deployment/upgradeVersion/).

:material-new-box:** New Feature: Local configuration via RPC **

We have heard from some of our customers that they would prefer to have more direct control over configuring AMT features.  To support his request, we have added a new capability to RPC: Local Configuration.  You will now be able to configure some features of AMT without going through RPS.  This is great for configuring AMT the device is not able to connect to RPS.  The first two configuration options that make use of this feature are a new maintenance command "addwifisettings" and a new deactivate option using the "-local" flag.  

:material-new-box:** New Feature: IP Sync option in AMT Profile **

We have exposed a new option in our AMT profile to allow customers who are using static IP addresses to not have the IP address of AMT synced with the host OS during configuration of AMT.

:material-hammer:** Fixed: PXE and BIOS boot control ***

Enabling boot control for booting to BIOS and PXE should now work again!

:material-new-box:** New Feature: Delete device secrets **

We've added a new query parameter to the MPS delete device API call that will instruct MPS also delete the secrets associated with the device (AMT Password, MEBx Password, etc).  Take care using this especially if you are using randomly generated passwords as once they are removed from the secret store, there is no recovery and getting access to AMT again may require clearing the system CMOS.

## Get the Details

### Additions, Modifications, and Removals

#### RPS
v2.11.0
- add/expose ipSyncEnabled in amt profile for wired interface ([#890](https://github.com/open-amt-cloud-toolkit/rps/issues/890)) (#314632a)

#### MPS
v2.9.0
- added a query param to delete device from secrets ([#854](https://github.com/open-amt-cloud-toolkit/mps/issues/854)) (#3e8512a)
v2.8.4
- changes to reset to PXE ([#752](https://github.com/open-amt-cloud-toolkit/mps/issues/752)) (#4da936b)
v2.8.3
- update kvmConnect property on CIRA connection close ([#888](https://github.com/open-amt-cloud-toolkit/mps/pull/888)) (#37307fe)
- Device deletion request from RPS ([#886](https://github.com/open-amt-cloud-toolkit/mps/pull/886)) (#dd483d6)

#### RPC
v2.9.0
- cli: addwifisettings directly without cloud interaction ([#117](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/117))
v2.8.0
- deactivate a device in CCM from RPC ([#92](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/92))

#### WSMAN-MESSAGES
v5.4.0
- cim: enables clearing BootConfigSetting (37fd792)
v5.3.2
- handle empty data in protectedPut ([#466](https://github.com/open-amt-cloud-toolkit/wsman-messages/issues/466)) (efc33d3)
v5.3.1
- resolves issue in protectedPut default parameter ([#463](https://github.com/open-amt-cloud-toolkit/wsman-messages/issues/463)) (7ee3cee)
v5.3.0
- amt: adds AddKey call to PublicKeyManagementService ([#461](https://github.com/open-amt-cloud-toolkit/wsman-messages/issues/461)) (8d739c2)

#### Sample Web UI
v2.9.1
- url encode get and delete REST path params ([#1144](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/1144)) (#8262ba5)
v2.9.0
- add/expose ipSyncEnabled in amt profile for wired interface (#1123) (#3625bcd)

## Project Board
Check out our new [Feature Backlog](https://github.com/orgs/open-amt-cloud-toolkit/projects/5) project board to see issues and prioritized items we're working on across all of our repositories.  You'll also see what is coming in our next release!
