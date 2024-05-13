--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center">
  <iframe width="800" height="450" src="https://www.youtube.com/embed/ChVfBVJ_hRY?si=SWROOueZsDWX41uU" title="May 2024 Release Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

!!! note "Note From the Team"
    
    Just before the summer heat kicks off in Arizona, we've wrapped up adding support for configuring 8021x in AMT using RPC-Go. With this milestone, we're nearing the completion of all the major features planned in RPC-Go for Enterprise support MVP release. That being said, we've also been looking at how to address the gap created by MeshCommander’s end of support for our Enterprise customers. The team has been hard at work architecting and developing an alternative for a 1:1 **Console application** for enterprise-style networks.

    Development is still pretty early, but the team is progressing steadily. You can follow the progress in our [Console GitHub Repo](https://github.com/open-amt-cloud-toolkit/console). Stay tuned for updates soon!
    
    *Best Wishes,* 

    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-new-box: **Feature: RPC-Go Local Wired 802.1x Configuration**

The `configure wired` command now supports configuration of AMT for wired 802.1x environments. By providing the Enterprise Assistant (EA) credentials, RPC-Go can communicate securely with EA and perform the configuration. Configuration info can be passed various ways, such as directly via the command line, read from a config file, or passed as a JSON string.

[See the `rpc configure wired` documentation for additional details and examples](./Reference/RPC/commandsRPC.md#wired).

```
rpc configure wired -config config.yaml
```

```yaml title="config.yaml with 802.1x"
password: 'AMTPassword' # alternatively, you can provide the AMT password of the device in  the command line
wiredConfig:
  dhcp: true
  ipsync: true
  ieee8021xProfileName: 'exampleIeee8021xEAP-TLS'
enterpriseAssistant:
  eaAddress: 'http://<YOUR-IPADDRESS-OR-FQDN>:8000'
  eaUsername: 'eaUser'
  eaPassword: 'eaPass'
ieee8021xConfigs:
  - profileName: 'exampleIeee8021xEAP-TLS'
    authenticationProtocol: 0
```

<br>

:material-new-box: **Feature: RPC-Go Local Wireless 802.1x Configuration**

Previously, we only allowed users to directly pass in the certificates and secrets themselves on the command line. Now, just like for wired configurations, you can use Enterprise Assistant to communicate to the Microsoft CA and issue certificates to AMT. Configuration info can be passed various ways, such as directly via the command line, read from a config file, or passed as a JSON string.

[See the `rpc configure wireless` command documentation for additional details and examples](./Reference/RPC/commandsRPC.md#wireless).

```
rpc configure wireless -config config.yaml
```

```yaml title="config.yaml with 802.1x"
password: 'AMTPassword' # alternatively, you can provide the AMT password of the device in  the command line
enterpriseAssistant:
  eaAddress: 'http://<YOUR-IPADDRESS-OR-FQDN>:8000'
  eaUsername: 'eaUser'
  eaPassword: 'eaPass'
wifiConfigs:
  - profileName: 'exampleWifi8021x' # friendly name (ex. Profile name)
    ssid: 'ssid'
    priority: 1
    authenticationMethod: 7
    encryptionMethod: 4
    ieee8021xProfileName: 'exampleIeee8021xEAP-TLS'
ieee8021xConfigs:
  - profileName: 'exampleIeee8021xEAP-TLS'
    authenticationProtocol: 0 #8021x profile (ex. EAP-TLS(0))
```

<br>

:material-new-box: **Feature: RPC-Go Configure TLS using a Config File**

Configuring TLS now supports using a config `.yaml`/`.json` file. Now, you can provide the details and configure TLS at the same time as activation and network configuration all within the same config file.

[See the `rpc configure tls` command documentation for additional details and examples](./Reference/RPC/commandsRPC.md#tls).

```
rpc configure tls -config config.yaml
```

```yaml title="config.yaml"
password: 'AMTPassword' # alternatively, you can provide the AMT password of the device in  the command line
tlsConfig:
  mode: 'Server'
enterpriseAssistant:
  eaAddress: 'http://<YOUR-IPADDRESS-OR-FQDN>:8000'
  eaUsername: 'eaUser'
  eaPassword: 'eaPass'
```

## Get the Details

### Additions, Modifications, and Removals

#### RPS

v2.22.5

- fix: edit domain api cert expiry date returning null ([#1531](https://github.com/open-amt-cloud-toolkit/rps/issues/1531)) ([4eee76b](https://github.com/open-amt-cloud-toolkit/rps/commit/4eee76b9e0eafac39590d17ac517503d729bfb24))

#### RPC-Go

v2.34.1

- fix: add delay when processing multiple wireless profiles ([#510](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/510)) ([353af73](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/353af731b6127e2ede460e31706a382774ddc871))

v2.34.0

- feat: add yaml support to local tls config ([8ecb612](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/8ecb61257d6242f9d3d9467944482df58c27bd73))

v2.33.1

- fix: 8021x wifi config with preexisting root cert ([55cc329](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/55cc32939313b8709c5f4b3d86bb1cfb1dc9e79e))
- fix: return value on success in lib.go ([#499](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/499)) ([ea30d19](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/ea30d196fc51ed06501dc46b8dca09f9947037bb))

v2.33.0

- feat: adds 8021x to wired configuration ([1e34d85](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/1e34d852d980fa0c243dd101ec57b6211175b9cf))
- fix: wifi prune ([#482](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/482)) ([0e2ce20](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/0e2ce200d0f4c37d22f843cb4328d1b597b2635a))

- fix: changes amtinfo output to use stdout instead of stderr ([7caa756](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/7caa7568cc1b908d1fe22413ef18db85b5b02015))

v2.32.2

- fix: read ccm password from commandline ([5a83d49](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/5a83d49aebe1b089cb8de4f33c928b2d45efa28a))

#### Enterprise Assistant (EA)

!!! note
    Enterprise Assistant will soon begin to have tagged releases. We will share an official announcement when the first tagged release becomes available.

- fix: update security key length [#21](https://github.com/open-amt-cloud-toolkit/enterprise-assistant/pull/21)

#### go-wsman-messages

v2.5.0

- feat: **cim:** adds setbootconfigrole function ([#304](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/304)) ([9b39f90](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/9b39f900a467451202bcf2a6f352ad3b3bf603ec))

v2.4.1

- fix: cim ieee8021x settings ([#312](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/312)) ([afa64e7](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/afa64e7c819e07ea9f16621d2624459341b2198b))

v2.4.0

- feat: enable redirection ([#294](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/294)) ([417ca3f](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/417ca3f41876d20413eeaad2e266f384c382fc53))

v2.3.2

- fix: indicator when nonsecureconnectionsupported is undefiend ([#308](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/308)) ([aa875c8](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/aa875c858a06a0f25d0c0b878bbca16144bdb605))

v2.3.1

- fix: **ips:** change optinrequired to uint32 ([#302](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/302)) ([39865da](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/39865daa3e27363ab5987164231bd019b2e077d1))

v2.3.0

- feat: adds decoding of auditlog ([#286](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/286)) ([e999ef7](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/e999ef7b7d570e8f9442f02409fe027f7a875c0f))

v2.2.4

- fix: **cim:** unmarshalling of CIM_CredentialContext corrected ([#287](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/287)) ([04a5ef4](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/04a5ef4b1bab0380054b0d5e94cc4ad650d03807))

v2.2.3

- fix: update cim boot constants ([#285](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/285)) ([ccebc77](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/ccebc7723b1fdc5a76d1a469910269625c024ae9))

## Project Boards

Check out our new [Sprint Planning](https://github.com/orgs/open-amt-cloud-toolkit/projects/10/views/2) project board to see what stories the dev team is actively working on, what is in our backlog, and what is planned for the next sprint.
