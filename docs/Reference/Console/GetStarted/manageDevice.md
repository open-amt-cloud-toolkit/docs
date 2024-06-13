--8<-- "References/abbreviations.md"

!!! warning "Warning - Console in Alpha Development"
    Console is currently under development. The current available tags for download are Alpha version code. This could mean that certain features may not function yet, visual look and feel may change, or bugs/errors may occur. It is not recommended for use in Production deployments. Follow along our [Feature Backlog for future releases and feature updates](https://github.com/orgs/open-amt-cloud-toolkit/projects/10)

## Try out Intel AMT Capabilities

1. Select the newly added AMT device.

    <figure class="figure-image">
        <img src="..\..\..\..\assets\images\Console_Devices.png" alt="Figure 1: Devices Tab">
        <figcaption>Figure 1: Devices Tab</figcaption>
    </figure>

2. Select an action to perform from the Power Actions or Redirection options in the top-right.

    The right-hand navigation menu can be used to find additional device information, such as logs and hardware info, and out-of-band capabilities, such as KVM and Serial-Over-LAN.

    !!! warning "Warning - Power Actions in KVM"
        Turn off active redirection sessions, such as KVM or SOL, before specific power state transitions. Power Cycle (Code 5) and Unconditional Power Down (Power Off, Code 8) will be rejected as invalid if there is an active redirection session. Reset (Code 10) **will function** in KVM along with the [other unmentioned Power Actions](../../powerstates.md#out-of-band).
        

    <figure class="figure-image">
        <img src="..\..\..\..\assets\images\Console_DeviceInfo.png" alt="Figure 2: Device Page and Options">
        <figcaption>Figure 2: Device Page and Options</figcaption>
    </figure>

## Next steps

After successfully adding and managing devices using Console, explore other tools and next-level topics related to Console:

### 802.1x and TLS Environments using Enterprise Assistant
Learn how to setup and use Enterprise Assistant to help with configuring devices for 802.1x and TLS environments using existing Microsoft services such as Microsoft Certificate Authority and Microsoft Active Directory. 

[Get Started with Enterprise Assistant](../../EA/overview.md){: .md-button .md-button--primary }

<!-- ### Security
Learn more about measures and details to secure assets for the Console application. Topics include credentials, allowlisting, best known security methods, and more.

[Learn More about Security and Hardening](../Reference/Console/securityConsole.md){: .md-button .md-button--primary } -->