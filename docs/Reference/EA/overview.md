

Enterprise Assistant is a Windows application that can run as a normal application or as a background Windows service. Once setup to connect to RPS (hosted in either the cloud or enterprise), it can be used to assist with the configuration of AMT devices using TLS. Enterprise Assistant will handle certificate signing requests (CSRs) to Microsoft CA.

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
- [Microsoft* Visual Studio](https://visualstudio.microsoft.com/downloads/)

### Services

The following services are assumed to be configured and running in your enterprise environment.

- Microsoft* Certificate Authority (CA)
- Microsoft* Active Directory (AD)

## Setup

The Enterprise Assistant repository is a codebase that needs to be compiled into a Windows executable before being able to run. 

1. Clone the Enterprise Assistant Repository.
    ```
    https://github.com/open-amt-cloud-toolkit/enterprise-assistant.git
    ```

2. Open the project in Visual Studio.

3. From the menus, choose `Build > Build Solution`.

4. By default after compiling, the `.exe` will be saved in `.\enterprise-assistant\bin\Debug\OpenAMTEnterpriseAssistant.exe`.

    <figure class="figure-image">
        <img width="300" height="169" src="..\..\..\assets\images\EA_Startup.png" alt="Figure 2: Enterprise Assistant Startup">
        <figcaption>Figure 2: Enterprise Assistant Startup</figcaption>
    </figure>

## Configuration

These steps assume you have either an existing, local or cloud, Open AMT deployment. 

### Kong Configuration

To use Enterprise Assistant with Kong API Gateway, we need to configure a new route.

2. Open the `kong.yaml` file in the `./open-amt-cloud-toolkit/` directory.

3. Uncomment the `rps-ea` block to enable the `/ea` route.

    ```
    # uncomment to use with enterprise assistant
    # - name: rps-ea
    #   host: rps
    #   port: 8082
    #   tags:
    #   - rps
    #   routes:
    #   - name: rps-ea-route
    #     strip_path: true
    #     paths:
    #     - /ea
    ```

4. Restart the Kong service.

### Enterprise Assistant Configuration

1. Open the Enterprise Assistant `File > Settings` menu to configure the RPS connection.

    <figure class="figure-image">
        <img width="450" height="253" src="..\..\..\assets\images\EA_SettingsEmpty.png" alt="Figure 3: Enterprise Assistant Settings Menu">
        <figcaption>Figure 3: Enterprise Assistant Settings Menu</figcaption>
    </figure>

2. Provide the RPS Server Hostname. 

    Enterprise Assistant communicates via Websocket. Make sure to include the route `/ea` (e.g. `ws://192.168.1.34/ea`).

3. The `Device Name` is the name used to configure the domain controller for each device account. Using `Node Identifier` is more secure due to the inability to be tampered with but is less friendly to maintain as a user.

4. `Security Groups` will list all of the security groups of the domain controller that have been created within the Computers group. When Enterprise Assistant creates a new Computer account (like a new AMT device), it will join the selected Security Groups.

5. Provide the Certificate Authority and click the checkmark.

6. It will then list the available Certificate Templates to choose from. This will let you select a template specifically created for AMT.

7. Choose how to issue the certificate. Typically, `SAM Account Name` is most commonly used as the `Common Name`.

    !!! example "Example - Configured Settings"
        <figure class="figure-image">
            <img src="..\..\..\assets\images\EA_SettingsFull.png" alt="Figure 4: Enterprise Assistant Settings Example">
            <figcaption>Figure 4: Enterprise Assistant Settings Example</figcaption>
        </figure>

8. Save the Settings.

9. Start the connection by going to `File > Local Connect`.

    <figure class="figure-image">
        <img src="..\..\..\assets\images\EA_Connected.png" alt="Figure 5: Enterprise Assistant Connecting to RPS">
        <figcaption>Figure 5: Enterprise Assistant Connecting to RPS</figcaption>
    </figure>

10. After connecting, Enterprise Assistant will wait and listen for RPS to make requests to either add/revoke Computers or issue/revoke Certificates.