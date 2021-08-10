--8<-- "References/abbreviations.md"
# Release Notes

If you haven't had a chance - checkout the [Letter From Devs](./letter.md) for a message from our development team.

## Announcements
### Long Term Support Release
The Long Term Support (LTS) release of Open AMT Cloud Toolkit is official and is planned for Q3 2021. With the release of LTS, the version of Open AMT Cloud Toolkit and all of the components will be moving to 2.0.0. Why the major version change? During the 1.X development period, we made many breaking changes as we were improving our external interfaces, database schemas, and communication protocols. Starting with 2.0, we will no longer be introducing breaking changes in minor version releases. This means that any 2.X component will be compatible with other 2.X components. With this adherence to [semantic versioning](https://semver.org/) our goal is to allow our customers the flexibility to upgrade versions with confidence and clarity of compatibility.

## Key Feature Changes for 1.5
This section outlines key features changes between versions 1.4 and 1.5 for Open AMT Cloud Toolkit.

### Breaking Changes
#### : 

### Additions
#### RPS
- **Wireless Configuration:** 
- **RPS Events:**
#### MPS
- **API Paging support:**
#### UI Toolkit
- **Split up Core, React, and Angular code into different repositories:** 
#### Sample Web UI
- **UI updated to handle Wireless configurations:**
### Modifications and Removals
#### MPS

#### Sample Web UI
- **Improvements:** We have made some minor changes and improvements in the Sample Web UI to streamline profile creation and provide additional information on the devices page.
    - The UI now sets the password length for new random passwords, removing the need for the password length field in the CIRA Config and Profiles. The REST APIs still support user defined values from 8 to 32 for password length.
    - On the devices page, we have added the device hostname, GUID, and tags to help with easily finding this information for each device.

## Resolved Issues in this release
#### Open AMT Cloud Toolkit
#### RPS
#### MPS
- **[MPS won't start when tls_offload is set to true or https is set to false](https://github.com/open-amt-cloud-toolkit/mps/issues/288)**
#### UI Toolkit
#### Sample-Web-UI
- **[CIRA Config Name Smashed](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/278)**
- **[Logging out of Sample-Web-UI page while on an active KVM session does not take user back to login page](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/283)**
- **[Logging out of UI if user performs power actions on a device with invalid amt password](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/301)**
- **[Pages with multiple REST calls won't populate any information if a single call fails](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/333)**
- **[Error message misleading when using KVM in CCM Mode](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/362)**

## Known Issues in 1.5
#### Intel&reg; AMT
- **Intel&reg; AMT device fails to re-connect to MPS after MPS is not available for an extended period of time:** *UPDATE: There is a firmware fix available for this issue, however, we are still testing to ensure that it completely resolves this issue.  We'll let you know once this issue is resolved.*  If the MPS goes down for more than 2 days, Intel&reg; AMT devices will no longer attempt to connect to MPS. If this happens, there are two ways to prompt Intel&reg; AMT to attempt to re-connect to MPS:
    1.	Unplug and re-plug the network cable
    2.	Reboot the Intel&reg; AMT device
#### Open AMT Cloud Toolkit
- **[Power policy should be selected at BIOS under Intel®ME Power Control screen -Mobile: On in So, MEWake in S3, S4-5 –Power Package 2 for performing device poweron/off operations](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/19):** Documentation
- **[Scaling- KVM shows white screen](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/39):** Known Issue
- **[Scaling- Connecting to SOL does not work correctly](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/40):** Known Issue
#### RPS
- **[Software Event Notifications](https://github.com/open-amt-cloud-toolkit/rps/issues/9):** Enhancement
- **[RPS should support wildcard domain suffix](https://github.com/open-amt-cloud-toolkit/rps/issues/97):** Enhancement
- **[Data shouldn't be added if vault calls fail](https://github.com/open-amt-cloud-toolkit/rps/issues/254):** Bug
- **[AMT Wi-Fi Configuration not supported on non-Windows systems](https://github.com/open-amt-cloud-toolkit/rps/issues/349):** Known Issue
- **[Wi-Fi config: Intel AMT system disconnects from mps stack after powering off the device](https://github.com/open-amt-cloud-toolkit/rps/issues/350):** Known Issue
#### MPS
- **[Direct Connection from MPS to AMT](https://github.com/open-amt-cloud-toolkit/mps/issues/10):** Enhancement
- **[Should return error on additional KVM connections for a single device](https://github.com/open-amt-cloud-toolkit/mps/issues/104):** Enhancement
- **[AMT 12 dropping CIRA when sending command while system is off](https://github.com/open-amt-cloud-toolkit/mps/issues/196):** Bug
- **[MPS API /ciracert always reads from file](https://github.com/open-amt-cloud-toolkit/mps/issues/294)**
- **[AMT does not connect to MPS after configuration](https://github.com/open-amt-cloud-toolkit/mps/issues/300):** Known Issue
- **[Audit Log calls never respond on specific versions of AMT](https://github.com/open-amt-cloud-toolkit/mps/issues/301):** Known Issue
#### UI-Toolkit
- **KVM freeze intermittently:** We have added a small delay in handling mouse interactions that prevents us from flooding the AMT channel.  There are still a few occasions where KVM could still freeze.  We are still root causing this new issue
#### Sample-Web-UI
- **[AMT Responses should return status (i.e. NOT_READY) instead of "Sent Succesfully"](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/276):** Enhancement
- **[Can't clear out CIRA config once selected in AMT Profile](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/367):** Enhancement
- **[WiFi Profiles drop-down says "No Wifi configs found" before typing anything](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/368):** Bug

