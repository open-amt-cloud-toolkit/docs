--8<-- "References/abbreviations.md"
## Release Highlights

<!-- <div style="text-align:center">
  <iframe width="800" height="450" src="https://www.youtube.com/embed/5Zz5RbKHaA4?si=f495o_uJj8tu-j0G" title="June 2024 Release Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br> -->

!!! note "Note From the Team"
    
    With record temps in Arizona currently, the team has been enjoying their much needed AC and working away on **Console**. We've made great progress over the last month and you can get all our changes and fixes in our new, **latest Alpha release**.

    We are getting closer to an official **Beta** release! As we start to finish development on the core Console features, we'll be pivoting slightly and begin work on cleaning up the overall usability, bug fixes, and more.

    You can follow the progress of new Console features in our [Feature Backlog](https://github.com/orgs/open-amt-cloud-toolkit/projects/10/views/2).
    
    *Best Wishes,* 

    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-new-box: **Feature: WSMAN Explorer**

Console now has the ability to view both the correctly formatted WSMAN input sent to AMT and the WSMAN output response of the supported classes. This can be used to help with development or to view additional AMT data that might not be currently displayed in the default UI.

Don't see the WSMAN class or call you are looking for? [Submit an issue for Console.](https://github.com/open-amt-cloud-toolkit/console/issues)

**[See the WSMAN Explorer Documentation for more info.](../Reference/Console/wsmanExplorer.md)**

<br>

:material-new-box: **Enhancement: Local Management Service (LMS) No Longer Required**

RPC-Go now communicates directly with AMT without the need for the Local Management Service (LMS). Previously, this was already supported for remote configuration. Now, it is extended to include running local configuration commands. However, we still recommended installing and using LMS for local configuration.

??? note "Note - Additional Information about LMS" 
    **About**
    
    The Local Management Service (LMS) is an application that assists with communication between AMT and the OS. Previously, this was required for running any local-based commands of RPC-Go (e.g. local activation or local configuration). 
    
    **Installation**

    - For **Windows**, the installer is included **in the Intel® Management Engine Drivers package**.
    - For **Linux distributions** that support snap, LMS can be installed **via [https://snapcraft.io/lms](https://snapcraft.io/lms)**.
    - Customers interested in building LMS, can find build instructions at [https://github.com/intel/lms](https://github.com/intel/lms).

    **For additional information about LMS, visit [https://github.com/intel/lms](https://github.com/intel/lms).**

<br>

:material-star: **Community Contribution: `rpc amtinfo` Returns Both OS and AMT IP Addresses**

:material-party-popper: Big shout out to **Github user @tongsean9807** for this contribution! :material-party-popper:

The `amtinfo` command in RPC-Go now differentiates between the IP address set for AMT and the IP address set for the Operating System for deployments that choose to use separate IP addresses. **[See the RPC CLI Documentation for additional info about the `amtinfo` command.](./Reference/RPC/commandsRPC.md#amtinfo)**

``` hl_lines="5 6 12 13"
---Wired Adapter---
DHCP Enabled           : true
DHCP Mode              : passive
Link Status            : up
AMT IP Address         : 0.0.0.0
OS IP Address          : 192.168.1.91
MAC Address            : 80:c4:a8:58:df:e9
---Wireless Adapter---
DHCP Enabled           : true
DHCP Mode              : passive
Link Status            : down
AMT IP Address         : 0.0.0.0
OS IP Address          : 192.168.1.91
MAC Address            : 00:00:00:00:00:00
Certificate Hashes     :
```

<br>

## Get the Details

### Additions, Modifications, and Removals

#### Console

v1.0.0-alpha.6

- fix: devices use unique connections now ([3f3e29d](https://github.com/open-amt-cloud-toolkit/console/commit/3f3e29de66f07dc3f93907d1c66f15d06e145e9d))
- fix: registers routes required for monaco editor ([1136f33](https://github.com/open-amt-cloud-toolkit/console/commit/1136f33dbdd4baef1dbc99c227465a790e981208))

v1.0.0-alpha.5

- feat: added get certificates api ([#135](https://github.com/open-amt-cloud-toolkit/console/issues/135)) ([7e7bfd8](https://github.com/open-amt-cloud-toolkit/console/commit/7e7bfd8c6c4526d09d7717b072dd0702a446b400))
- feat: adds amt explorer feature ([#172](https://github.com/open-amt-cloud-toolkit/console/issues/172)) ([9f3d70e](https://github.com/open-amt-cloud-toolkit/console/commit/9f3d70e9dfb07e3b0580d0dc70963c10547c4a72))
- feat: domains check password and expiration ([d687c30](https://github.com/open-amt-cloud-toolkit/console/commit/d687c307caed561c7c4b198dcdc35704ffc12b1d))
- feat: use dto in devices ([#240](https://github.com/open-amt-cloud-toolkit/console/issues/240)) ([99f97fc](https://github.com/open-amt-cloud-toolkit/console/commit/99f97fc03edc4e1920f4816a21b778a18edb8277))
- feat: use dto in getfeatures ([2d3bc4f](https://github.com/open-amt-cloud-toolkit/console/commit/2d3bc4f642df141b649e97b2204fc8dd4318f1d2))
- fix: ensure tagging is working with embedded SQL, fix alarms ([#233](https://github.com/open-amt-cloud-toolkit/console/issues/233)) ([9505a81](https://github.com/open-amt-cloud-toolkit/console/commit/9505a8108690f46fc38c8c075cd7ab90ee16d677))
- fix: logging level should now be respected ([1308c83](https://github.com/open-amt-cloud-toolkit/console/commit/1308c83816adaa49d336413e92dcce5de6e8ca20))
- test: added integration tests ([#217](https://github.com/open-amt-cloud-toolkit/console/issues/217)) ([3d2e033](https://github.com/open-amt-cloud-toolkit/console/commit/3d2e033dfad871d5168417723f18925db71b5a82))

#### RPC-Go

v2.36.0

- feat: amtinfo command add amt ipaddr and osipaddr ([#560](https://github.com/open-amt-cloud-toolkit/rpc-go/pull/560))

v2.35.0

- feat: enable local commands without lms ([#486](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/486)) ([8b7e7b1](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/8b7e7b1bad73aa903a1e11294e78831d07c8fb45))

#### Sample Web UI

v3.10.1

- fix: user consent flow for redirection ([#2004](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/2004)) ([7fa1633](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/7fa163335ee945fa7538798615aa347280fd64a8))

v3.10.0

- feat: allow nontls option for console ([#1999](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/1999)) ([1ad376a](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/1ad376a669dc471f9412d47f3206b4cbca5421a9))

v3.9.1

- fix: updates event log to show decoded event information ([#1996](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/1996)) ([74aeca2](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/74aeca205caa641ba6b3218f435e8973eaabc0d0))

v3.9.0

- feat: adds audit log exstr data to table ([#1994](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/1994)) ([38b7ec0](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/38b7ec0ae2357a7d28c4aa93ec7e9a7b26ed1558))

v3.8.0

- feat: adds amt explorer ([#1984](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/1984)) ([2c804b5](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/2c804b5bf9e81b6fff526dcbee2ac9cc8403e10a))

v3.7.0

- feat: add tag management to add/edit device ([7776742](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/7776742c13cf1bc79d64130c0767e8edaa61211f))
- feat: enable enterprise support ([20b859c](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/20b859cecaea1403df56147265585139528aa335))
- feat: enable filtering by tag, and sorting by tag, filtering devices, and edit device ([7d00989](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/7d00989280be3e2b899480da107650508e7adbf8))
- feat: enable menu collapse ([2223bb4](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/2223bb49500aef6b69454328528cef88c2427893)) ([5656707](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/5656707b14ce17dc017b709d65d44b6b11718622))
- feat: enable routing between device-detail components ([b4fce50](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/b4fce5044b13c45b25bbb345d6aab0333340d9c4))
- fix: enables multiple explorer calls ([74490f9](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/74490f94b6661886d37f00b39101fdefe7d1a95b))
- fix: hide generate random password in local mode ([69d74e6](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/69d74e6da75c8e6847108a3bdcb5b54b953e572c))
- fix: xterm css ([a3ff046](https://github.com/open-amt-cloud-toolkit/sample-web-ui/commit/a3ff0467cf347d8d7138aa90e2c3783e4c1492ec))

#### go-wsman-messages

v2.11.0

- feat: adds a function to indicate where successfully authenticated ([#372](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/372)) ([a3f006e](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/a3f006e41523e76b2c5ddd472cc98070030f5bc3))

v2.10.0

- feat: adds more audit log parsing for extended data ([#351](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/351)) ([dfd5d46](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/dfd5d4691081e38f15b3535fb657ba9acbda0ff6))

v2.9.2

- fix: updated types for cim media access ([#362](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/362)) ([da182c3](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/da182c315bc7342511e705addeb4bc4f6948ec2c))

v2.9.1

- fix: tls connections for redirection ([#361](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/361)) ([bda9672](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/bda9672ec7ab459cdd64852575e1f9d3c35f80f9))

v2.9.0

- feat: enables hw calls if lms not available ([#327](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/327)) ([ac30948](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/ac30948a0a978ba0c050d667d223cbf9771ef279))

## Project Boards

Check out our new [Sprint Planning](https://github.com/orgs/open-amt-cloud-toolkit/projects/10/views/2) project board to see what stories the dev team is actively working on, what is in our backlog, and what is planned for the next sprint.
