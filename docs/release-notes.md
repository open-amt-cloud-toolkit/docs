--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center;">
 <iframe width="800" height="450" src="https://www.youtube.com/embed/oIgNy5D0gr4" title="Open AMT January Release Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

!!! note "Note From the Team"
    Hey everyone,

    Happy New Year!  The team has been hard at work through December and January (and a bit of February) to deliver some very big features in this release!  We have a new component, added new enterprise features, and some game changing improvements for developers!  Check out the [release video](#release-highlights) where Mike and Madhavi talk about this release's highlights. You can find the details of this release under [what's new](#whats-new) section.

    It’s with mixed emotions that after over 2 years working on this project, Mike has decided to move on to tackle other challenges.  Madhavi, who has been on the project from the very beginning, has stepped up as our Lead Developer.  While Mike isn’t going far, we wish him much success on his new project.

    *Best wishes,*  
    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-star:** Database update required **
An upgrade to the `rpsdb` database is required. Please run the following SQL script to add two new columns before upgrading the services:

``` sql
ALTER TABLE IF EXISTS profiles
ADD COLUMN IF NOT EXISTS tls_signing_authority varchar(40) NULL;
```

[More information or detailed steps can be found in Upgrade Toolkit Version](../Deployment/upgradeVersion/).

:material-new-box:** New Component: Enterprise Assistant **
As we add new features for our enterprise focused customers, we needed a capability that is deployed inside of the enterprise to facilitate communication with enterprise services such as certificate authority and active directory.  Enterprise Assistant is a C# based application that provides this capability.  Currently, it supports talking to Microsoft Certificate Authority for certificate signing requests.  [Find more information about Enterprise Assistant here](../Reference/EA/overview/) with more documentation coming in the near future! 

:material-star:** Feature: Signed TLS Certificates **

Leveraging the capabilities of Enterprise Assistant, Open AMT Cloud Toolkit now supports configuring AMT with TLS certificates signed by a Microsoft Certificate Authority.  This allows local network management consoles to securely connect to AMT and verify the device identity based on the shared root certificate.

:material-api:** Customer Request: Improved Return Codes **

When RPC is used as a library it used to be difficult to parse the results of an activation or maintenance task.  With this release we add return codes (0-99) for RPC specific errors.  For example, if RPC is unable to connect to RPS, a specific error code will be provided for this issue instead of a general failure code.  [See the full list in the RPC CLI Documentation](../Reference/RPC/libraryRPC/#rpc-error-code-charts). You can also check out the [GitHub discussion](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/discussions/146).

:material-api:** Improvement: Custom Middleware **

For both RPS and MPS, we have provided the ability to add custom middleware.  This middleware will run on every REST call before Open AMT Cloud Toolkit stack processes the call.  This allows developers to supply custom information through the REST API headers that can then be processed by the custom middleware and acted on when interacting with back-end services such as the database or secret store.  This is great for handling tenant IDs for multi-tenancy or custom secret store implementations. [Read more about new Custom Middleware here](../Reference/middlewareExtensibility/).  We look forward to seeing how our customers use this.

:material-exclamation-thick:** Breaking Changes: WSMAN-MESSAGES and UI-Toolkit Angular **

Both of these components have updates that cause breaking changes.  If you are using these components, you will need to make changes to your code to use these new versions.

## Get the Details

### Additions, Modifications, and Removals

#### RPS
- **activation:** add TLS CA Cert generation with MSFT CA ([#816](https://github.com/open-amt-cloud-toolkit/rps/issues/816)) (#535485e) 
- **api:** adds multitenancy support ([#795](https://github.com/open-amt-cloud-toolkit/rps/issues/795)) (#dfbdadb) 
- **api:** add support for custom middleware (#5d3d135)
- activation status message output ([#881](https://github.com/open-amt-cloud-toolkit/rps/issues/881)) (#3add4a6) 
- handle unepxected parse errors with retry invokeWsmanCall ([#841](https://github.com/open-amt-cloud-toolkit/rps/issues/841)) (#f68a401) 
- eslint issues (#da0e55c) 
- if MPS isn't available, RPS should not error when attempting to add/remove devices from MPS ([#828](https://github.com/open-amt-cloud-toolkit/rps/issues/828)) (#8996080) 
- enhance API validation ([#820](https://github.com/open-amt-cloud-toolkit/rps/issues/820)) (#5867346) 
- Adding a device which is already activated in ACM fails (#c4456d4) 
- **health:** fix vault health check failure when in HA mode (#86971a7)
- align interface structure to MPS (#9c8dc7a) 
- align environment usage to match MPS (#69c1f2f) 
- upgrade lint dependencies and add recommended rules (#2d1e601) 
- upgrade lint dependencies and add recommended rules (#ecc7f53)

#### MPS
- **api:** enhance multitenancy support ([#747](https://github.com/open-amt-cloud-toolkit/mps/issues/747)) (#ae25c87) 
- **api:** add support for custom middleware (#11746a7) 
- **api:** ensure middleware is loaded from correct directory (#2870b9c)
- upgrade lint dependencies and add recommended rules (#88a14f4)

#### RPC
- added flag tenantId
- **rps:** added proxy support
- proper processing of command line flags
- adds new return codes

#### UI Toolkit Angular
V5.0.0
BREAKING CHANGES

- Upgraded to angular 15

#### WSMAN-MESSAGES
v5.0.0

BREAKING CHANGES

- complete restructuring of library (#320) (0f35728)

v4.0.0

- amt: handles when detection strings is not array (7d70982)
- adds GET, ENUMERATE, PULL methods to all calls (9103e54)

BREAKING CHANGES

- added enumerationContext as the first parameter to all calls

v3.2.0

- amt: add 802.1x support (82ffa8a)
- cim: add 802.1x support (87026a1)
- ips: add 802.1xCredentialContext methods (debc7c9)

v3.1.0

- amt: add GeneratePKCS10RequestEx method ([#771](https://github.com/open-amt-cloud-toolkit/rps/issues/771), [#770](https://github.com/open-amt-cloud-toolkit/rps/issues/770), [#768](https://github.com/open-amt-cloud-toolkit/rps/issues/768)) (53cdc6f) 

#### Sample Web UI
- **profiles:** add tls support for Signing Authority selection ([#948](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/948)) (#d45b13f) 
- remove mqtt from ui (#959ab11) 


## Project Board
Check out our new [Feature Backlog](https://github.com/orgs/open-amt-cloud-toolkit/projects/5) project board to see issues and prioritized items we're working on across all of our repositories.  You'll also see what is coming in our next release!
