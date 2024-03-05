--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center">
  <iframe width="800" height="450" src="https://www.youtube.com/embed/" title="March 2024 Release Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

!!! note "Note From the Team"

    A pot of gold isn't the only thing you'll find at the end of the rainbow this month! :rainbow: :four_leaf_clover:

    The March release comes with a new batch of features for RPC-Go to continue to address our enterprise-centric use cases. As part of these efforts, we've established a new channel of secure communication between RPC-Go and Enterprise Assistant directly. See all the details below!

    In other news, you might begin to see the term **Device Management Toolkit**. In the coming months, we are going to start transitioning to this new naming for the overarching Github project. We hope that this sets the team up for the future as we look to expand into new capabilities and features outside of just AMT. This is a ***HUGE*** topic so keep your eyes peeled for a video that'll go into greater detail soon!
    
    *Best Wishes,* 

    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-application: **Announcement: RPC-Go Prebuilt Executables Available**

Starting with RPC-Go v2.25.3, executables for both Linux (Ubuntu) and Windows are available to download under Github Releases! [Check out the Assets section under each specific release to find the executables.](https://github.com/open-amt-cloud-toolkit/rpc-go/releases)

!!! note "Note - Browser Preventing Download"

    Depending on the browser, the download may be temporarily blocked and require manual approval to finish downloading. This typically only occurs on Chromium-based browsers on Windows machines.

<br>

:material-new-box: **Feature: RPC-Go Local TLS Configuration using Enterprise Assistant**

This release, we have enabled support for RPC-Go to communicate with Enterprise Assistant (EA). Now, this allows the ability to pass in an EA server location to RPC-Go in order to obtain CSRs and retrieve a CA-signed certificate for TLS configuration.

```
rpc configure tls -mode Server -password AMTPassword -eaAddress http://192.160.1.100:8000 -eaUsername myUser -eaPassword myPass
```

[See the documentation for additional details](./Reference/RPC/commandsRPC.md#tls)

<br>

:material-new-box: **Feature: RPC-Go Change MEBx Password**

The MEBx password can now be reconfigured by RPC-Go using the following new `configure mebx` subcommand. This is only allowed when the device is activated in ACM mode. CCM mode does not allow remote changing of the MEBx password.

```
rpc configure mebx -mebxpassword newMEBxPassword -password AMTPassword
```

[See the documentation for additional details](./Reference/RPC/commandsRPC.md#mebx)

<br>

:material-new-box: **Enhancement: RPC-Go Sync Clock**

Previously, the `syncclock` command required communication with RPS. Due to the efforts by the team with go-wsman-messages v2.0, this command can now run 100% locally on the AMT device using only RPC-Go.

This `configure` subcommand will execute much faster than the older `maintenance` subcommand version. This is part of an effort to move the majority of the `maintenance` command functionality execution locally to RPC-Go. More info about official deprecation timelines of the `maintenance` command to come in the future!

```
rpc configure syncclock -password AMTPassword
```

[See the documentation for additional details](./Reference/RPC/commandsRPC.md#syncclock-configure)

## Get the Details

### Additions, Modifications, and Removals

#### RPS

v2.22.2

- db: adds create database to init.sql ([a1eee8b](https://github.com/open-amt-cloud-toolkit/rps/commit/a1eee8b6ed12348c892edf74edc95124f0193174))

#### Enterprise Assistant (EA)

- feat: adds rest api endpoints [(#13)](https://github.com/open-amt-cloud-toolkit/enterprise-assistant/pull/13)

#### RPC-GO

v2.27.2

- fix: local acm activation ([2031489](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/20314898a8d26238d3dff90132cbf5da77759f32))

v2.27.1

- fix: password read on prompt ([e1861f6](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/e1861f644bccbbfe7eccc8e2b91eed9353a37b68))

v2.27.0

- feat: adds tls configuration with signed certificate ([71977ee](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/71977eee38303e268ea36ed1de5fad8efc206eac))

v2.26.2

- fix: inject version upon release in CI ([#389](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/389)) ([2fa4355](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/2fa43554ba88f05b61664c8c6149ad2761994b94))

v2.26.1

- fix: update version to v2.26.1 ([#388](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/388)) ([16f007d](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/16f007dc140b890fcfda907892e35333f18cd2f6))

v2.26.0

- feat: adds an option to sync clock locally ([5c806f0](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/5c806f04ab48cb4d9b194eada2149befda05d480))

- fix: check error upon getting lan interface settings ([#386](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/386)) ([1341e0a](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/1341e0af3b3a0fb6902d61747ce453fad83d4dc2)), closes [#369](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/369)

- fix: read AMT and SMB passwords without terminal echo unless requested ([#357](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/357)) ([5f02918](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/5f02918e5a719cce8f8f7edaaef8c82be7499b14))

v2.25.3

- fix: test executable flows for githubrelease ([#377](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/377)) ([b1d5dcf](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/b1d5dcfd7f3a0ca42e4773d9065a0f864d509e6e))

v2.25.2

- fix: this releases rpc-go with go-wsman-messages v2.1.3 ([#376](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/376)) ([dba0b36](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/dba0b3600d435355f2aa6541e0906b20a3523e95))

#### go-wsman-messages

v2.1.7

- fix: PKCS10Request now will be accepted by AMT ([#238](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/238)) ([1de9675](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/1de967586ce3465f533270213b42b1efe0497ec5))

v2.1.6

- fix: align get calls to take a string as their input ([#234](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/234)) ([3966ecf](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/3966ecf88827c62c03ec978c671ceaa2259cf9fd))

v2.1.5

- revert: "docs(cim): adds code comments for mediaaccess package ([#220](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/220))" ([#224](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/224)) ([701c3ab](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/701c3ab8ea8046c006696075eed0cacaa07e8e26))

v2.1.4

- fix: set OptInRequired to uint32 ([#221](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/221)) ([865e6d8](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/865e6d80bd10d801e9d567affa8406ff8cb82614))

## Project Boards

Check out our new [Sprint Planning](https://github.com/orgs/open-amt-cloud-toolkit/projects/10/views/2) project board to see what stories the dev team is actively working on, what is in our backlog, and what is planned for the next sprint.
