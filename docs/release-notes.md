--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center">
  <iframe width="800" height="450" src="https://www.youtube.com/embed/5Zz5RbKHaA4?si=f495o_uJj8tu-j0G" title="June 2024 Release Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

!!! note "Note From the Team"
    
    The team is very proud to now have a first-look ready of Console, a new alternative to the unsupported MeshCommander tool. [More details about what Console is can be found below](#whats-new).

    There is still a lot that the team wants to add and is working on, but we are making great progress. As it is in Alpha currently, expect lots of functionality and changes to come, as well as some bugs along the way, as we continue to expand and iterate on what Console can offer!

    You can follow the progress of new Console features in our [Feature Backlog](https://github.com/orgs/open-amt-cloud-toolkit/projects/10/views/2).
    
    *Best Wishes,* 

    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-new-box: **Console (Public Alpha Now Available)**

An Alpha version of Console is now available for people to try out! See the video at the top for an overview and demo.

Console is a 1:1 out-of-band management tool for managing Intel AMT on on-premises style networks. After a device is added, Console communicates with AMT directly over the local network providing a quick and easy way to connect and manage all of your AMT devices.

The Console UI is based on a modified version of our existing Sample Web UI and is packaged as a single browser application. **[See the Console Alpha Documentation for more info.](./Reference/Console/overview.md)**

**[Download and try the latest Alpha tag of Console here](https://github.com/open-amt-cloud-toolkit/console/tags).**

<br>

## Get the Details

### Additions, Modifications, and Removals

#### Console

v1.0.0-alpha.4

- fix: handles when update fails as not found ([05851f4](https://github.com/open-amt-cloud-toolkit/console/commit/05851f47a5a77e28429f71ec9c63c36b9416b95d))
- fix: **sql:** ensure postgres inserts are working ([#201](https://github.com/open-amt-cloud-toolkit/console/issues/201)) ([f603c26](https://github.com/open-amt-cloud-toolkit/console/commit/f603c26f54a0714e05663b14222edaa11510a589))

v1.0.0-alpha.3

- feat: add mac builds ([2366f92](https://github.com/open-amt-cloud-toolkit/console/commit/2366f922c8f7952599b7df1b3b0d0a8f51011ebe))

v1.0.0-alpha.2

- fix: allows string input for userconsent code ([#167](https://github.com/open-amt-cloud-toolkit/console/issues/167)) ([9a52830](https://github.com/open-amt-cloud-toolkit/console/commit/9a52830b82fccfcc0c51ef0c62225a9e85e0bd21))

v1.0.0-alpha.1

- Initial Alpha tag, [see Github tag for all commits](https://github.com/open-amt-cloud-toolkit/console/releases/tag/v1.0.0-alpha.1)

#### RPC-Go

v2.34.2

- fix: resolves close call issue in go-wsman-messages ([#550](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/550)) ([af9ffdb](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/af9ffdb9e1faae44a876346b9e08e67fb88e08b4))

#### go-wsman-messages

v2.8.0

- feat: decodes audit log extended data ([#350](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/350)) ([34e338d](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/34e338d2e52f57c91bf27992db2d4ca47548e2f6))

v2.7.1

- fix: remove close calls when body not defined ([#342](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/342)) ([3e4cc79](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/3e4cc792233b1feb87e16f08c6beddc6e448b8d2))

v2.7.0

- feat: support get certificates api ([#336](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/336)) ([66b61b9](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/66b61b9b893735231835d9091c4cab02f127e3f1))

v2.6.1

- fix: updates event log to be api compatible ([#335](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/335)) ([80639a1](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/80639a10bcaee9139a2512daeca5e3287de2fd5d))

v2.6.0

- feat: adds event log decoder ([#333](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/333)) ([53583b8](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/53583b82be10552694183443602dbb5e5bb431d9))

v2.5.5

- fix: revert linting changes ([#332](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/332)) ([60e62db](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/60e62db5f93a92665664175f56d11eb753434d84))

v2.5.4

- fix: **ips:** changes selector from name to instanceID for deletetion ([#329](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/329)) ([9365153](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/936515362d5b5201e4e62275831dbd1877045165))

v2.5.3

- fix: cim_credentialcontext pull returns complete results ([#326](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/326)) ([0a0052c](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/0a0052ce3a03044d558f25bccf85e9b14e19bd1d))

v2.5.2

- fix: completed 8021x credential context typing ([#322](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/322)) ([206eae8](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/206eae851b797e6aea3f19546b0042ae22fbf886))

v2.5.1

- fix: completed tls credential context typing ([#318](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/318)) ([596cd1a](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/596cd1a92117cb0f1cd4fd8d7fd2b3636e47ddb7))

## Project Boards

Check out our new [Sprint Planning](https://github.com/orgs/open-amt-cloud-toolkit/projects/10/views/2) project board to see what stories the dev team is actively working on, what is in our backlog, and what is planned for the next sprint.
