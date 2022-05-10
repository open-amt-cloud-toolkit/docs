--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center;">
  <iframe width="800" height="450" src="https://www.youtube.com/embed/jh_NCEvLWHs" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

<p class="divider"></p>
## Note From the Team

Hey everyone,

It has been a very quick 6 weeks and the team is very excited to deliver Open AMT Cloud Toolkit version 2.3.  Unlike previous releases, every component of the Toolkit has been updated in some way.  If you haven't had a chance yet, I encourage you to watch the release video where Mike provides some highlights from this release.  Additionally, we've added a [Video Walkthroughs](https://open-amt-cloud-toolkit.github.io/docs/2.3/videos/) section to our documentation where Bryan Wendlandt has been creating video tutorials of our [Getting Started Guide](https://open-amt-cloud-toolkit.github.io/docs/2.3/GetStarted/prerequisites/).  Watch that space for additional video content to be delivered there.

Find out [what's new](#whats-new) and delve into the [details](#get-the-details) below-- and enjoy our new release of the toolkit.

*Best wishes,*<br>
*Matt Primrose | Product Owner | The Open AMT Cloud Toolkit Team*
<br>
<p class="divider"></p>

## What's New?

:material-star:** Customer Request: RPC-Go as a library**

We added an option to build RPC as a library, allowing developers to import RPC into their applications as a dynamically linked library (.dll) or shared object (.so). Rather than deploy and execute the RPC as an application, developers can now call and monitor RPC directly within their own applications. GCC is still required.

:material-auto-fix:** Improvement: RPC-Go Refactoring**

Our Go version of RPC underwent significant refactoring to eliminate all C/C++ code. By transitioning to 100% Go code, we removed the requirement of the GCC toolchain to build RPC as an application. Developers can cross-compile RPC on Linux or Windows and use it on any Go-supported OS (e.g., We tested on Fedora, and it worked without any code changes). The build time is greatly reduced. This version of RPC is still in beta.

:material-star:** Customer Request: GET Device by hostname**

Our GET Devices REST API call now supports a new hostname query parameter. If you know the hostname, it is easy to find the specific device connected to MPS. Provide the hostname of the device with the hostname= query parameter, and MPS will return the device with the matching hostname.

:material-new-box:** Feature: Add CIRA support for static IP devices**

With this release we added support for CIRA configurations with static IP addresses. AMT will now connect to an MPS when it is configured with a static IP address.

:material-new-box:** Feature: MQTT events for redirection start and stop **

When redirection sessions start or stop (KVM or SOL), MPS will now send an event to the MQTT broker

:material-auto-fix:** Improvement: UI Toolkit Angular - v13 support**

With this release, UI-Toolkit-Angular supports Angular v13. This breaking change is indicated by the major version transition to 3.x.x. If you are still on Angular 12, stick with UI-Toolkit-Angular 2.0.5 until you migrate Angular v13.

:material-auto-fix:** Improvement: UI Toolkit - KVM mouse alignment when scrolled**

We fixed a remote and local mouse pointers misalignment problem that occurred during downward scrolling in KVM.  This is implemented in version 2.0.6 of the UI Toolkit

## Get the Details

### Additions, Modifications, and Removals
#### Open AMT Cloud Toolkit
- **deployment:** updated Kong routes for Docker, K8S, and ACI deployments
#### RPS
- **cira:** adds setting MpsType to 'both' (#a4a0017)
- **cira:** removes DHCP check (#8ef1d52) 
- **healthcheck:** handle vault missing (#5cd1627) 
- **network:** handles put response for AMT_generalsettings ([#638](https://github.com/open-amt-cloud-toolkit/rps/issues/638)) (#5234e9b) 
- **network:** handles when only one ethernet port setting (#5db81fc) 
- **nonce:** set nonce to 8 character hexadecimal ([#609](https://github.com/open-amt-cloud-toolkit/rps/issues/609)) (#01fda14) 
- **websockets:** add input validation checks (#0725fce) 
- see change log for full list of changes
#### MPS
- **API:** Adds hostname query parameter to getDevices (#d67cc3d) 
- **redirection:** adds mqtt start and stop events for redirection ([#573](https://github.com/open-amt-cloud-toolkit/mps/issues/573)) (#e51906e) 
- **ws:** prevents multiple KVM/SOL session attempts ([#587](https://github.com/open-amt-cloud-toolkit/mps/issues/587)) (#8051abb) 
- **dockerfile:** set user as non-root (#4808186) 
- **nonce:** set nonce to 8 character hexadecimal (#2135830) 
- **healthcheck:** improves testability and code coverage (#02ff45f) 
- **mps:** Input validation checks in APFProcessor for max size ([#597](https://github.com/open-amt-cloud-toolkit/mps/issues/597)) (#82e3efd) 
- see change log for full list of changes
#### RPC-Go
- **build:** adds support for c-shared buildmode
- **logging:** adds support for fine grained control of log output
- **heci:** adds retry for device busy
- **lms:** rewrite lme communication in go
- **main:** eliminate need for CGO if not building library
- see change log for full list of changes
#### MPS Router
- **env:** add option to override default mps host (#0b5fdd9) 
- **healthcheck:** adds flag for checking db status (#b3360c7) 
- see change log for full list of changes
#### Sample Web UI
- cira + static ip configuration (#9c0f06a) 
- Show DHCP/Static on Profiles page (#22432c2) 
- **redirection:** adds property to track redirection state (#aaaaff8) 
- fix status code expectation (#2f080e9) 
- see change log for full list of changes
#### UI Toolkit
- aligns cursor properly when scrolling (#f4d4669) 
- **kvm:** scrolling offset for mouse is fixed in ui-toolkit 2.0.6 (#dabc394)
- UI Toolkit - Angular *** Breaking Change ***  components now require angular 13
- see change log for full list of changes
#### WSMAN-MESSAGES
- **createBody:** handles LinkPolicy arrays (#96ba28e) 
- **amt:** remove un-implemented method (#07bf552)
- see change log for full list of changes
- **cira:** adds MpsType set to both (#5fb6763)
- **AMT:** Adds Remote Access Policy Applies to MPS (#b8ca4b9) 

## Resolved Issues
#### RPS
- **[Vault health check can return a false positive result](https://github.com/open-amt-cloud-toolkit/rps/issues/629):** Bug
#### MPS
- **[Allow filtering devices by hostname](https://github.com/open-amt-cloud-toolkit/mps/issues/548):** Enhancement
#### RPC-Go
- **[Root certificates not present in AMT device](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/42):** Bug
- **[both c rpc and rpc-go seem to be missing the DNS Suffix set in MEBx](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/26):** Needs More Investigation
- **[rpc-go missing some output compared to the c version, and intermittently misses other pieces](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/25):** Bug
#### Sample Web UI
- **[Websocket Connection Failures should be propagated to UI](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/586):** Enhancement

## Open Issues and Requests
#### Open AMT Cloud Toolkit
- **[Kustomize Install](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/103):** Enhancement
- **[After proxy, where to config the proxy or change the npm repository before docker-compose?](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/110):** Documentation
- **[Support for MongoDB in addition to PostgreSQL](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/117):** Enhancement
#### RPS
- **[RPS should support wildcard domain suffix](https://github.com/open-amt-cloud-toolkit/rps/issues/97):** Enhancement
- **[Data shouldn't be added if vault calls fail](https://github.com/open-amt-cloud-toolkit/rps/issues/254):** Bug
- **[Use database abstraction/ORM layer to support multiple SQL-based database](https://github.com/open-amt-cloud-toolkit/rps/issues/414):** Enhancement
- **[Support Intel AMT Alarm Clock feature](https://github.com/open-amt-cloud-toolkit/rps/issues/524):** Enhancement
- **[Poor error msg related WiFi profile issues](https://github.com/open-amt-cloud-toolkit/rps/issues/594):** Enhancement
- **[RPS not able to remove wifi profile from already configured deviceEnhancement](https://github.com/open-amt-cloud-toolkit/rps/issues/597):** Bug 
#### MPS
- **[Should return error on additional KVM connections for a single device](https://github.com/open-amt-cloud-toolkit/mps/issues/104):** Enhancement
- **[AMT does not connect to MPS after configuration](https://github.com/open-amt-cloud-toolkit/mps/issues/300):** Known Issue
- **[Use database abstraction/ORM layer to support multiple SQL-based database](https://github.com/open-amt-cloud-toolkit/mps/issues/360):** Enhancement
- **[Feature Request: Create configuration parameter to disable "Auth" Service from MPS](https://github.com/open-amt-cloud-toolkit/mps/issues/439):** Enhancement
- **[CIRA connection getting dropped randomly](https://github.com/open-amt-cloud-toolkit/mps/issues/441):** Bug
- **[Short Lived Bearer Token for KVM Session Support](https://github.com/open-amt-cloud-toolkit/mps/issues/527):** Enhancement
#### RPC
- **[activation failures would benefit from passing the RPS error code to the client](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/27):** Enhancement
- **[Gosh it would be excellent if rpc could tell the user that they don't have an AMT compatible network device](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/28):** Enhancement
- **[possible timing issues in rpc-go?](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/30):** Enhancement
#### Sample Web UI
- **[UI always shows "Certificate Not Yet Uploaded"](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/483):** Question
#### UI Toolkit
- **[Command string generated from "Add a New Device" dialog does not activate a machine.](https://github.com/open-amt-cloud-toolkit/ui-toolkit/issues/451):** Bug


