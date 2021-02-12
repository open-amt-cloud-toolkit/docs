# Release Notes
## Key Feature Changes for 1.1
This section outlines key features changes between versions 1.0 and 1.1 for [Open Active Management Technology (Open AMT) Cloud Toolkit.](Glossary.md#o) 

### Additions
#### [RPS](Glossary.md#r)
- **Network Configuration on Intel&reg; AMT devices:** Added feature to AMT Profiles to select configuring Intel&reg; AMT devices to use DHCP or Static IP.  When set for static IP, Intel&reg; AMT will sync with the Host OS static IP address.  Static IP Address is not supported with CIRA profiles.
- **MEBx Password configuration:** The AMT Profile now supports configuration options for setting either a defined or randomized MEBx password on Intel&reg; AMT devices.
- **CORS support:** Added support for Cross-Origin Resource Sharing (CORS).

#### [RPC](Glossary.md#r)
- **Added/updated getting metadata from Intel&reg; AMT device:** Improved getting DNS Suffix (OS), Hostname (OS), FQDN (AMT), and DNS Suffix (AMT) from Host OS and Intel&reg; AMT.
- **CentOS 7 Support:** Build steps added to support CentOS 7.
- **--nocertcheck option:** Option added to skip the TLS cert check for Websocket connections. This is to aid testing in development environments where self-signed TLS certificates are used.

#### [MPS](Glossary.md#m)
- **CORS Support:** Added support for Cross-Origin Resource Sharing (CORS).

#### [UI Toolkit](Glossary.md#u)
- **CORS support:** Added support for Cross-Origin Resource Sharing (CORS).
- **MEBx Password option added to Profile Editor:** Provides the ability to set a MEBx password when activating Intel&reg; AMT devices.
- **Network Setting option added to Profile Editor:** Provides the ability to set either DHCP or Static IP setting when activating Intel&reg; AMT devices.
- **Edit feature added to Profile Editor:** Added ability to edit AMT, CIRA, and Domain profiles in the Profile Editor.

### Modifications and Removals
#### [RPC](Glossary.md#r)
- **Improved Link Status when using --amtinfo:** Fixed link status not being set.
- **Improved build scripts for Windows and Linux:**  Build scripts have been updated so that the build time and executable size is more consistent between Windows and Linux.
- **Release/Debug build changes:** Release and Debug build options now have the exact same functionality.  The only difference is that debug symbols are included in Debug version.

#### [MPS](Glossary.md#m)
- **Moved SampleUI into it's own repository:** We have some big changes planned for the Sample UI.  Stay tuned!
- **Default allowList setting changed:** Changed the default setting to false.  This is one less configuration change to make if you are not using Vault.  Recommend that this is set to true when running MPS in a production environment.

## Known Issues in 1.1
- **Vault Deployment:** Current docker build scripts deploy Vault in developer mode. When the Vault container is brought down in this mode, all data stored in Vault is lost. For production deployments, deploy Vault in production mode and follow best security practices for unsealing Vault and handling access to Vault. For details, see [Hashicorp* Vault Deployment Guide](https://learn.hashicorp.com/tutorials/vault/deployment-guide). With Vault running in production mode, the data that RPS stores in Vault is retained when the container is brought down.
- **Intel® AMT Connecting to MPS:** After a successful configuration, Intel® AMT device will occasionally fail to connect to the MPS. In this situation there are two ways to prompt Intel® AMT to attempt to re-connect to MPS:
- **Intel&reg; AMT Connecting to MPS:** After a successful configuration, Intel&reg; AMT device will occasionally fail to connect to the MPS. In this situation there are two ways to prompt Intel&reg; AMT to attempt to re-connect to MPS:
    1.	Unplug and re-plug the network cable
    2.	Reboot the Intel&reg; AMT device
- **Intel&reg; AMT device fails to re-connect to MPS after MPS is not available for an extended period of time:** If the MPS goes down for more than 2 days, Intel&reg; AMT devices will no longer attempt to connect to MPS. If this happens, there are two ways to prompt Intel&reg; AMT to attempt to re-connect to MPS:
    1.	Unplug and re-plug the network cable
    2.	Reboot the Intel&reg; AMT device
- **KVM freeze intermittently** Viewing a remote desktop with high amount of screen changes (video playback), the KVM session can intermittently freeze.
- A full list of current open issues can be found in the issues page for each repository