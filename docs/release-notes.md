--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center;">
 <iframe width="800" height="450" src="https://www.youtube.com/embed/GSrKSqvywtQ" title="Open AMT June Release Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

!!! note "Note From the Team"
    Hey everyone,

    June has brought a bunch of great changes to Open AMT Cloud Toolkit.  We completed the major configuration options to support 802.1x, we made quality of life improvements for our customers, and we squashed several bugs!  Check out the release video where Bryan talks about the highlights from this month and see below for changes in each component.

    The Open AMT Cloud Toolkit team has moved to [Discord](https://discord.gg/yrcMp2kDWh).  Come join the discussion!

    *Best wishes,*  
    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-new-box:** New Feature: PEAP-MSCHAPv2 support **

We've added support for PEAP-MSCHAPv2 in our 802.1x configuration options for both wired and wireless.  To integrate PEAP-MSCHAPv2 authentication into your setup, set authentication protocol to 2, in your 8021x profile.

``` json
{
  "profileName": "wired8021xConfig",
  "authenticationProtocol": 2,
  "pxeTimeout": 120,
  "wiredInterface": true,
  "tenantId": ""
}
```

:material-new-box:** New Feature: Friendly name **

All devices now support the ability to add a friendly name.  You can add this via the MPS Devices API command:

``` json
{
  "guid": "123e4567-e89b-12d3-a456-426614174000",
  "hostname": "AMTDEVICENUC1",
  "friendlyName": "store12pos2"
}
```

 or during configuration by passing in the -name parameter to RPC:

 ``` bash
rpc activate -u wss://server/activate -profile profilename -name store12pos2
 ```

friendlyName has been added as a query parameter to the MPS Devices GET call as well.

:material-new-box:** New Feature: AMT SKU Decode:

RPC-Go AMTINFO command now decodes the AMT SKUing information and will output if the device is AMT or Intel Standard Manageability as well as other SKUing information.

:material-hammer:** Fixed: Audit Log **

We have reversed the order in which Audit Logs are returned, now returning the newest Audit Logs first.

:material-hammer:** Fixed: MPS API Calls after Password Change **

A customer reported an issue where after changing the password for an AMT device, MPS was not getting the new password and calls to AMT from MPS were failing.  This issue should now be resolved.

:material-hammer:** Fixed: Wireless Profile configuration improvements **

We discovered an issue where when configuring multiple wireless profiles, if one of the profiles failed to be configured in AMT, we would skip configuration of any remaining wireless profiles.  We have fixed this issue so that if a wireless profile fails to configure, we will continue to configure the remaining profiles.

## Get the Details

### Additions, Modifications, and Removals

#### RPS

v2.13.0

- adds MSCHAPv2 configuration for wired and wireless ([#1070](https://github.com/open-amt-cloud-toolkit/rps/issues/1070)) (#3fd7865) 
- upated network status message ([#1080](https://github.com/open-amt-cloud-toolkit/rps/issues/1080)) (#972293b) 

v2.12.1

- ensure req.tenantId is defaulted to blank (#30a5259) 

v2.12.0

- support device friendly name ([#1059](https://github.com/open-amt-cloud-toolkit/rps/issues/1059)) (#91376f0) 

#### MPS

v2.10.1

- mps audit logs now in order ([#949](https://github.com/open-amt-cloud-toolkit/mps/issues/949)) (#cc4fb04) 
- default tenantId is now blank (#ffff3b4) 

v2.10.0

- support device friendly name ([#948](https://github.com/open-amt-cloud-toolkit/mps/issues/948)) (#7a41961) 

v2.9.1

- refresh amt pw after pw change ([#927](https://github.com/open-amt-cloud-toolkit/mps/issues/927)) (#ce8eee4) 

#### RPC

v2.10.0

- adds AMT Features to amtinfo
- support device friendly name

#### Sample Web UI

v2.12.0

- upgraded to angular 16 (#96a5e0a) 

v2.11.0

- add MSCHAPv2 for wired and wireless (#a15e858) 

v2.10.0

- support device friendly name (#170f874)
- mps audit log now in order ([#1166](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/1166)) (#be219a3) 

## Project Board

Check out our new [Feature Backlog](https://github.com/orgs/open-amt-cloud-toolkit/projects/5) project board to see issues and prioritized items we're working on across all of our repositories.  You'll also see what is coming in our next release!
