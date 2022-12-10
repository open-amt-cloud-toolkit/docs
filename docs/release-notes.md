--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center;">
 <iframe width="800" height="450" src="https://www.youtube.com/embed/Wg7z3Jg6kFg" title="Open AMT November Release Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

!!! note "Note From the Team"
    Hey everyone,

    For those in the United States, we hope you all had a wonderful Thanksgiving holiday and for our customers everywhere, our team is very thankful for your feedback, contributions, and the opportunity to continue working with all of you.  You all are the reason we are able to continue working on Open AMT Cloud Toolkit.  We have implemented some much asked for improvements and features in our November release in addition to a cornucopia of resolved issues and external contributions!  Check out the [release video](#release-highlights) where Mike talks about this release's highlights and you can find the details of this release under [what's new](#whats-new) section.

    *Best wishes,*  
    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-star:** Database update required **
An upgrade to the `mpsdb` database is required. Please run the following SQL script to add two new columns before upgrading the services:
``` sql
ALTER TABLE devices 
ADD COLUMN IF NOT EXISTS friendlyname varchar(256);
ALTER TABLE devices 
ADD COLUMN IF NOT EXISTS dnssuffix varchar(256);
```

:material-new-box:** Feature: AMT Maintenance command **

We added a maintenance task command (synchostname) that enables syncing the OS hostname and DNS Suffix with AMT hostname and DNS suffix. If the OS and AMT hostnames are different when the command is run, the OS hostname will be applied to AMT. This maintenance task enables AMT to respond to network requests that use the fully qualified domain name (FQDN) of the device.

:material-star:** Customer Request: Service startup improvement **

Both RPS and MPS now check for dependent services available before starting up. If a dependent service is not available, the RPS and MPS wait and retry after a few seconds. After 10 retry attempts the service shuts down. In a production deployment, this shutdown typically triggers a restart of the service, starting the cycle again until dependent services are available. Retry attempts are listed in the service logs.

:material-star:** Customer Contributions: Several MPS issues filed and fixed! **

A big thank you to Orin from [Laplink](https://www.laplink.com/) for both filing and fixing several MPS issues! We love getting customer feedback as well as customer contributions. Customers filing issues and then immediately contributing the fix, well, that is what open source is all about!  

## Get the Details

### Additions, Modifications, and Removals

#### RPS
- **health:** add waits for db and vault to be available to respond ([#800](https://github.com/open-amt-cloud-toolkit/rps/issues/800)) (#33561f9)
- **maintenance:** maintenance sync hostname information (#ec9e070)
- **auth:** handle qop="auth-int, auth" header (#8535bf0) 
- **factory:** db singleton was not actually added missing unit test for vault factory (#1ee838d) 
- **profiles:** self-signed cert for tls profile update ([#754](https://github.com/open-amt-cloud-toolkit/rps/issues/754)) (#8544500) 
- see change log for full list of changes

#### MPS
- **db:** maintenance sync hostname information (#d2771c2) 
- **health:** add waits for db and vault to be available to respond to request (#8a5d5a3)
- **issue [#741](https://github.com/open-amt-cloud-toolkit/mps/issues/741):** don't send CHANNEL_CLOSE more than once (#488a615) 
- **issue [#743](https://github.com/open-amt-cloud-toolkit/mps/issues/743):** close channel on Request 'aborted' event (#c29d80d) 
- **issue [#729](https://github.com/open-amt-cloud-toolkit/mps/issues/729):** and use Buffer rather than string for CIRAChannel's sendBuffer (#de565d1) 
- **issue [#668](https://github.com/open-amt-cloud-toolkit/mps/issues/668):** ensure CIM_KVMRedirectionSAP is present before using it (#fd974f8) 
- **issue [#661](https://github.com/open-amt-cloud-toolkit/mps/issues/661):** don't try to access a zero length body ([#734](https://github.com/open-amt-cloud-toolkit/mps/issues/734)) (#98c6a3f) 
- **issue [#735](https://github.com/open-amt-cloud-toolkit/mps/issues/735):** InstanceID and ElementName shouldn't be treated as numeric if they have a leading zero (#fc56834) 
- **api:** getHardwareInfo pulls correct status for CIM_PhysicalMemory ([#731](https://github.com/open-amt-cloud-toolkit/mps/issues/731)) (#38b1759) 
- **auth:** handle qop="auth-int, auth" header ([#722](https://github.com/open-amt-cloud-toolkit/mps/issues/722)) (#42d8fb3) 
- **db:** ensures dbInstance is a singleton ([#727](https://github.com/open-amt-cloud-toolkit/mps/issues/727)) (#04096be) 
- **redirection:** ensure nonce is used correctly ([#728](https://github.com/open-amt-cloud-toolkit/mps/issues/728)) (#76a7c80)
- **cira:** increases stability of calls to a device (#551a540) 
- see change log for full list of changes

#### RPC
- **AMTtimeout:** Handle wait if AMT is not ready
- **cli:** sync hostname
- see change log for full list of changes

#### WSMAN-MESSAGES
- **amt:** remove selector check from wifiPortConfigurationService PUT (#ff192c8)
- **amt:** update provisioning mode and set oemid optional (#276be25)
- **cim:** add 32768 and 32769 allowed values for wifiport (#0bd937e)
- see change log for full list of changes

## Project Board
Check out our new [Feature Backlog](https://github.com/orgs/open-amt-cloud-toolkit/projects/5) project board to see issues and prioritized items we're working on across all of our repositories.  You'll also see what is coming in our next release!
