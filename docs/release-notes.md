--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center;">
 <iframe width="800" height="450" src="https://www.youtube.com/embed/mSkvJuKCQPE?si=BU4n8IcL6-woFgzM" title="Open AMT October Release Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

!!! note "Note From the Team"

    As 2023 draws to a close, we're thrilled to celebrate an exceptional year together. With 39 feature releases, successful integrations of Open AMT Cloud Toolkit into new software versions by our valued customers, and the establishment of our community Discord server, reaching 99 members (and aiming for 100 by December's end), it's been an incredible journey.
    
    Your continuous support has been invaluable. We deeply appreciate your involvement, feedback, and enthusiasm that have shaped our progress. Looking ahead to 2024, we're excited about delivering more innovative features and continuing our partnership.
    
    Thank you for being an integral part of our success this year. Here's to an even more remarkable and collaborative year ahead!

    *Wishing you all a happy holidays,*  
    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-update: **DB Update Required**

Run the following SQL scripts to add new columns to the `mpsdb` prior to upgrading the service.

``` sql title="mpsdb"
    ALTER TABLE devices
    ADD COLUMN IF NOT EXISTS lastconnected timestamp with time zone,
    ADD COLUMN IF NOT EXISTS lastseen timestamp with time zone,
    ADD COLUMN IF NOT EXISTS lastdisconnected timestamp with time zone;
```

With this release we have added the ability to track the last time a device connected, disconnected or was seen by the services.  This information is included when retrieving information about a device. 

[More information or detailed steps can be found in Upgrade Toolkit Version.](./Deployment/upgradeVersion.md)

:material-new-box: **Coming Soon: IDE Redirection**

The team is getting really close to releasing the final redirection feature included with AMT, IDE-R.  This feature will allow users to remotely boot an AMT device to a remote boot image (located on the management console).  The core components have been implemented and are released as part of the UI Toolkit component.  Expect to see updates to the Sample Web UI very soon that will provide an example for how to integrate and use this new features.  

:material-new-box: **New Feature: Local wifiport enable**

We've added a new feature to allow customers to use RPC-Go to enable AMT on the wifi adapter as well as enabling wifi profile syncing (if LMS is present).  Customers have requested this feature to provide an easy way to enable AMT over wifi even if they aren't setting up any wifi profiles in their AMT profile.  We are exposing this as a new "configure" option.

``` bash title="RPC-Go"
rpc configure enablewifiport -password AMTPassword
```

:material-new-box: **New Feature: AMT Enabled Flag**

We have added "Operational State" as part of AMTINFO report.  For 13th Gen vPro (AMT 16.1) and newer devices, this will indicate if AMT is currently enabled.  If AMT is disabled, RPC-Go will automatically enable AMT during the activation process.

## Get the Details

### Additions, Modifications, and Removals

#### RPS

v2.21.2

- fix: update build tasks, package.json and changelog ([#1341](https://github.com/open-amt-cloud-toolkit/rps/pull/1341))

v2.21.1

- fix: update build tasks, package.json and changelog ([#1330](https://github.com/open-amt-cloud-toolkit/rps/pull/1330))

v2.21.0

- feat: add timestamp to device info data ([#1302](https://github.com/open-amt-cloud-toolkit/rps/pull/1302)) 

v2.20.0

- feat: adds release trigger to security report


#### MPS

v2.13.4

- fix: update build tasks, package.json and changelog

v2.13.3

- fix: update changelog ([#1199](https://github.com/open-amt-cloud-toolkit/mps/issues/1199))

v2.13.2

- fix: pdate build tasks, package.json and changelog ([#1198](https://github.com/open-amt-cloud-toolkit/mps/issues/1198))

v2.13.1

- fix: updates lint rules to remove unbound method check

v2.13.0

- feat: add cira timestamps to db ([#1153](https://github.com/open-amt-cloud-toolkit/mps/pull/1153))

v2.12.6

- fix: boot order for IDER ([#1143](https://github.com/open-amt-cloud-toolkit/mps/issues/1143))


#### RPC

v2.24.1

- fix: project version is updated ([88dc463](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/88dc4635a402e364665f6219c864c60794790129))

v2.24.0

- feat: add UUID Override flag to maintenance commands ([#294](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/294))

v2.23.0

- feat: support AMTEnabled flag ([2547018](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/2547018910c6d8d4d8dcfb8d34e7ad21d5183987))

v2.22.0

- feat: adds report out to code analysis action ([aa2efcf](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/aa2efcf9cfe883c6e57d313e4245e4d68afbc730))

v2.21.0

- feat: support smb: urls for remote .yaml or .pfx config files ([935115e](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/935115e8cd9cb4451b7002971db3837c2fb6e7c9))

v2.20.0

- feat: add local wifi enable and profile sync ([8ab0894](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/8ab08942cd6f0848faf82162d05ad8eccf43db66))

#### Sample Web UI

v3.1.2

- fix: update build tasks, package.json and changelog ([#1547](https://github.com/open-amt-cloud-toolkit/sample-web-ui/pull/1547))

v3.1.1

- fix: update ci automation to correct tag to webui

v3.1.0

- feat: use db data when device not connected ([#1499](https://github.com/open-amt-cloud-toolkit/sample-web-ui/pull/1499)) 

v3.0.0

- build: bump Angular to 17 ([#1491](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/1491))
- BREAKING CHANGES: Node 16 no longer supported

v2.16.0

- feat: adds report out to code analysis action ([68a2255](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/68a2255c3deca55c2d8475430dca1fff990e33ba))

#### UI Toolkit

v3.2.0

- feat: add mode query param for kvm, ider and sol ([28b9e30](https://github.com/open-amt-cloud-toolkit/ui-toolkit/commit/28b9e303bddbaa34ee004d874c64a9ca741bb620))

v3.1.1

- fix: separated floppy and cdrom read/writes

v3.1.0

- feat: added IDER support ([#781](https://github.com/open-amt-cloud-toolkit/ui-toolkit/issues/781))

v3.0.0

- BREAKING CHANGES: AMT Redirector requires a configuration object and removed ILogger

## Project Boards

Check out our new [Sprint Planning](https://github.com/orgs/open-amt-cloud-toolkit/projects/10/views/2) project board to see what stories the dev team is actively working on, what is in our backlog, and what is planned for the next sprint.
