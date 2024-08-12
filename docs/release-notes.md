--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center">
  <iframe width="800" height="450" src="https://www.youtube.com/embed/ZB56nve-7SU?si=OxzLt_a8gukar-e2" title="Windows BSOD Recovery" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

!!! note "Note From the Team"
    
    With the **Beta** release of Console right around the corner, we are heads down on validation and critical bug fixes. This release, while light, has some nice quality of life updates as well as some key requested bugfixes. Check out the video above for a quick demo on how Intel AMT could have been used to solve the infamous CrowdStrike bug (or other BSOD issues) from July.

    **A big thanks to everyone this month for the community engagement and the submitted pull requests!**

    You can follow the progress of Console and everything else Open AMT in our [Feature Backlog](https://github.com/orgs/open-amt-cloud-toolkit/projects/10/views/2).
    
    *Best Wishes,* 

    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-new-box: **Feature: Certificate Pruning**

RPC-Go now cleans up old Wireless and TLS configs when adding new ones. This tweak should help keep things tidier when it comes to reconfiguring a device.

<br>

:material-update: **Dependencies Update: Kubernetes Deployment Vault/Kong/Postgres**

We've updated the core dependencies for our default Kubernetes deployment. **If you are using Kong, the Kong secrets will require changes.** [See the `secrets.yaml` file to see the new required `labels:` field for Kong secrets.](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/blob/main/kubernetes/charts/secrets.yaml)

The default Azure Kubernetes Service (AKS) deployment has now switched from a Postgres Single Server to a Postgres Flex Server as the Azure EOL date of Single Server is quickly approaching.

## Community Contributions

:material-party-popper: Big shout out to **Github user @webD97** for both of these contributions! :material-party-popper:

:material-star: **Fix: RPC-Go on Linux Now Returns Correct FQDN and Hostname**

[Resolves a popular issue.](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/189) Previously on Linux, RPC-Go was not properly differentiating between the device's FQDN and hostname when the device was configured with a short hostname and was returning a FQDN identical to the hostname.

<br>

:material-star: **Fix: MPS Router Reuses Connection Pool**

Previously, MPS Router was creating new pools for each query rather than reusing it causing issues with Postgres instances that have connection limits configured.

<br>

## Get the Details

### Additions, Modifications, and Removals

#### Console

v1.0.0-alpha.8

- fix: certificates should now be decoded properly ([ae87f7b](https://github.com/open-amt-cloud-toolkit/console/commit/ae87f7bc72874de1cb4931df7b0196c9508e86c8))
- fix: removes zip of console for windows to avoid false positive threat ([095dc88](https://github.com/open-amt-cloud-toolkit/console/commit/095dc88ad8c9fd138bfa0ac6c32ce6f56f16d980))

v1.0.0-alpha.7

- fix: add queue for wsman calls ([9c248f7](https://github.com/open-amt-cloud-toolkit/console/commit/9c248f73b323aa2b8bb82289f2e1b858a643b0b4))

### MPS Router

v2.3.9

- fix: ensure that the connection pool is reused across queries ([bf82988](https://github.com/open-amt-cloud-toolkit/mps-router/commit/bf8298815a651782ce828cc67b310842aab5fab6))

#### RPC-Go

v2.37.0

- feat: prunes wired and tls configs when adding new ones ([93553d2](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/93553d244543490b6e534a520bb1f3c1dd391ad3))

v2.36.2

- fix: Resolve FQDN on Linux machines with short hostnames ([#600](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/600)) ([a2df614](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/a2df61462461028ce32e0270029bb54a725f66af)), closes [#189](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/189)

v2.36.1

- fix: attempt to address false positive virus on zipped go binary artifacts on windows ([#591](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/591)) ([6957954](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/695795411e30615e4206efc8945abaa9ce2ce22d))

#### RPS

v2.22.9

- fix: abnormal websocket closure post ccm ([#1727](https://github.com/open-amt-cloud-toolkit/rps/issues/1727)) ([755aa02](https://github.com/open-amt-cloud-toolkit/rps/commit/755aa0222fbdabf477433aabf49bcc53088ed050))

#### Sample Web UI

v3.12.2

- fix: update hardware information component ([#2050](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2050)) ([9fa5f86](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/9fa5f86e2d401abb52a2b26c4c06b1aee05b1230))

v3.12.1

- fix: loading domains successfully no longer shows error ([#2038](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2038)) ([4b33b90](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/4b33b90a68e71e0a7ace04905d5579d26b201460))

v3.12.0

- feat: add loading indicators for hwinfo and general info ([#2035](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2035)) ([d7bed7e](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/d7bed7e0aa6d8112e6b044415d25a23b4bc49d14))

v3.11.1

- fix: update audit log paging to use paginator correctly ([#2017](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2017)) ([c9141f8](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/c9141f8f27a77057587d2035f80711a0d24f7294))

v3.11.0

- feat: adds wsman explorer call filter ([#2000](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2000)) ([71b0986](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/71b09860fdcf9d3bbf4a6345be4b2acfc2088a78))

#### go-wsman-messages

v2.12.0

- feat: adds put method to tls credential context ([#385](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/385)) ([3298154](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/32981547a8341f8500024899aa197d44da099021))

v2.11.2

- fix: update physical package ([#376](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/376)) ([27d235a](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/27d235adf5ba6fb717621fcece452c69b6f4ea9d))

v2.11.1

- fix: tweak http.Transport settings ([#373](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/373)) ([6262a2e](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/6262a2e3f5dc7d28ff394402c3e00de9fe8e1ce2))

## Project Boards

Check out our new [Sprint Planning](https://github.com/orgs/open-amt-cloud-toolkit/projects/10/views/2) project board to see what stories the dev team is actively working on, what is in our backlog, and what is planned for the next sprint.
