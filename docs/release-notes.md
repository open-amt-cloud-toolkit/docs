--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center;">
  <iframe width="800" height="450" src="https://www.youtube.com/embed/AQvaB-5BfFs" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

<p class="divider"></p>
## Note From the Team

Hey everyone,

We are very excited to release Open AMT Cloud Toolkit version 2.4. For this release, the team primarily focused on adding features requested by customers and making improvements to automation tests. You can find more details under [what's new](#whats-new) section which outlines key features added to this release. Also, If you haven't had a chance yet, I encourage you to watch the release video where Mike provides some highlights from this release.

*Best wishes,*<br>
*The Open AMT Cloud Toolkit Team*
<br>
<p class="divider"></p>
## What's New?

:material-star:** Customer Request: Support for configuring Wi-Fi only platforms**

With this release, Customers can now provision and manage vPro AMT platforms which only have a vPro AMT supported Wi-Fi adapter. These platforms can only be activated in CCM. For ACM activation, manual touch through MEBx is required.

:material-star:** Customer Request: Short lived JWT for redirection sessions**

MPS can now issue a short-lived JWT (default 5 min) that can be used to authenticate Redirection sessions between the console and MPS so that Redirection sessions can only be initiated by an authenticated and authorized user. This short-lived token can be configured using "redirection_expiration_time" property in `.mpsrc` file within MPS or overridden with ENV. You can find more details about the API under User Authentication section of MPS APIs.

:material-new-box:** Feature: HTTP Entity Conflict Support in RPS**

We added support for entity conflicts in RPS, so that we can pre-check if profile data is fresh before updating it (to avoid mid-air collisions). This will help avoid situations where profile data has been changed prior to sending updates. This adds a new `version` property to the APIs and will be required to be sent in the payload for updates or the value must be present in the `if-match` header.

:material-star:** Customer Request: Configuration setting to disable/enable MPS auth**

When customers use their own authentication server, there should be a way to disable default MPS JWT User Authentication. The configuration setting "web_auth_enabled" in MPS lets users to enable/disable default MPS JWT User Authentication. This configuration is enabled by default and recommend to set it to false only when using a different authentication server. This setting will not affect the new API Endpoint for Short Lived JWTs that is required for Redirection sessions.

:material-new-box:** Improvement: Set minimum TLS version for CIRA connections**

Some versions of TLS encryption algorithms supported by AMT are weaker than others. This configuration option lets users to enforce minimum TLS version to restrict CIRA connections (connection betwween MPS and AMT) from older versions of AMT. By default, `minVersion` property (within `mps_tls_config`) in `.mpsrc` is set to TLSv1 as the older versions of AMT (i.e., AMT version <=10) use TLSv1. Changing this value to newer versions of TLS will effectively prevent older versions of AMT from connecting.

:material-new-box:** Improvement: Removed auto-load toggle and always auto-load certificate**

We removed the auto-load toggle from the CIRA Config page on our Sample Web UI as it is typically used with the full Open AMT Cloud Toolkit. By default, the CIRA certificate will always auto-load so that the UI is more simplified. If you wish to manually provide the CIRA certificate, you may do so using the RPS API directly.


## Get the Details

### Additions, Modifications, and Removals
#### Open AMT Cloud Toolkit
- **healthchecks:** health check probes draft (#dea1ff3)
- **db:** update db scripts for rps (#6f90244)

#### RPS
- **network:** support WiFi only activation and provisioning ([#655](https://github.com/open-amt-cloud-toolkit/rps/issues/655)) 
- **concurrency:** adds 409/412 response codes for resource conflicts (#13a1522) 
- **profile:** added user consent, kvm, sol and ider to AMT profile ([#651](https://github.com/open-amt-cloud-toolkit/rps/issues/651)) (#3306ae3) 
- **cira:** added an error message when failed to remove certs ([#664](https://github.com/open-amt-cloud-toolkit/rps/issues/664)) (#645d28a)  
- see change log for full list of changes

#### MPS
- **api:** to get short lived bearer token for direction sessions ([#612](https://github.com/open-amt-cloud-toolkit/mps/issues/612)) (#32c5652)
- **auth:** Added a User Auth configuration setting to disable/enable MPS auth (#897e9f2)
- **Security:** variable to set minimum TLS version ([#611](https://github.com/open-amt-cloud-toolkit/mps/issues/611)) (#4657e06)
- see change log for full list of changes

#### Sample Web UI
- **auth:** redirection expiration time is set to 5 minutes (#c11bf29) 
- **devices:** differentiation between out-of-band and in-band power actions (#06e5d43) 
- **etag:** handle version conflicts in UI with popup dialog (#b70c20e) 
- **login:** MPS web_auth_enabled set to false, sample web ui cannot be ([#656](https://github.com/open-amt-cloud-toolkit/rps/issues/656)) (#6e04c77) 
- **profiles:** remove none connection option (#6292482)
- **cira:** remove auto-load slider, always auto-load certificate (#38b8b81) 
- **profiles:** remove excess mebx random password warning (#db35499) 
- **profile-detail:** update logic to be more readable (#b5722ab) 
- all password fields toggle hidden ([#658](https://github.com/open-amt-cloud-toolkit/rps/issues/658)) (#4372357) 
- put power menu options back on device-toolbar (#e6ba52d) 
- see change log for full list of changes

## Resolved Issues
#### RPS
- **[Connecting to Lanless Device with CIRA and WLAN Profiles fails](https://github.com/open-amt-cloud-toolkit/rps/issues/645):** Enhancement
- **[RPS not able to remove wifi profile from already configured device](https://github.com/open-amt-cloud-toolkit/rps/issues/597):** Bug
#### MPS
- **[Short Lived Bearer Token for KVM Session Support](https://github.com/open-amt-cloud-toolkit/mps/issues/527):** Enhancement
- **[Feature Request: Create configuration parameter to disable "Auth" Service from MPS](https://github.com/open-amt-cloud-toolkit/mps/issues/439):** Enhancement

## Open Issues and Requests
#### Open AMT Cloud Toolkit
- **[Kustomize Install](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/103):** Enhancement
- **[Support for MongoDB in addition to PostgreSQL](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/117):** Enhancement
- **[Are there plans to support OCR??](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/133):** Enhancement
- **[v2.3.0 docker-compose.yml is using the latest tag for the docker images](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/129):** Tech-Debt
#### RPS
- **[RPS should support wildcard domain suffix](https://github.com/open-amt-cloud-toolkit/rps/issues/97):** Enhancement
- **[Data shouldn't be added if vault calls fail](https://github.com/open-amt-cloud-toolkit/rps/issues/254):** Bug
- **[Use database abstraction/ORM layer to support multiple SQL-based database](https://github.com/open-amt-cloud-toolkit/rps/issues/414):** Enhancement
- **[Support Intel AMT Alarm Clock feature](https://github.com/open-amt-cloud-toolkit/rps/issues/524):** Enhancement
- **[Poor error msg related WiFi profile issues](https://github.com/open-amt-cloud-toolkit/rps/issues/594):** Enhancement
- **[Any plans for a MutualTLS implementation?](https://github.com/open-amt-cloud-toolkit/rps/issues/656):** Enhancement
- **[Reconfiguring an AMT device (without unprovisioning) fails for TLS Profiles](https://github.com/open-amt-cloud-toolkit/rps/issues/663):** Bug
#### MPS
- **[AMT does not connect to MPS after configuration](https://github.com/open-amt-cloud-toolkit/mps/issues/300):** Known Issue
- **[Use database abstraction/ORM layer to support multiple SQL-based database](https://github.com/open-amt-cloud-toolkit/mps/issues/360):** Enhancement
- **[MPS should wait for vault to be unsealed - CIRA connections fail](https://github.com/open-amt-cloud-toolkit/mps/issues/614):** Enhancement
#### RPC
- **[activation failures would benefit from passing the RPS error code to the client](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/27):** Enhancement
- **[Gosh it would be excellent if rpc could tell the user that they don't have an AMT compatible network device](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/28):** Enhancement
- **[Occasionally Receive APF_CHANNEL_OPEN_FAILURE](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/55):** Bug
- **[Library build of rpc-go should use return codes](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/57):** Enhancement
#### Sample Web UI
- **[UI always shows "Certificate Not Yet Uploaded"](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/483):** Question
#### UI Toolkit
- **[Command string generated from "Add a New Device" dialog does not activate a machine.](https://github.com/open-amt-cloud-toolkit/ui-toolkit/issues/451):** Bug