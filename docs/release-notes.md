--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center;">
 <iframe width="800" height="450" src="https://www.youtube.com/embed/PUSIp2Wx9Kc" title="Open AMT July Release Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

!!! note "Note From the Team"
    
    Hey everyone,

    We're in the depths of summer here in Arizona, so nothing to do but stay inside and write code!  This month we continue to expand our RPC-Go activation and deactivation features and we add a new optional service to assist with configuration.  Check out the video above where Bryan talks about these new features.

    The Open AMT Cloud Toolkit team has moved to [Discord](https://discord.gg/yrcMp2kDWh).  Come join the discussion!

    *Best wishes,*  
    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-new-box: **New Feature: Local Activation and Deactivation**

With this release, you can now activate AMT into CCM just using RPC using the `-local` flag.  We've also expanded our deactivation feature to include devices activated in ACM.  RPC can now deactivate both CCM and ACM configured devices without needing RPS. 

Local activate command:
``` bash
rpc activate -local -password NewAMTPassword
``` 

Local deactivate command:
``` bash
rpc deactivate -local
```

:material-new-box: **New Feature: Move to ACM**

In addition to the activation flows above, we've also added the ability to move a device from CCM to ACM without having to first deactivate AMT.  This feature is beneficial when devices shift from a CCM-only network to one that can also handle ACM activation.  RPS is required for this flow.

:material-fast-forward: **New Preview Feature: Centralized Configuration**

We added an optional service called [Hashicorp Consul](https://www.consul.io/) for centralized configuration in scale deployments. When MPS or RPS are first deployed with Consul enabled, they'll check for a configuration in Consul. If found, that configuration will be used to start the service. If not found, the service will use the local configuration file and save it to Consul for future use by subsequent services. [Find more info about enabling Consul in the Centralized Configuration docs.](./Deployment/centralizedConfiguration.md)

This is currently a preview feature so expect additional changes as we receive feedback.

## Get the Details

### Additions, Modifications, and Removals

#### RPS

v2.15.0

- add consul config support ([#1081](https://github.com/open-amt-cloud-toolkit/rps/issues/1081)) (#d39edab)

v2.14.0

- adds capability to upgrade to admin control mode ([#1098](https://github.com/open-amt-cloud-toolkit/rps/issues/1098)) (#7a409bd)

#### MPS

v2.11.0

- add configs to consul (#982) (#b2d1dd4) 

#### RPC

v2.12.0

- add local deactivation in ACM

v2.11.1

- password not set correctly for ccm activate

v2.11.0

- add local CCM activate
- allow for spaces in input parameters

#### Sample Web UI

v2.12.2

- adds status check for domain creation test (f400ba4)

v2.12.1

- profile creation issue (1388bfd)

#### wsman-messages

v5.5.0

- adds call for UpgradeClientToAdmin ([#528](https://github.com/open-amt-cloud-toolkit/wsman-messages/issues/528)) (474e55e)

#### go-wsman-messages

v1.5.0

- add unprovision response type to amt.setupandconfiguration (72a4b3c)

v1.4.1

- setup and configuration service unprovisioning action (6727e46)

v1.4.0

- ips: adds call for UpgradeClientToAdmin (4ef31c6)

v1.3.0

- ips: add response types for CCM HostBasedSetup (7945e91)

## Project Board

Check out our new [Feature Backlog](https://github.com/orgs/open-amt-cloud-toolkit/projects/5) project board to see issues and prioritized items we're working on across all of our repositories.  You'll also see what is coming in our next release!
