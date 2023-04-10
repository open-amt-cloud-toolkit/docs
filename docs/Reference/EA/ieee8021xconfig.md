!!! warning "Wired 802.1x Configuration is a Preview Feature"
    Wired 802.1x Configuration feature is a Preview Feature. This means it has not been fully validated and cannot be guaranteed to work. There are still potential bugs and tweaks needed for a production-level feature standard. Interested in this feature and helping us test it? Reach out via GitHub.

IEEE 802.1X is an IEEE Standard for port-based network access control (PNAC). It provides an authentication mechanism to devices wishing to attach to a LAN or WLAN.

It typically consists of three parts:

1. Supplicant (Client-end User, AMT Device)
2. Authenticator (Access Point or Switch)
3. Authentication Server (RADIUS Server)

## Prerequisites

The following are requirements to configure and connect an AMT device within an 802.1x environment. However, these are not required for the RPS profile creation steps below.

- [Enterprise Assistant configured, running, and connected to an RPS server.](overview.md)
- Updated to latest AMT Firmware version

!!! note "Note - System Name Length"
    **The System Names of the AMT devices must be 15 characters or less.** If the name is greater than 15 characters long, it will exceed the system name length allowed by Active Directory and Enterprise Assistant will fail to add the device.

## Wired 802.1x Configuration

**Only one** wired IEEE8021x Config can be created (per tenant). The following steps walk through how to create the required configs and profiles.

#### To create a Wired IEEE802.1x Config:

1. Select the **IEEE 802.1x** tab from the left-hand menu.

2. In the top-right corner, click **Add New.**
     <figure class="figure-image">
     <img src="..\..\..\assets\images\RPS_New8021xConfig.png" alt="Figure 1: Create a new IEEE802.1x Config">
     <figcaption>Figure 1: Create a new IEEE802.1x Config</figcaption>
     </figure>

3. Specify a **Profile Name** of your choice.

4. Select an **Authentication Protocol**.

    Four authentication protocols are supported for wired.

    |Auth Protocol   | API Value | Description                              |
    | -------------- | --------- | ---------------------------------------- |
    |EAP-TLS         | 0         | Indicates that the desired EAP type is the Transport Layer Security EAP type specified in [RFC 2716](https://www.rfc-editor.org/rfc/rfc2716).                |
    |PEAPv1/EAP-GTC  | 3         | Indicates that the desired EAP type is the Protected Extensible Authentication Protocol (PEAP) Version 1 EAP type specified in [draft-josefsson-pppext-eap-tls-eap](https://tools.ietf.org/html/draft-josefsson-pppext-eap-tls-eap-10), with Generic Token Card (GTC) as the inner authentication method.                  |
    |EAP-FAST/GTC    | 5         | Indicates that the desired EAP type is the Flexible Authentication Extensible Authentication Protocol EAP type specified in [IETF RFC 4851](https://www.rfc-editor.org/rfc/rfc4851),     with Generic Token Card (GTC) as the inner authentication method.      |
    |EAP-FAST/TLS    | 10        | Indicates that the desired EAP type is the Flexible Authentication EAP type specified in [IETF RFC 4851](https://www.rfc-editor.org/rfc/rfc4851), with TLS as the inner authentication   method.      |

5. Optionally, change the **PXE Timeout**.

    PXE Timeout is the number of seconds in which the Intel(R) AMT will hold an authenticated 802.1X session. During the defined period, Intel(R) AMT manages the 802.1X negotiation while a PXE boot takes place. After the timeout, control of the negotiation passes to the host.

6. Click **Save.**
    
    !!! example "Example IEEE802.1x Config"
        <figure class="figure-image">
        <img src="..\..\..\assets\images\RPS_Create8021xConfig.png" alt="Figure 2: Example IEEE802.1x Config">
        <figcaption>Figure 2: Example IEEE802.1x Config</figcaption>
        </figure>

#### To link to an AMT Profile:

1. Select the **Profiles** tab from the left-hand menu.

2. Choose an existing profile or create a new one.

3. Under Network Configuration, select the **Enable Wired 802.1x Profile** checkbox.

4. Click **Save**.

    After creating the profile and configs, AMT can now be configured for wired 802.1x.

    !!! example "Example ACM Profile with IEEE802.1x"
        <figure class="figure-image">
        <img src="..\..\..\assets\images\RPS_CreateProfile_8021x.png" alt="Figure 3: Example ACM profile with IEEE802.1x">
        <figcaption>Figure 3: Example ACM profile with IEEE802.1x</figcaption>
        </figure>


<!-- ## Wireless 802.1x Configuration -->