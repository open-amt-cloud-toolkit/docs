--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center;">
 <iframe width="800" height="450" src="https://www.youtube.com/embed/fpeqIevX7qw" title="Open AMT March Release Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

!!! note "Note From the Team"
    Hey everyone,

    Spring is here and so is a new Open AMT Cloud Toolkit release!  The team continues to add new features to support enterprise customers and with this release we start to deliver support for 802.1x networks.  In addition, we also have fixed several issues as well as added some quality of life improvements.  Check out the [release video](#release-highlights) where Madhavi talks about this release's highlights. You can find the details of this release under [what's new](#whats-new) section.

    The Open AMT Cloud Toolkit team has moved to [Discord](https://discord.gg/yrcMp2kDWh).  Come join the discussion!

    *Best wishes,*  
    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-star:** Database update required **
An upgrade to the `rpsdb` database is required.

[See Upgrade Toolkit Version docs for SQL scripts to add the new table and columns](../Deployment/upgradeVersion/).

:material-new-box:** New Feature: 802.1X Wired Configuration Support **

For devices deployed in a secure enterprise network, configuring AMT to authenticate with the network is important so that connection can be maintained with the device even when the OS is not available.  With this release, we now support configuring AMT with certificate based 802.1x configurations (EAP-TLS, PEAPv1/EAP-GTC, EAP-FAST/GTC, EAP-FAST/TLS).  [Find more information about 802.1x configuration here](../References/EA/ieee8021xconfig/). 

:material-hammer:** Fixed: AMT Activation Not Responding **

Occasionally, AMT would not respond when we sent a command during activation.  In order to resolve this issue, we have implemented a method for RPS to retry the previous request if AMT hasn't responded within 12 seconds (default).  This timing can be adjusted by changing the RPS `delay_timer` in the configuration file.

:material-api:** New Route: Support for 802.1x Profiles **

We have added new REST API calls to support CRUD operations for the new 802.1x profiles.  RPS will support multiple wired 802.1x profiles. However, only a single 802.1x wired profile is supported in an AMT profile.  This is a limitation of AMT.  [802.1x API documentation can be found here](../APIs/indexRPS/).

## Get the Details

### Additions, Modifications, and Removals

#### RPS
- 802.1x wired network configuration (#fba30d9) 
- handle missing AMT activation response ([#929](https://github.com/open-amt-cloud-toolkit/rps/issues/929)) (#5e82295) 
- updated error message on auth failure ([#933](https://github.com/open-amt-cloud-toolkit/rps/issues/933)) (#d6e09dc) 
- exclude test.js files from custom middleware (#ba6afd7) 
- required version for wirless patch ([#914](https://github.com/open-amt-cloud-toolkit/rps/issues/914)) (#70ff74f) 
- CIRA static password being saved to DB ([#909](https://github.com/open-amt-cloud-toolkit/rps/issues/909)) (#6a03292) 
- check cira config name for special characters ([#904](https://github.com/open-amt-cloud-toolkit/rps/issues/904)) (#3ce906a) 
- **state-machine:** add retry logic to TLS (#661814b) 

#### MPS
- add missing tenantid in deactivate call ([#841](https://github.com/open-amt-cloud-toolkit/mps/issues/841)) (#7724a60) 
- exclude test.js files from custom middleware (#fb5e1f2)

#### RPC
- **rps:** rpc will exit instead of hang when connection fails to rps
- **lme:** remove timer and use context

#### WSMAN-MESSAGES
v5.2.0

- **amt:** add 802.1x configuration support to AddWiFiSettings (#1d405ea) 
- centralized enums to a enums.ts file (#b6c932a) 

v5.1.0

- **amt:** add support for user account management (#3151b86) 

#### Sample Web UI
- **8021x:** functionality for wired configuration (#5edc297)  
- modified project config files for clashing global test definitions ([#1025](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/1025)) (#a2a5ce8) 

## Project Board
Check out our new [Feature Backlog](https://github.com/orgs/open-amt-cloud-toolkit/projects/5) project board to see issues and prioritized items we're working on across all of our repositories.  You'll also see what is coming in our next release!
