--8<-- "References/abbreviations.md"

# Local TLS Configuration with RPC-Go

!!! warning "Local TLS Configuration using RPC-Go is a Preview Feature"
    Local TLS Configuration using RPC-Go is a Preview Feature and is subject to change. This means it has not been fully validated and cannot be guaranteed to work. There are still potential bugs and tweaks needed for a production-level feature standard. Interested in this feature and helping us test it? Reach out via GitHub.

The TLS protocol includes the following types of authentication:

- Server Authentication – Only the server is authenticated (i.e., its identity is ensured) while the client remains unauthenticated. This means that the end user (whether an individual or an application, such as a Web browser) can be sure with whom they are communicating.

- Mutual Authentication – The next level of security in which both ends of the “conversation” are sure with whom they are communicating.

When Intel AMT is configured for mutual authentication, it validates incoming client certificates based on the root of trust configured.

## Overview

AMT can be configured to use TLS without the need for a remote server (i.e. RPS). RPC-Go can directly communicate with Enterprise Assistant to perform the configuration.

The following steps highlight how to:

- Configure the connection of EA and RPC-Go
- Run TLS configuration using RPC-Go

## Prerequisites

The following are requirements to configure and connect an AMT device using TLS.

- [Enterprise Assistant](overview.md)
- [RPC-Go](../../GetStarted/buildRPC.md)
- Management Tool supporting TLS (ex: [Meshcommander](https://www.meshcommander.com/meshcommander))

    This is not required for configuration and therefore not needed for this guide. However, a management tool will be needed if you want to manage the device post-configuration.

### Services

The following services are assumed to be configured and running in your enterprise environment.

- Microsoft* Certificate Authority (CA)
    - An AMT TLS Certificate template is required. See [TLS Certificate Template](tlsCertTemplate.md) for additional steps on creating a template.

- Microsoft* Active Directory (AD)

## Configure Enterprise Assistant

1. Run the Enterprise Assistant executable.

2. Open the `File > Settings` menu to configure the RPC-Go connection.

    <figure class="figure-image">
        <img src="..\..\..\assets\images\EA_SettingsEmpty.png" alt="Figure 1: Enterprise Assistant Settings Menu">
        <figcaption>Figure 1: Enterprise Assistant Settings Menu</figcaption>
    </figure>

3. Under **RPC Client** section, set a **Username** of your choice.

4. Set a **Password** of your choice.

5. Set an alpha-numeric **Security Key** of your choice. This key is used when generating JWT tokens for authentication between RPC-Go and EA communication.

6. The `Device Name` is the name used to configure the domain controller for each device account. Using `Node Identifier` is more secure due to the inability to be tampered with but is less friendly to maintain as a user.

7. `Security Groups` will list all of the security groups of the domain controller that have been created within the Computers group. When Enterprise Assistant creates a new Computer account (like a new AMT device), it will join the selected Security Groups.

8. Provide the Certificate Authority and click the checkmark.

9. It will then list the available Certificate Templates to choose from. This will let you select a template specifically created for AMT. See [TLS Certificate Template](tlsCertTemplate.md) for additional steps on creating a template.

10. Choose how to issue the certificate. Typically, `SAM Account Name` is most commonly used as the `Common Name`.

    !!! example "Example - Configured Settings"
        <figure class="figure-image">
            <img src="..\..\..\assets\images\EA_RPCSettingsFull.png" alt="Figure 2: Enterprise Assistant RPC-Go Settings Example">
            <figcaption>Figure 2: Enterprise Assistant RPC-Go Settings Example</figcaption>
        </figure>

11. Press **OK** to save the Settings.

    !!! success "Success - HTTP Server Started"
        <figure class="figure-image">
            <img width=400px src="..\..\..\assets\images\EA_RPCHTTPStart.png" alt="Figure 3: HTTP Server Started Example">
            <figcaption>Figure 3: HTTP Server Started Example</figcaption>
        </figure>

## Configure the AMT Device

1. Open Command Prompt as Administrator.

2. Navigate to the directory with RPC-Go.

3. Run the `rpc configure tls` command. Replace the [bracketed] values with your own.

    ```
    rpc configure tls -mode [configurationMode] -password [AMTPassword] -eaAddress [IP-Address-or-FQDN] -eaUsername [myUsername] -eaPassword [myPassword]
    ```

    The toolkit offers four configuration modes to support various usage models: 

    | CONFIGURATION MODE    | DESCRIPTION                                                                                            |
    | :---------------------| :----------------------------------------------------------------------------------------------------- |
    | Server                | The client authenticates the server request and accepts only those servers with a digital certificate. |
    | ServerAndNonTLS       | **Used primarily for testing.** The client authenticates the server request and accepts legitimate digital certificates from TLS-enabled servers. However, if the server is not TLS-enabled, the client defaults to a CIRA connection.|
    | Mutual                | Both client and server **must** have certs. The client cert is signed by the server cert.              |
    | MutualAndNonTLS       | **Used primarily for testing.** Both client and server certs are expected. The client authenticates the server request and accepts legitimate digital certificates from TLS-enabled servers. However, if the server is not TLS-enabled, the client defaults to a CIRA connection.   |

    !!! success "Success - TLS Configured"
        <figure class="figure-image">
            <img src="..\..\..\assets\images\RPC_EALocalTLSSuccess.png" alt="Figure 4: TLS Configured Example">
            <figcaption>Figure 4: TLS Configured Example</figcaption>
        </figure>

4. Now, the device is manageable via a TLS connection using the management tool of your choice!

<br><br>