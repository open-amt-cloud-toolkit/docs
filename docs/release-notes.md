--8<-- "References/abbreviations.md"
## Release Highlights

<!-- <div style="text-align:center;">
 <iframe width="800" height="450" src="https://www.youtube.com/embed/fpeqIevX7qw" title="Open AMT April Release Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br> -->

!!! note "Note From the Team"
    Hey everyone,

    We are excited to announce the latest release of the Open AMT Cloud Toolkit! As always, the team has been hard at work adding new features and fixing issues to improve the experience for our customers. This release includes support for 802.1x wireless configurations, as well as some quality of life improvements. You can find the details of this release under the [what's new](#whats-new) section.

    The Open AMT Cloud Toolkit team has moved to [Discord](https://discord.gg/yrcMp2kDWh).  Come join the discussion!

    *Best wishes,*  
    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-star:** Database update required **

Upgrades to the `rpsdb` and `mpsdb` databases are required. Please run the following SQL scripts to add the new column and constraints before upgrading the services.

[More information or detailed steps can be found in Upgrade Toolkit Version](../Deployment/upgradeVersion/).

#### rpsdb

``` sql
ALTER TABLE IF EXISTS wirelessconfigs
ADD COLUMN IF NOT EXISTS ieee8021x_profile_name citext,
ADD CONSTRAINT ieee8021xconfigs_fk FOREIGN KEY (ieee8021x_profile_name, tenant_id)  REFERENCES ieee8021xconfigs (profile_name, tenant_id);
```

#### mpsdb

``` sql
ALTER TABLE IF EXISTS devices 
ALTER COLUMN tenantid SET NOT NULL;
```

:material-new-box:** New Feature: 802.1X Wireless Configuration Support **

For devices deployed in a secure enterprise network, configuring AMT to authenticate with the network is important so that connection can be maintained with the device even when the OS is not available. With this release, we now support configuring AMT with certificate-based 802.1x configurations (EAP-TLS) for wireless networks.  [Find more information about 802.1x configuration here](../Reference/EA/ieee8021xconfig/#wireless-8021x-configuration). 

:material-hammer:** Quality of Life Improvement: Added -f (force) flag for maintenance commands **

We have added the -f (force) flag for maintenance commands to allow users to bypass the password check RPS performs. This will help customers who need to run a maintenance task on AMT but have not yet added the device credentials to the secret store.  [RPC Maintenance Commands](../Reference/RPC/commandsRPC/#maintenance)

:material-hammer:** Fixed: Multi-Tenancy Issues for Deactivation and WiFi Profiles **

We have fixed an issue with multi-tenancy for deactivation and WiFi profiles, ensuring that they are properly isolated between different tenants.

## Get the Details

### Additions, Modifications, and Removals

#### RPS
- implemented configuration of 8021x wireless profiles on AMT ([#985](https://github.com/open-amt-cloud-toolkit/rps/issues/985)) (#f4693a2)
- implement wireless 8021x APIs ([#950](https://github.com/open-amt-cloud-toolkit/rps/issues/950)) (#cf9f402)
- maintenance: add -f (force) flag ([#977](https://github.com/open-amt-cloud-toolkit/rps/issues/977)) (#054604d)
- multi-tenancy and deactivation ([#987](https://github.com/open-amt-cloud-toolkit/rps/issues/987)) (#ca2eea6)
- handle multi-tenancy for profiles with wifi ([#988](https://github.com/open-amt-cloud-toolkit/rps/issues/988)) (#dd451a3)
- not saving passphrase in vault ([#972](https://github.com/open-amt-cloud-toolkit/rps/issues/972)) (#091de69)
- added timer on ea response calls ([#966](https://github.com/open-amt-cloud-toolkit/rps/issues/966)) (#61fd283)
- address hyphen in passwordValidation to be correct (#a3849d1)
- db: ieee8021x foreign key violation message ([#975](https://github.com/open-amt-cloud-toolkit/rps/issues/975)) (#74769c9)
- network configuration state machine ([#956](https://github.com/open-amt-cloud-toolkit/rps/issues/956)) (#d479cd4)
- configurable delays and timeouts primarily for state machines ([#942](https://github.com/open-amt-cloud-toolkit/rps/issues/942)) (#788043b)

#### MPS
- update kvmConnect property on CIRA connection close ([#888](https://github.com/open-amt-cloud-toolkit/mps/issues/888)) (#37307fe) 
- Device deletion request from RPS ([#886](https://github.com/open-amt-cloud-toolkit/mps/issues/886)) (#dd483d6) 

#### RPC
- **utils:** add -f (force) flag
- **rps:** rpc will exit instead of hang when connection fails to rps

#### WSMAN-MESSAGES
v5.2.1

- **amt:** fix wifi namespace handling ([#449](https://github.com/open-amt-cloud-toolkit/wsman-messages/issues/449)) (#4358402) 

#### Sample Web UI
- **8021x:** functionality for wireless configuration ([#1083](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/1083)) (#bec716d) 
- **devices:** add device deactivation via cira ([#1001](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/1001)) (#e4af456)

## Project Board
Check out our new [Feature Backlog](https://github.com/orgs/open-amt-cloud-toolkit/projects/5) project board to see issues and prioritized items we're working on across all of our repositories.  You'll also see what is coming in our next release!
