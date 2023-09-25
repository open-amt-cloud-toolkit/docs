--8<-- "References/abbreviations.md"
## Release Highlights

!!! note "Note From the Team"
    
    Greetings everyone,

    While Arizona experiences a welcome cooldown, the Open AMT Cloud Toolkit team is cranking up the heat with our latest release! In this month's update, we're thrilled to announce two exciting new features added to RPC-Go. It's now more versatile than ever with ACM activation and Wifi configuration capabilities.

    With these enhancements, RPC-Go empowers users to configure AMT into either ACM or CCM without the necessity of engaging with a cloud service. This newfound autonomy provides our customers with a level of flexibility that was previously unattainable. Furthermore, RPC-Go now extends its support to configure any type of wifi profile that AMT supports locally.

    We're excited about these advancements and look forward to hearing your feedback.

    *Best wishes,*  
    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-new-box: **New Feature: Local ACM Activation**

With this release, you can now activate AMT into ACM just using RPC using the `-local` flag.  Similar to local CCM activation, local ACM activation will require secrets to be passed to the AMT device, so users of this feature will need to have high trust in the local OS.  View full command line options in [Activate Device Locally](https://open-amt-cloud-toolkit.github.io/docs/2.14/Reference/RPC/commandsRPC/#activate-the-device-locally)

Local activate command:
``` bash
rpc activate -local -acm -amtPassword NewAMTPassword -provisioningCert "{BASE64_PROV_CERT}" -provivisioningCertPwd certPassword
``` 

:material-new-box: **New Feature: Local Wifi Configuration**

In this release, we have added the ability to configure any wifi profile, not just 802.1x wifi profiles.  Users will also be able to configure multiple wifi profiles at the same time by providing the details either via the command line or by passing in a config file.  View full command line options in [`addwifisettings` RPC Configure command](https://open-amt-cloud-toolkit.github.io/docs/2.14/Reference/RPC/commandsRPC/#addwifisettings)

Local wifi configuration command:
```bash
rpc configure addwifisettings -config config.yaml -secrets secrets.yaml
```

## Get the Details

### Additions, Modifications, and Removals

#### RPS

v2.16.1

- Fix: blocks AMT 11.12 system activation if build number < 3000 ([#1176](https://github.com/open-amt-cloud-toolkit/rps/issues/1176)) (#a3e527b)

v2.16.0

- Feat: support for sha1 hash added via mebx ([#1155](https://github.com/open-amt-cloud-toolkit/rps/issues/1155)) (#b630e11)

#### RPC

v2.14.2

- ensure warning for CCM deactivation password flag

v2.14.1

- addwifisettings - track added certs to prevent duplicates error

v2.14.0

- local wifi configuration

v2.13.1

- update ProjectVersion to 2.13.0

v2.13.0

- activate in acm using local command

#### Sample Web UI

v2.13.1

- remove UI override of AMT feature settings ([#1328](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/1328)) (#510dff3)
- update status message ([#1334](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/1334)) (#bd80ebf)

v2.13.0

- display component versions ([#1267](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/1267)) (#2dbca39)
- fix dark theme (#cdea729)

#### wsman-messages

v5.5.1

- update build tasks, package.json and changelog (#9274dab)

#### go-wsman-messages

v1.8.2

- AddWifiSettings check for empty client cert ([c19c9b4](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/c19c9b42d40ae15b28bfabc2b4e6daef0b489b8f))

v1.8.1

- undo breaking changes ([23c91ed](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/23c91ed35af23f5e940f5cd1ffdd04d22f72bb9f))

v1.8.0

- Adds structs to parse xml for deleting all wifi configs ([d64d4d4](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/d64d4d402a30e36474c56260d863aabded52a092))
- amt: adds amt PublicPrivateKeyPair struct for response ([eca5a6e](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/eca5a6ec878540b8aaca44fc61d1a1fc3505ce74))
- amt: adds pull responses for publickey and publicprivate ([10bf4a8](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/10bf4a8e9e48548630d5a4555539b2d9e99331c1))
- amt: adds wifiportconfiguration.AddWiFiSettingsResponse ([2158757](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/21587573d5426e575ea36ada4d1e39ec7348cc8d))
- cim: adds concrete.dependency support ([ae8f3d3](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/ae8f3d3d5fdb639a4fc145d54e8c0e19b2be93f6))
- cim: adds credential.context support ([6db69ad](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/6db69ad165329a1e4f5f73e6a62a69f27cf665ff))

v1.7.0

- cim: adds responses for WiFiPortConfigurationService and WifiPort ([6cbaa36](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/6cbaa36605d4855fbcf97d2fe2cfb6dd3777b6c7))

v1.6.0

- ips: add additional strongly typed output for ([90aa393](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/90aa393b477d12dfafc00de94307f9adfb0ad42d)), closes [#18115](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/issues/18115)

## Project Board

Check out our new [Feature Backlog](https://github.com/orgs/open-amt-cloud-toolkit/projects/5) project board to see issues and prioritized items we're working on across all of our repositories.  You'll also see what is coming in our next release!
