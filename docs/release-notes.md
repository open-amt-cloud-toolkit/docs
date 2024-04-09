--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center">
  <iframe width="800" height="450" src="https://www.youtube.com/embed/kqAkDXjyeoc?si=6UGZdPnzv0tqusUB" title="April 2024 Release Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

!!! note "Note From the Team"
    After dusting off some old shelves and checking every nook and cranny for Spring, we found a bunch of new features for RPC-Go for the April 2024 Release. The team is getting closer and closer now to being able to offer full activation and configuration entirely locally with RPC-Go. **As of this release**, we can now offer activation, wired/wireless configuration, TLS, configuration of redirection features, and a number of maintenance-type commands available now 100% locally utilizing only RPC-Go.
    
    **Next stop**, RPC-Go wired and wireless 802.1x configuration using Enterprise Assistant! We aren't far away now!
    
    *Best Wishes,* 

    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-new-box: **Feature: RPC-Go Local Wired Configuration**

Wired settings can now be configured locally using just RPC-Go. For wired connections, AMT supports both DHCP and Static IP environments. Configuration info can be passed two different ways, either directly via the command line or read from a config file.

=== "Individual Flags"
    ```
    rpc configure wired -dhcp -ipsync
    ```

=== "Config File"
    ```
    rpc configure wired -config config.yaml
    ```

[See the RPC documentation for flag details and config file examples](./Reference/RPC/commandsRPC.md#wired).

<br>

:material-new-box: **Feature: RPC-Go Change AMT Password**

The AMT password can now be reconfigured by RPC-Go using the following new `configure amtpassword` subcommand. This will give a quick and easy way to update AMT passwords across a large number of devices.

However, because this is a local command, there is no centralized database storing the new AMT passwords so make sure to take note of any changes made! For deployments utilizing RPS and MPS, [see the `rpc maintenance changepassword` command.](./Reference/RPC/commandsRPC.md#changepassword)

```
rpc configure amtpassword -newamtpassword newAMTPassword -password oldAMTPassword
```

[See the documentation for additional details](./Reference/RPC/commandsRPC.md#amtpassword).

<br>

:material-new-box: **Feature: RPC-Go Configure AMT Features**

AMT Features can be configured locally now too. For those familiar with the [AMT Features MPS API call](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/2.13.0#/AMT/post_api_v1_amt_features__guid_), the functionality is the same. With this command, redirection features like KVM, SOL, and IDER, can be enabled or disabled.

For Admin Control Mode devices, the user consent settings can also be configured. User consent cannot be modified for CCM devices.

```
rpc configure amtfeatures -kvm -sol -ider -userConsent none
```

[See the documentation for additional details](./Reference/RPC/commandsRPC.md#amtfeatures).

## Get the Details

### Additions, Modifications, and Removals

#### RPC-Go

v2.32.1

- fix: changed optin all type ([47ba85f](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/47ba85f30dfec6e6648c1a198e77b7fbd179eeeb))

v2.31.2

- feat: adds configure amtpassword local command ([#442](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/442))
- feat: adds amt features configuration ([#407](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/407))
- fix: removes duplicate printing for -h and -help flags on maintenance commands
- fix: use tm2 for SetHighAccuracyTimeSynch ([#460](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/460))
- fix: configure error code
- fix: variable names for configJson input ([#441](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/441))
- refactor: adds wireless and wired subcommands deprecating addwifisettings and wiredsettings ([#461](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/461))
- ci: address permissions for trivy-scan to upload ([#447](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/447))
- docs: update badge links
- docs: update badge styles

v2.29.1

- fix: local acm activate does not prompt for password when it is in the config ([#436](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/436)) ([9a6e048](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/9a6e048f4507a417eb3d0c627a904456157c07ec))

v2.29.0

- feat: adds addwiredsettings local configure command ([#422](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/422)) ([ba58bb5](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/ba58bb5b52b620e82e78b031cbfb33082f4ab434))

v2.28.3

- fix: XML messages are no longer escaped when using -json flag ([#429](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/429)) ([01c646c](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/01c646cb27a54d2f650f2fb3b02df3b850ac70d7))

v2.28.2

- fix: changes amtinfo output to use stdout instead of stderr ([7caa756](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/7caa7568cc1b908d1fe22413ef18db85b5b02015))

v2.28.1

- fix: generated binaries should not use CGO ([#426](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/426)) ([2138cfe](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/2138cfea52cf15c0186c2440928c53049759ebcd))

#### Enterprise Assistant (EA)

- fix: logs are made generic and profile request updated [#18](https://github.com/open-amt-cloud-toolkit/enterprise-assistant/pull/16)
- fix: security key and port [#16](https://github.com/open-amt-cloud-toolkit/enterprise-assistant/pull/16)

#### go-wsman-messages

v2.2.2

- fix: ieee802.1x configuration ([#274](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/274)) ([4d1dd67](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/4d1dd67ec99abdd1d1ebf6578b073e63fdc1470f))

v2.2.1

- fix: changes SetAdminACLEntryEx_INPUT to SetAdminAclEntryEx_INPUT for AMT_AuthorizationService ([#269](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/269)) ([35139e2](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/35139e2c0619190cb2dc283f90546b0d562c8bf7))

v2.2.0

- feat: make hash function public ([#266](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/266)) ([ce02b73](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/ce02b739f54e84036875d4de564523dbc21de248))

v2.1.11

- fix: wsman calls to set amt features ([#262](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/262)) ([de460c5](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/de460c5202a6598b7e73e604d6e9d93991970385))

v2.1.10

- fix: removes typo in GeneralSettingsRequest struct ([#260](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/260)) ([c33b573](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/c33b573504a2a03c18179d2e04d316a60c2cfc8e))

v2.1.9

- fix: updates pull call to take instanceid as a string ([#256](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/256)) ([0f2430b](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/0f2430b615d6f5ce696e25ff157954f57f27e87d))

- fix: set OptInRequired to uint32 ([#221](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/221)) ([865e6d8](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/865e6d80bd10d801e9d567affa8406ff8cb82614))

## Project Boards

Check out our new [Sprint Planning](https://github.com/orgs/open-amt-cloud-toolkit/projects/10/views/2) project board to see what stories the dev team is actively working on, what is in our backlog, and what is planned for the next sprint.
