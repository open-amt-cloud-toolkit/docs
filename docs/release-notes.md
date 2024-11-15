--8<-- "References/abbreviations.md"

## Beta version of Console is Live!

The Beta tag of Console is now available for download! Get the latest download [here](https://github.com/open-amt-cloud-toolkit/console/releases/latest).

New to Console? Start with [overview guide](./Reference/Console/overview.md). If you've already used Alpha version, jump to our updated [Getting Started Guide](./GetStarted/Enterprise/setup.md#get-console).

## What's new in Beta?

:material-new-box: **Feature: Export Configuration Profiles**

Users can now export configuration profiles as encrypted files, streamlining profile creation and enhancing security. This feature makes activation and configuration using RPC-Go local commands simpler, keeping the profiles secure.
<br>

:material-new-box: **Feature: Authentication**

Securely log-in to Console using credentials configured in `config.yml` or through environment variables. This feature enhances security and simplifies authentication setup. For detailed information on `config.yml` options, visit the [Configuration Variables Documentation](./Reference/Console/configuration.md#configuration-variables).
<br>

:material-new-box: **Feature: Alarm Clock**

The Alarm Clock feature is used to wake the device from a powered-down or sleep state. With Console, users can easily create and manage Alarm Clocks to wake systems at scheduled times.
<br>

:material-new-box: **Feature: Certificate Pinning**

Console now supports certificate pinning, allowing you to pin the TLS certificate presented by Intel® AMT. Once pinned, any connection attempt with a different certificate from Intel® AMT will be rejected.
<br>

:material-new-box: **Feature: Encrypting Senstive Data**

All sensitive data stored in the SQLite database is now encrypted using an encryption key. If not provided by the user, Console automatically generates this key, ensuring that sensitive information remains securely protected.
<br>

:material-update: **Quality of Life Updates**

We've made significant improvements and fixed issues across Power Actions, User Consent, KVM, SOL, Network, TLS, and Hardware information features.
<br>

## Updates to Other component 

:material-new-box: **Feature: RPC-Go Now Supports Encrypted Config**

RPC-Go now supports activating and configuring Intel® AMT devices using encrypted configuration profiles (in `YAML` format) for enhanced security. The encryption key needed to decrypt the profile is shown only once during the export process in Console, so make sure to save it. Detailed steps can be found [here](./GetStarted/Enterprise/activateDevice.md#activate-device).


:material-update: **Bug Fixes and Maintenance**

Fixed minor bugs in RPS, MPS, Sample-Web-UI and RPC-Go. Updated dependencies across all components to the latest libraries.


!!! note "Note From the Team"
    
    While we're excited to release the BETA version, our journey towards the Console MVP (v1.0) continues. We’re actively listening to your feedback and working on feature requests and bug fixes to make Console even better. Long term vision is to consolidate MPS, and RPS into Console to reduce the complexity in deployment for either enterprise or cloud deployments. Until then, we will continue supporting and maintaining our Cloud components (MPS, RPS, and MPS-Router) alongside this effort.

    You can follow the progress of Console and everything else Open AMT in our [Feature Backlog](https://github.com/orgs/open-amt-cloud-toolkit/projects/10/views/2).
    
    *Best Wishes,* 

    *The Open AMT Cloud Toolkit Team*


## Get the Details

### Additions, Modifications, and Removals

#### Console

v1.0.0-beta.2

* move launch to after key generation ([76b4e9a](https://github.com/open-amt-cloud-toolkit/console/commit/76b4e9af229bfd84f87668f7bd28ba3dd3f8bc04))
* redirect to login if 401 from server ([92b08a3](https://github.com/open-amt-cloud-toolkit/console/commit/92b08a3876319c82df4d46c69fd260639c0a4403))
* adds wireless synchronization option to config ([#431](https://github.com/open-amt-cloud-toolkit/console/issues/431)) ([0d9d515](https://github.com/open-amt-cloud-toolkit/console/commit/0d9d515d7223e7c2bb7ce6775bb7e5ab51154098))

v1.0.0-beta.1

* add ea to profile export ([#425](https://github.com/open-amt-cloud-toolkit/console/issues/425)) ([ad5aa5b](https://github.com/open-amt-cloud-toolkit/console/commit/ad5aa5bd5b4beea001ddf3e595634ee4b883438c))
* add migrations to embed ([5399ccb](https://github.com/open-amt-cloud-toolkit/console/commit/5399ccbb683bb10cbafae5eb1d840e1cc032989f))
* add queue for wsman calls ([9c248f7](https://github.com/open-amt-cloud-toolkit/console/commit/9c248f73b323aa2b8bb82289f2e1b858a643b0b4))
* add template issue for index.html ([f35dd1c](https://github.com/open-amt-cloud-toolkit/console/commit/f35dd1cf507089e174ccfac3937f4d4c51ade4ba))
* advanced power actions ([#316](https://github.com/open-amt-cloud-toolkit/console/issues/316)) ([f5b07cc](https://github.com/open-amt-cloud-toolkit/console/commit/f5b07cc9365591eb09259595f2eb217ff3024ae7))
* alarm clock, eventlog, and connection expiration ([2c80bbf](https://github.com/open-amt-cloud-toolkit/console/commit/2c80bbfd66bcc958a4766360ef93a17f72576685))
* allow export of profile when no wireless ([fed67f6](https://github.com/open-amt-cloud-toolkit/console/commit/fed67f63e261018261dd023b88254ff7a586f1f2))
* allows string input for userconsent code ([#167](https://github.com/open-amt-cloud-toolkit/console/issues/167)) ([9a52830](https://github.com/open-amt-cloud-toolkit/console/commit/9a52830b82fccfcc0c51ef0c62225a9e85e0bd21))
* **api:** get network settings ([#385](https://github.com/open-amt-cloud-toolkit/console/issues/385)) ([717f704](https://github.com/open-amt-cloud-toolkit/console/commit/717f704d2c25ea0907086a236075fa6729e24172))
* **api:** get, add and delete alarm works ([#380](https://github.com/open-amt-cloud-toolkit/console/issues/380)) ([9bcf024](https://github.com/open-amt-cloud-toolkit/console/commit/9bcf0244d4bd44068df413e00f6cd9e85ad8cf24))
* certificates should now be decoded properly ([ae87f7b](https://github.com/open-amt-cloud-toolkit/console/commit/ae87f7bc72874de1cb4931df7b0196c9508e86c8))
* devices use unique connections now ([3f3e29d](https://github.com/open-amt-cloud-toolkit/console/commit/3f3e29de66f07dc3f93907d1c66f15d06e145e9d))
* ensure tagging is working with embedded SQL, fix alarms ([#233](https://github.com/open-amt-cloud-toolkit/console/issues/233)) ([9505a81](https://github.com/open-amt-cloud-toolkit/console/commit/9505a8108690f46fc38c8c075cd7ab90ee16d677))
* font requests are now routed correctly ([1c5b8b6](https://github.com/open-amt-cloud-toolkit/console/commit/1c5b8b64c9d7faaae01c345939b4905f7225721e))
* formatting ([3325fef](https://github.com/open-amt-cloud-toolkit/console/commit/3325fef541d2ea00a58df9ff890a3fb09162038f))
* handle convering int to string in html ([96e2d04](https://github.com/open-amt-cloud-toolkit/console/commit/96e2d040867b6ea48b697cc3d507d229915726c6))
* handle kvm not available on ISM ([#364](https://github.com/open-amt-cloud-toolkit/console/issues/364)) ([925197e](https://github.com/open-amt-cloud-toolkit/console/commit/925197e57a5d4d7ee34c62d578e07193b18068e3))
* handles when update fails as not found ([05851f4](https://github.com/open-amt-cloud-toolkit/console/commit/05851f47a5a77e28429f71ec9c63c36b9416b95d))
* increase api timeouts for allowing time for devices to respond ([64ddeb2](https://github.com/open-amt-cloud-toolkit/console/commit/64ddeb22f18913e4022cf0d314b939542b0761f4))
* isvalid checks ([a770f2a](https://github.com/open-amt-cloud-toolkit/console/commit/a770f2aa2ed280adf7eca981a2c2296f0f6e8941))
* json props for securitysettins now camelCase ([64c65a3](https://github.com/open-amt-cloud-toolkit/console/commit/64c65a38c7f8bce738d493d3f66eebff732c457d))
* logging level should now be respected ([1308c83](https://github.com/open-amt-cloud-toolkit/console/commit/1308c83816adaa49d336413e92dcce5de6e8ca20))
* make windows friendly ([5882a2c](https://github.com/open-amt-cloud-toolkit/console/commit/5882a2cb0177add27c05e90b1dde1c23a0ba244b))
* pin cert on update ([616387e](https://github.com/open-amt-cloud-toolkit/console/commit/616387e15802b2f4c8ad96116806a236be0ae1f9))
* profile export for wireless settings ([#428](https://github.com/open-amt-cloud-toolkit/console/issues/428)) ([2a95938](https://github.com/open-amt-cloud-toolkit/console/commit/2a95938a603bfc9af902772acb50dc9e0d3c3468))
* registers routes required for monaco editor ([1136f33](https://github.com/open-amt-cloud-toolkit/console/commit/1136f33dbdd4baef1dbc99c227465a790e981208))
* remove CGO requirement for sqlite ([31e0dbe](https://github.com/open-amt-cloud-toolkit/console/commit/31e0dbea9ca9bac5bb5e0845d4c9cb5d81d8be85))
* remove empty string tags ([2b19fbc](https://github.com/open-amt-cloud-toolkit/console/commit/2b19fbca72d9218e032f58fb63be2fc332318185))
* removes zip of console for windows to avoid false positive threat ([095dc88](https://github.com/open-amt-cloud-toolkit/console/commit/095dc88ad8c9fd138bfa0ac6c32ce6f56f16d980))
* revert dto v1 to be compatible with ([bfa63c5](https://github.com/open-amt-cloud-toolkit/console/commit/bfa63c50661fa39cf5e953c22b672d8e22fc646e))
* set boot config role ([8138092](https://github.com/open-amt-cloud-toolkit/console/commit/8138092fe1849d4a61b4f59a417f25b56fef7c52))
* **sql:** ensure postgres inserts are working ([#201](https://github.com/open-amt-cloud-toolkit/console/issues/201)) ([f603c26](https://github.com/open-amt-cloud-toolkit/console/commit/f603c26f54a0714e05663b14222edaa11510a589))
* startTime for alarm ([#386](https://github.com/open-amt-cloud-toolkit/console/issues/386)) ([6213d10](https://github.com/open-amt-cloud-toolkit/console/commit/6213d10761198a7211fddcfbe2a4c5a80b98d0b2))
* tls exports ([ed4a583](https://github.com/open-amt-cloud-toolkit/console/commit/ed4a583510039b53c99563bd333b051fb85981de))
* update AMT features ([#357](https://github.com/open-amt-cloud-toolkit/console/issues/357)) ([ae953d8](https://github.com/open-amt-cloud-toolkit/console/commit/ae953d8648c51608779d2ba1cf0511a094b85df4))
* update hardware information api ([#289](https://github.com/open-amt-cloud-toolkit/console/issues/289)) ([6f28ae4](https://github.com/open-amt-cloud-toolkit/console/commit/6f28ae4b02792249ae0eea8cc6239a97028e61a1))
* updates to make dashboard work ([#40](https://github.com/open-amt-cloud-toolkit/console/issues/40)) ([2ead7cd](https://github.com/open-amt-cloud-toolkit/console/commit/2ead7cd9d79d8b2da4001a2ed80ce2a2a542919e))
* add a keyvalue store ([1c75753](https://github.com/open-amt-cloud-toolkit/console/commit/1c75753f582ed0cefc9cb45db95723b619986e0f))
* add alarm clock ([a00f664](https://github.com/open-amt-cloud-toolkit/console/commit/a00f664c87ff4efda2b80e8d143397f8cf4be5d6))
* add devcontainer support ([94c18f6](https://github.com/open-amt-cloud-toolkit/console/commit/94c18f6143483c76a6df23dfe477a9ca65808e6d))
* add export profile ([b14a019](https://github.com/open-amt-cloud-toolkit/console/commit/b14a0190027b96879fa2625bfa9443c6f2a4c634))
* add internationalization foundation ([#42](https://github.com/open-amt-cloud-toolkit/console/issues/42)) ([acfabbc](https://github.com/open-amt-cloud-toolkit/console/commit/acfabbc5f3286870fa6ba55187d3028a86f850bb))
* add local Profile Synchronization to wireless network ([#423](https://github.com/open-amt-cloud-toolkit/console/issues/423)) ([54db48f](https://github.com/open-amt-cloud-toolkit/console/commit/54db48f5309b360f5a28bfb61f423c134acf620a))
* add mac builds ([2366f92](https://github.com/open-amt-cloud-toolkit/console/commit/2366f922c8f7952599b7df1b3b0d0a8f51011ebe))
* add profile add and edit pages ([2c306a4](https://github.com/open-amt-cloud-toolkit/console/commit/2c306a43b2a32e7183d7947a738a9ce005de5de0))
* add provisioning mode and state ([93fdece](https://github.com/open-amt-cloud-toolkit/console/commit/93fdecedbc5f0415d271c934b7e4de6e47693143))
* add UUID from device ([6adaa55](https://github.com/open-amt-cloud-toolkit/console/commit/6adaa5511ab9b394d0ce66011d83311c9443a09f))
* added get certificates api ([#135](https://github.com/open-amt-cloud-toolkit/console/issues/135)) ([7e7bfd8](https://github.com/open-amt-cloud-toolkit/console/commit/7e7bfd8c6c4526d09d7717b072dd0702a446b400))
* added integration tests ([#217](https://github.com/open-amt-cloud-toolkit/console/issues/217)) ([3d2e033](https://github.com/open-amt-cloud-toolkit/console/commit/3d2e033dfad871d5168417723f18925db71b5a82))
* added power control ([3dbd065](https://github.com/open-amt-cloud-toolkit/console/commit/3dbd065bd2a2360c498fa145f442bb09ce44c4e3))
* adding, editing, storing amt credentials ([119ae51](https://github.com/open-amt-cloud-toolkit/console/commit/119ae513e3c16b386277a6308637241bc61400b3))
* adds amt explorer feature ([#172](https://github.com/open-amt-cloud-toolkit/console/issues/172)) ([9f3d70e](https://github.com/open-amt-cloud-toolkit/console/commit/9f3d70e9dfb07e3b0580d0dc70963c10547c4a72))
* adds db interfaces and implementations for iee8021x, ciraConfig, and wirelessProfile ([#78](https://github.com/open-amt-cloud-toolkit/console/issues/78)) ([096de70](https://github.com/open-amt-cloud-toolkit/console/commit/096de704fdcf0e0ac9ada6cc5757271c40c47ec6))
* adds dev mode flag ([#43](https://github.com/open-amt-cloud-toolkit/console/issues/43)) ([9857ba7](https://github.com/open-amt-cloud-toolkit/console/commit/9857ba7c4ab3cd67ffb1f6e22bbd32fd7dbb3a3f))
* adds http endpoints for ciraconfig, wireless config and 8021x configs ([#86](https://github.com/open-amt-cloud-toolkit/console/issues/86)) ([f337911](https://github.com/open-amt-cloud-toolkit/console/commit/f3379118396aefd92d33e112fd4ec496fe58e099))
* adds network settings ([4917d0e](https://github.com/open-amt-cloud-toolkit/console/commit/4917d0e23498011aa325e88596199adf2127e01f))
* allow config of timeout from configuration ([e9d5135](https://github.com/open-amt-cloud-toolkit/console/commit/e9d513526945a0c0bea41f9fa76afa1679593d99))
* **api:** add api gettlssettingdata ([#310](https://github.com/open-amt-cloud-toolkit/console/issues/310)) ([3fcc67f](https://github.com/open-amt-cloud-toolkit/console/commit/3fcc67f816407f78fde93ab0a41274e777dae298))
* auto launch UI and stop service on UI close ([fd575b9](https://github.com/open-amt-cloud-toolkit/console/commit/fd575b9e2187cfa6c531964be54252837ecee364))
* capture ea details in config for TLS configuration ([e24ff6b](https://github.com/open-amt-cloud-toolkit/console/commit/e24ff6b50accd79e1263695021d14905ef5c8e00))
* capture ea details in config for TLS configuration ([#414](https://github.com/open-amt-cloud-toolkit/console/issues/414)) ([6094fa4](https://github.com/open-amt-cloud-toolkit/console/commit/6094fa4341e5eeabf7957ec99f119d84694d29b3))
* connect to amt and get general settings ([fa0d3f3](https://github.com/open-amt-cloud-toolkit/console/commit/fa0d3f3a4a42619a203ea5317daa9b7ede3cc148))
* domains check password and expiration ([d687c30](https://github.com/open-amt-cloud-toolkit/console/commit/d687c307caed561c7c4b198dcdc35704ffc12b1d))
* enable auth endpoint ([e79aa66](https://github.com/open-amt-cloud-toolkit/console/commit/e79aa661067385966f3ef64c09f47d41ec206199)), closes [#128](https://github.com/open-amt-cloud-toolkit/console/issues/128)
* enable auth on websocket ([ad68431](https://github.com/open-amt-cloud-toolkit/console/commit/ad684317094078722743b136fee2813f85a25671))
* enable browser launch ([726f31a](https://github.com/open-amt-cloud-toolkit/console/commit/726f31a482dc3cb3d25ec125cd443b6cec0172d4))
* enable encryption/decryption of secrets ([29dfc87](https://github.com/open-amt-cloud-toolkit/console/commit/29dfc8790fb4e2ef704d172e4db44f1838664cba)), closes [#398](https://github.com/open-amt-cloud-toolkit/console/issues/398) [#399](https://github.com/open-amt-cloud-toolkit/console/issues/399) [#400](https://github.com/open-amt-cloud-toolkit/console/issues/400)
* enable host listening via configuration ([2944b25](https://github.com/open-amt-cloud-toolkit/console/commit/2944b25d9e690410b084019fcf78f797ccdb55eb))
* enable mps endpoints ([1a09ada](https://github.com/open-amt-cloud-toolkit/console/commit/1a09ada065d4449591b34627eccce8d631b52fc6))
* enable sqlite support ([c588b43](https://github.com/open-amt-cloud-toolkit/console/commit/c588b435d73d82f4e110d039976ef566f857d7cd))
* enable tls pinning ([b2ba5e0](https://github.com/open-amt-cloud-toolkit/console/commit/b2ba5e0daed66ffa84e57b8195e1aeb89a3b90db))
* enable tls pinning for redirection capabilities ([2998d58](https://github.com/open-amt-cloud-toolkit/console/commit/2998d58461ddf80dc1d7d80731efacd485c588e5))
* enables /version endpoint ([4cd6951](https://github.com/open-amt-cloud-toolkit/console/commit/4cd69514f8f0dbd2317adcbea8b6c244db240ab2))
* enables redirection for KVM, IDER, and SOL ([9bca3b2](https://github.com/open-amt-cloud-toolkit/console/commit/9bca3b2a2bf4c516d6e1105205ff44f6fd27b2b6))
* enables wifi config and ieee associations ([2a0d896](https://github.com/open-amt-cloud-toolkit/console/commit/2a0d896fa070e23a6aa46ccfe7aa34ff022454f1))
* expanded profile editing ([5db4d33](https://github.com/open-amt-cloud-toolkit/console/commit/5db4d33ccf4e0d1cae4f5eddbf2a0df336c828ba))
* expanded profile editing ([57ee897](https://github.com/open-amt-cloud-toolkit/console/commit/57ee8972d98aecaa773dd0b65cc2bab59cc69495))
* expanded profile editing ([#28](https://github.com/open-amt-cloud-toolkit/console/issues/28)) ([350ea7f](https://github.com/open-amt-cloud-toolkit/console/commit/350ea7f45e1ea8849224a3189ab4f4394f54d4bd))
* handle network timeout error for devices ([439f835](https://github.com/open-amt-cloud-toolkit/console/commit/439f835d579aac92090ddb6a252fc1d7ecadf0fd))
* handles tls and selfsigned options for device connection ([#76](https://github.com/open-amt-cloud-toolkit/console/issues/76)) ([dd14743](https://github.com/open-amt-cloud-toolkit/console/commit/dd147431e8446e05acf31ad2ffb38dc5e72bf3a2))
* initial commit ([aadee2c](https://github.com/open-amt-cloud-toolkit/console/commit/aadee2c7c878ebb89ed896b7b46b36960ee5c816))
* move console to use sample-web-ui ([e9e292d](https://github.com/open-amt-cloud-toolkit/console/commit/e9e292d7fefe9efe71c2eceecdd6fa6eff43ea02))
* power state and toast message ([cbbb9b2](https://github.com/open-amt-cloud-toolkit/console/commit/cbbb9b2f3014263a2756710c3004ae4e1bb2a57f))
* restrict username length ([43441b8](https://github.com/open-amt-cloud-toolkit/console/commit/43441b844579b4d850a120051a7e705f87310bb1))
* set reasonable defaults if no config ([8c839af](https://github.com/open-amt-cloud-toolkit/console/commit/8c839afef3b4d11751dfbea9cfd1ecdf96fe9578))
* UI update, general settings, ethernet settings ([1e55b74](https://github.com/open-amt-cloud-toolkit/console/commit/1e55b74af23d2266630015df4f89bab5da95652e))
* updated profile page ([ed8005d](https://github.com/open-amt-cloud-toolkit/console/commit/ed8005d43f44a3ce8c0d877269db439da29ff466))
* updated to latest go-wsman-messages v2.0 cim support ([7acf636](https://github.com/open-amt-cloud-toolkit/console/commit/7acf636b2002bd7fb7f790b5d0e3f7c481fff943))
* updates to handler ([f974fbe](https://github.com/open-amt-cloud-toolkit/console/commit/f974fbe09a35ef09602c525bd4d9da899108786e))
* use dto for getPowerCapabilities ([#384](https://github.com/open-amt-cloud-toolkit/console/issues/384)) ([bd68a03](https://github.com/open-amt-cloud-toolkit/console/commit/bd68a037bdca384f5ee0dfbfd7c3da543107ff90))
* use dto for user consent ([#402](https://github.com/open-amt-cloud-toolkit/console/issues/402)) ([14b70d6](https://github.com/open-amt-cloud-toolkit/console/commit/14b70d69c67686df57c90acc05587f6d6cf5e8b7))
* use dto in devices ([#240](https://github.com/open-amt-cloud-toolkit/console/issues/240)) ([99f97fc](https://github.com/open-amt-cloud-toolkit/console/commit/99f97fc03edc4e1920f4816a21b778a18edb8277))
* use dto in getfeatures ([2d3bc4f](https://github.com/open-amt-cloud-toolkit/console/commit/2d3bc4f642df141b649e97b2204fc8dd4318f1d2))
* use dto in getPowerState ([#375](https://github.com/open-amt-cloud-toolkit/console/issues/375)) ([c410deb](https://github.com/open-amt-cloud-toolkit/console/commit/c410deb8a5fcc5b56217883b1231c8ca6b4d2ba2))
* use dto in getversion ([#362](https://github.com/open-amt-cloud-toolkit/console/issues/362)) ([0cb4bdb](https://github.com/open-amt-cloud-toolkit/console/commit/0cb4bdbc6e94ed86bce0b5d4046e526492ae50c0))
* wsman-explorer added ([7194d5a](https://github.com/open-amt-cloud-toolkit/console/commit/7194d5a772e683fa44855f779b2b4c017ca2cdbe))

#### RPC-Go

v2.42.5

* dependency updates

v2.42.2

* activates in ccm mode now ([a50f3a0](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/a50f3a0a4aef76bec2dbe949daabf16c02a7cbb8))

v2.42.0

* IsWirelessSynchronized is optional in wireless configuration ([0847817](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/0847817d4bdb53751429a957d3b619a665a4fe01))

v2.41.0

* enable config v2 from console ([a765f4c](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/a765f4c2c279f6fcb511d48cbca8be02e2762758))

v2.40.1

* add error handling when TLS activation is enforced ([#678](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/678)) ([f538952](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/f538952de54239ba092e281a40e7dbbdb5c3029f))

v2.40.0

* generate third party licenses zip for every release ([#665](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/665)) ([10d7724](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/10d772492318060b70834974aa3df1476946fff6))

v2.39.0

* lib.go redirects stdout to Output ([#640](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/640)) ([8697c99](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/8697c995f28e27631d26be291d711abdec1ad86d))

v2.38.0

* adds ccm activation using config ([abd02bc](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/abd02bcbb05b88e44378c81962f8b89bf115327a))

#### RPS

v2.22.14 and v2.22.13

* dependency updates

v2.22.12

* add tenantid to ieee8021x db queries ([#1812](https://github.com/open-amt-cloud-toolkit/rps/issues/1812)) ([f559ce8](https://github.com/open-amt-cloud-toolkit/rps/commit/f559ce8ce319532ced15efc1bff62bdf59257cda)), closes [#1811](https://github.com/open-amt-cloud-toolkit/rps/issues/1811) [#1807](https://github.com/open-amt-cloud-toolkit/rps/issues/1807)

v2.22.11

* cira connection in static ip environment ([#1747](https://github.com/open-amt-cloud-toolkit/rps/issues/1747)) ([09be848](https://github.com/open-amt-cloud-toolkit/rps/commit/09be84855f09df34eb6ffc3504ae73b4d7fe9c88))

#### MPS

v2.13.21

* browser data when cira channel is closed ([#1707](https://github.com/open-amt-cloud-toolkit/mps/issues/1707)) ([c72949a](https://github.com/open-amt-cloud-toolkit/mps/commit/c72949a228a8f6954c19219bb1ebda0f993a7b51))

v2.13.20 and v2.13.19

* dependency updates

v2.13.18

* **api:** get alarm occurrence ([#1656](https://github.com/open-amt-cloud-toolkit/mps/issues/1656)) ([27d2064](https://github.com/open-amt-cloud-toolkit/mps/commit/27d20644ebc427a6ce3ea1e437bbeb27f579bb59))

v2.13.17

* Override OpenSSL security level to allow TLSv1 connections ([a5f6b06](https://github.com/open-amt-cloud-toolkit/mps/commit/a5f6b0672062d9ce039d9a8a2d7892cb61e664c5))

#### Sample Web UI

v3.27.4 and v3.27.3

* dependency updates

v3.27.2

* disables CIRA in non-cloud mode ([d0cebc3](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/d0cebc326a4f52107c8908139ef05218fd04e71d))

v3.27.1

* logout user if 401 from server ([5801592](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/5801592db6ce7ba64e159d3e9448def08c8d924c))

v3.27.0

* re-enable auth for ws when in console mode ([#2298](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2298)) ([8c1b00e](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/8c1b00e9a5b48bb33f66cc1549de21e5b2cabd17))

v3.26.0

* add local Profile Synchronization to wireless network ([#2297](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2297)) ([3552bec](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/3552bec6bb76c83b81620b9c5fa345f7eadde159))

v3.25.0

* add power state to device details ([894e264](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/894e2643759b804a0181a39f4a6d53b81514abb2)), closes [#2283](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2283)

v3.24.1

* profile now handles direct connection mode correctly ([b4dff71](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/b4dff7134cceb3e230205163e5ac18de1a6985df))

v3.24.0

* enable auth for console mode ([896d1fe](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/896d1fe34aa7b6926d916b4984f3d55b5261e9d3))

v3.23.1

* network settings displays only available interfaces ([#2248](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2248)) ([12fb737](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/12fb737306db21b3e927cca766e12efcc7a677f8))

v3.23.0

* amt explorer event trigger ([39b538e](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/39b538e2b99154469cbc5375eff50ec7e8badb5c))
* enables profile export from console ([302dffd](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/302dffd7078b2cf2839ef8ab487c743e23fde8d5))

v3.22.1

* add and delete alarm works now ([#2232](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2232)) ([78de4fb](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/78de4fbdfe203ade09ae63e71e715641bdee4eae))

v3.22.0

* indicate when device does not respond ([9ded8cb](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/9ded8cb32fbed97556acdf7c2a8057cc50892db2))

v3.21.1

* shows disconnect button on sol connection ([#2215](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2215)) ([5d7fdb3](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/5d7fdb31a3b8953ab0992f3bdb0dcf09af5f1aa4))

v3.21.0

* translate amt sku value to human readable string ([#2204](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2204)) ([54d9ffa](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/54d9ffa2ee6ec20899fb68a7985a1e441d5cc62b))

v3.20.5

* resolves handling when when amt redirection features are available ([#2202](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2202)) ([4d7fbbb](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/4d7fbbb039f7a59b4628a02bc8be45027cd42dcb))

v3.20.4

* KVM/SOL disconnect on close ([#2196](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2196)) ([43ecbd4](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/43ecbd43fe11a02089140c43e0d2d8ac31c67691))

v3.20.3

* accept user consent code for advanced power actions ([#2173](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2173)) ([ed33bb2](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/ed33bb2146c01a1c5d01d24beb2daaca5d6ad6f9))

v3.20.2

* handles empty values in DTO for network page ([#2190](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2190)) ([b4ae79c](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/b4ae79c9f84c441d040b44dc689289d152421b11))

v3.20.1

* show success message on amt features update ([abbea4d](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/abbea4d2c0cf4fd6d55a400856420cdb923a7e43))

v3.20.0

* hide menu for console and update dashboard ([8575d89](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/8575d89a21839e06cadf36bf9c9e11b12bcc7eff))

v3.19.0

* add validation for username length ([9d0787d](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/9d0787df4e20c64a2a9f8e6b824c2d8fc7a251c9))

v3.18.1

* deactivate button tooltip ([#2176](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2176)) ([cf4d5e0](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/cf4d5e023aba9dc394e0197519bd2cac475bc4e8))

v3.18.0

* adds section to device info for certificate information and allows for downloading of certs ([#2135](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2135)) ([74801e0](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/74801e0d57c0ba4f604d3d3e0a61779cb9960e3e))

v3.17.3

* grammar in confirm dialog now reads correctly for multiple/single selection ([#2165](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2165)) ([96d5453](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/96d5453251f44d0953ca81104c00d3ef1e41e092))

v3.17.2

* automatically clears explorer selection field on click ([#2167](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2167)) ([4324bae](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/4324bae360d15ccdc2d42bd5aff658104db7da6b))

v3.17.1

* hides erroneous icon for deletion ([#2166](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2166)) ([0bea2df](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/0bea2dff4f7d8edc582fa36e200f59679136b308))

v3.17.0

* add ability to edit details from device ([4f0ca81](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/4f0ca817c0c9f587b314d9a8ab95437668b245fe))

v3.16.1

* prevent if-match header if version is blank ([4fcf9d7](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/4fcf9d7c37890e5fd647e23c879742a54ce2c22d))

v3.16.0

* enable TLS pinning in UI ([542d029](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/542d02946836b54516153d7c52e05e674279cfb0))

v3.15.0

* display TLS settings ([#2105](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2105)) ([807b173](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/807b173c24fa33082c460170dee7bb6405e93324))

v3.14.3

* bulk delete is now throttled ([d113890](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/d113890db7d48815bd2f5ce757b4e0e62195e6b2)), closes [#2116](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2116) [#2117](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2117)

v3.14.2

* remove disabled attribute from tag and instead use disableRipple ([#2115](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2115)) ([aee2cf0](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/aee2cf0ee40ec9f35697a1975c7793a2f33e9808))

v3.14.1

* tooltip for bulk action ([9e61594](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/9e61594c6f2026b0009df4d1f550382de03d9570)), closes [#2112](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2112)

v3.14.0

* add active indicator to device-detail page ([35c3c77](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/35c3c77b5738ac4018fff84c2ec2ee14207558cc))

v3.13.1

* menu options no longer duplicate ([dc0ff10](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/dc0ff107628371fa2431c3c138c36ab2835d13b3))

v3.13.0

* display network settings ([#2043](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2043)) ([3a51275](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/3a5127516bd1c71be7d027196d1ac8104fcff9a9))

#### Go WSMAN Messages

v2.17.0

* added Wireless Synchronization to v2 config ([#436](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/436)) ([2a6d781](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/2a6d7815531f3095a439ec75e4e1337322962044))

v2.16.7

* add EncryptWithKey to interface ([#431](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/431)) ([57f5b93](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/57f5b9350f067b557d6894c98218ccedf6484f0c))

v2.16.6

* allows encryption with specified key ([#430](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/430)) ([80cc1f2](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/80cc1f2defb4bced438f6122c22d29d624761f5d))

v2.16.5

* adds wireless profile name to v2 config for use as ElementName w/ AMT ([#429](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/429)) ([9e27ab0](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/9e27ab02ddab8d20baa2bb132d4b033e35586ba0))

v2.16.4

* update ieee8021x config struct to be a pointer ([#427](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/427)) ([fc160e7](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/fc160e7e81d19ba54f33af3c153d5e0e6ba0e187))

v2.16.3

* updates ieee8021x config struct to support pxetimeout ([#426](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/426)) ([eb7a6a3](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/eb7a6a32e5c9de1cbed5670c2becb321c69091dc))

v2.16.2

* add allownontls option to config ([#425](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/425)) ([f1c4d6c](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/f1c4d6c3c2833e0981b0d04c8bb634cc7ff3fb33))

v2.16.1

* updates encrypt and decrypt functions and tests ([#419](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/419)) ([0ab03e4](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/0ab03e4b43c92885258f6ce0b81268a378fe7b56))

v2.16.0

* provide common encrypt, decrypt, config services along with config ([#412](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/412)) ([3a64481](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/3a644816905be378eb91e66c29bfa79167586638))

v2.15.3

* alarm calls ([#414](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/414)) ([56b1e2e](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/56b1e2e0464ba20f517a849629eeab428d6e543e))

v2.15.2

* centralized error handling to be more central ([#406](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/406)) ([632e02f](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/632e02f8f3a93d08f8bbdb51fbdebe0865885f46))

v2.15.1

* update network decoder strings to be more readable ([#403](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/403)) ([5101f74](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/5101f74975404d69afcb7195bb4fd87374f1215b))

v2.15.0

* adds centralized wsman error struct and decode for boot and kvm ([#401](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/401)) ([b4ea5d3](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/b4ea5d31d6e9600539f57788bf2b0e1863b8f845))

v2.14.0

* enable cert pinning for redirection capabilities ([#396](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/396)) ([ed14c05](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/ed14c05f56dee4bb75d369c1c1dbf451b49b79c5))

v2.13.0

* support getting server certificate ([#394](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/394)) ([abfed6d](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/abfed6d2e42e3458574a3c1e3e2ca0abca7dc0e4))

v2.12.1

* amt boot message now uses correct casing for xml parameters ([#390](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/390)) ([4969614](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/49696141ed5bc9e68752b0c2161816b3b576b968))

#### UI Toolkit Angular

v8.0.5

* dependency updates

v8.0.4

* **sol:** emits data now onKey ([#1521](https://github.com/open-amt-cloud-toolkit/ui-toolkit-angular/issues/1521)) ([cfc5032](https://github.com/open-amt-cloud-toolkit/ui-toolkit-angular/commit/cfc5032ed66ffc4830b5cfafb865a2cdeb0981ed))

## Project Boards

Check out our new [Sprint Planning](https://github.com/orgs/open-amt-cloud-toolkit/projects/10/views/2) project board to see what stories the dev team is actively working on, what is in our backlog, and what is planned for the next sprint.
