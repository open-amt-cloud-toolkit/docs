--8<-- "References/abbreviations.md"

Enterprise Assistant is a Windows application that can run as a normal application or as a background Windows service. Once setup to connect to RPS (hosted in either the cloud or enterprise) or RPC-Go, it can be used to assist with the configuration of AMT devices using TLS. Enterprise Assistant will handle certificate signing requests (CSRs) to Microsoft CA.

Enterprise Assistant is based off the open-source project [MeshCentral Satellite](https://github.com/Ylianst/MeshCentralSatellite).

<figure class="figure-image">
    <img src="..\..\..\assets\images\EA_Architecture.png" alt="Figure 1: Enterprise Assistant Architecture">
    <figcaption>Figure 1: Enterprise Assistant Architecture</figcaption>
</figure>

## Details

Enterprise Assistant must run on a computer that is joined to your domain and with sufficient rights that it can create LDAP computer objects. It must have access to the Domain Certificate Authority so it can request that certificates be signed.

RPS can be run from either the cloud or the local enterprise network.

It is suggested to run Enterprise Assistant as a normal Windows application at first to make sure everything works correctly before running it as a background Windows service. You can start by going in the "Settings" option in the menus. Settings are also saved in a local `.config` file that can be referenced when running as a background Windows service.

## Prerequisites

### Software

- [git](https://git-scm.com/downloads)
- [Microsoft* Visual Studio 2022 Community or better](https://visualstudio.microsoft.com/downloads/)

    Requires installation of the **.NET Desktop Development** Workload under the Desktop & Mobile section at time of installation.


### Services

While not required for this guide just to build Enterprise assistant, the following services are required and assumed to be configured and running in your enterprise environment when attempting to provision AMT.

- Microsoft* Certificate Authority (CA)
    - An AMT TLS Certificate template is required. See [TLS Certificate Template](tlsCertTemplate.md) for additional steps on creating a template.
- Microsoft* Active Directory (AD)

## Setup

The Enterprise Assistant repository is a codebase that needs to be compiled into a Windows executable before being able to run. 

1. Clone the Enterprise Assistant Repository.
    ```
    git clone https://github.com/open-amt-cloud-toolkit/enterprise-assistant.git
    ```

2. Open the project file `OpenAMTEnterpriseAssistant.csproj` in Visual Studio.

3. From the menus, choose `Build > Build OpenAMTEnterpriseAssistant`.

4. By default after compiling, the `.exe` will be saved in `.\enterprise-assistant\bin\Debug\OpenAMTEnterpriseAssistant.exe`.

    <figure class="figure-image">
        <img width="400" src="..\..\..\assets\images\EA_Startup.png" alt="Figure 2: Enterprise Assistant Startup">
        <figcaption>Figure 2: Enterprise Assistant Startup</figcaption>
    </figure>

## Configuration

There are two ways to configure Enterprise Assistant:

- [**RPC-Go Local Configuration**](./LocalConfiguration/rpcgoConfiguration.md)

    The RPC-Go local configuration option does not communicate with a remote server (RPS). RPC-Go will establish a communication channel to Enterprise Assistant (EA) directly and handle the CSR process. The wanted configuration options will be passed via command line flags or a config `.yaml`/`.json` file using RPC-Go. Configuration of AMT is handled entirely locally by RPC-Go.

- [**RPS Remote Configuration**](./RemoteConfiguration/rpsConfiguration.md)

    RPS will handle communication with Enterprise Assistant (EA). Desired configuration options will be provided via the AMT profile, Wireless Config, and IEEE802.1x Config. RPS will communicate with EA at the time of provisioning to configure 802.1x and/or TLS configuration options based on the profiles.

<br>