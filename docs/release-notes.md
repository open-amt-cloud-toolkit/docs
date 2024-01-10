--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center">
  <iframe width="800" height="450" src="https://www.youtube.com/embed/N_1koCmZKbw?si=GPukyEFgUfKOxSLK" title="IDER Tutorial Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

!!! note "Note From the Team"

    Happy New Year! :material-party-popper:

    It's time to get the party started with the first release of the year. And this was a big one! Thankfully, most of the team was able to find some time for a bit of rest and vacation (and hopefully you've been able to as well). IDE Redirection was a big year-end goal for us and we are thrilled to be able to deliver it. Check out the short video above for a quick intro and demo of the feature.

    Looking ahead, we aren't planning on letting up the pace at all this year. We hope you'll stick with us for all of 2024 and continue to be our partners and collaborators for Open AMT. There's so much to come that we are beyond excited to share with you all!

    *Best Wishes,* 

    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-update: **DB Update Required**

Run the following SQL scripts to add new columns to the `rpsdb` prior to upgrading the service. [Detailed upgrade steps can be found in Upgrade Toolkit Version.](./Deployment/upgradeVersion.md)

``` sql title="rpsdb"
ALTER TABLE IF EXISTS profiles
ADD COLUMN IF NOT EXISTS local_wifi_sync_enabled BOOLEAN NULL;
```

We have added a new boolean, `localWifiSyncEnabled`, to our Profile APIs. If this is enabled, the Local Management Service (LMS) will synchronize Windows user Wi-Fi profiles with AMT. [In-depth details about the property can be found in the AMT SDK.](https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/default.htm?turl=WordDocuments%2Fuserprofilesandadminprofiles1.htm)

:material-new-box: **Feature: IDE Redirection (IDER)**

With this release, we have now fully implemented the redirection feature, IDER.  IDER enables the ability to remotely boot a CD-ROM image to perform tasks like OS reimaging remotely. As part of this release, we have integrated it into the Sample Web UI as an example as well as provided updated UI-Toolkit-React and UI-Toolkit-Angular components.

[Learn more about IDER and how it works in the IDE-Redirection Tutorial](./Tutorials/ideRedirection.md)

or [see how to implement it using React in the updated UI Toolkit Tutorial.](./Tutorials/uitoolkitReact.md)

:material-new-box: **API: Redirection Status**

We've added a new `GET` API in MPS which will allow you to check if there are any redirection sessions open for a device. Check out the MPS API `/devices/redirectionStatus/{guid}` in the [MPS API Docs for full details](./APIs/indexMPS.md).

```json
{
  "isKVMConnected": true,
  "isSOLConnected": false,
  "isIDERConnected": false
}
```

## Get the Details

### Additions, Modifications, and Removals

#### RPS

v2.22.0

- feat: add wifi sync enable to profiles table ([#1334](https://github.com/open-amt-cloud-toolkit/rps/issues/1334))

- fix: message when changing password on TLS device ([#1352](https://github.com/open-amt-cloud-toolkit/rps/issues/1352))


#### MPS

v2.13.8

- fix: updates validation to uuid ([#1242](https://github.com/open-amt-cloud-toolkit/mps/issues/1242))

v2.13.7

- fix: adds hostname length check ([#1241](https://github.com/open-amt-cloud-toolkit/mps/issues/1241))

v2.13.6

- fix: remove unnecessary console.log statements ([8b92598](https://github.com/open-amt-cloud-toolkit/mps/commit/8b9259817aa0a34cf2f1f4a7973509a12c88e3f3))
- fix: validate username ([#1240](https://github.com/open-amt-cloud-toolkit/mps/issues/1240))

v2.13.5

- fix: update redirect to handle multiple connections ([#1203](https://github.com/open-amt-cloud-toolkit/mps/pull/1203))


#### RPC

v2.24.3

- fix: makes sure uuid flag warning is only shown when the flag is used ([877ccba](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/877ccbae2428f15bc635fec9c7b0d15b0b3f9495))

v2.24.2

- fix: local activation supports .pfx ([#297](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/297))


#### Sample Web UI

v3.4.0

- feat: enable IDER functionality ([#1548](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/1548))

v3.3.0

- feat: about notice appears after login ([#1554](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/1554))

v3.2.0

- feat: adds Wi-Fi synchronization option ([#1537](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/1537))
- fix: test update release ([7018978](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/701897862f5014401d5f83765bea442a9b57fb09))


#### UI Toolkit

v3.2.1

- chore: update build tasks, package.json and changelog ([#823](https://github.com/open-amt-cloud-toolkit/ui-toolkit/pull/823))


#### UI Toolkit React

- feat: adds IDER component ([#975](https://github.com/open-amt-cloud-toolkit/ui-toolkit-react/issues/975))


## Project Boards

Check out our new [Sprint Planning](https://github.com/orgs/open-amt-cloud-toolkit/projects/10/views/2) project board to see what stories the dev team is actively working on, what is in our backlog, and what is planned for the next sprint.
