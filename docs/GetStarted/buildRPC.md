--8<-- "References/abbreviations.md"
Developed in Go* programming language, the Remote Provisioning Client (RPC) application runs on the managed device and communicates with the Remote Provisioning Server (RPS) microservice on the development system. The RPC and RPS configure and activate Intel® AMT on the managed device. Once properly configured, the remote managed device can call home to the Management Presence Server (MPS) by establishing a Client Initiated Remote Access (CIRA) connection with the MPS. See Figure 1.

<div style="text-align:center;">
  <iframe width="600" height="337" src="https://www.youtube.com/embed/z9Ia317L0Kk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
  <figcaption><b>Getting Started Part 3</b>: Follow along to learn about how to build RPC, some of the information it can provide, and how to activate an AMT device. <b>Additional Resources: </b><a href="../../Reference/RPC/libraryRPC">RPC as a Library</a> and <a href="../../Reference/RPC/commandsRPC">RPC Commands and Flags</a></figcaption>
</div>

!!! Warning "Beta Version Instructions Ahead"
        This version of the RPC application contains functional enhancements. See [Release Notes](../release-notes.md).

        However, it is a **Beta version release.** 
        
        If you are unable to complete the installation below or you simply require an older release of the RPC, see Open AMT Cloud Toolkit 2.0:

        * [Build & Run RPC (Legacy)](https://open-amt-cloud-toolkit.github.io/docs/2.0/Reference/RPC/buildRPC_Manual/)
        * [RPC Commands (Legacy)](https://open-amt-cloud-toolkit.github.io/docs/2.0/Reference/RPC/commandsRPC/)


!!! important "Important - Production Environment"
        In a production environment, RPC can be deployed with an in-band manageability agent to distribute it to the fleet of AMT devices. The in-band manageability agent can invoke RPC to run and activate the AMT devices.


<figure class="figure-image">
<img width="800" height="450" src="..\..\assets\images\RPC_Overview.png" alt="Figure 1: RPC Configuration">
<figcaption>Figure 1: RPC configuration</figcaption>
</figure>

!!! note "Figure 1 Details"
    The RPC on a managed device communicates with the Intel® Management Engine Interface (Intel® MEI, previously known as HECI) Driver and the Remote Provisioning Server (RPS) interfaces. The Driver uses the Intel® MEI to talk to Intel® AMT. The RPC activates Intel® AMT with an AMT profile, which is associated with a CIRA configuration (Step 3). The profile, which also distinguishes between Client Control Mode (CCM) or Admin Control Mode (ACM), and configuration were created in [Create a CIRA Config](../GetStarted/createCIRAConfig.md) or [Create an AMT Profile](../GetStarted/createProfileACM.md). After running RPC with a profile, Intel® AMT will establish a CIRA connection with the MPS (Step 4) allowing MPS to manage the remote device and issue AMT commands (Step 5).

##  Build the RPC

!!! tip "Flexible Deployment - RPC as a Library"  
        The RPC can be built as an executable file or as a library, which offers the flexibility of deploying in your management agent or client. [Read more about building RPC as a library here](../../Reference/RPC/libraryRPC/).

**To build the executable:**

If you are building an executable on a development system, you will copy the executable to the managed device. 

1. Change to the `rpc-go` directory of the cloned `open-amt-cloud-toolkit` repository.
   
    ``` bash
    cd rpc-go
    ```
    ??? note "Haven't Cloned the `open-amt-cloud-toolkit` Repository?"

        1. Clone the whole toolkit repository:
            ``` bash
            git clone https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit --branch v{{ repoVersion.oamtct }} --recursive
            ```
        2. Only clone the `rpc-go` repository:
            ``` bash
            git clone https://github.com/open-amt-cloud-toolkit/rpc-go --branch v{{ repoVersion.rpc_go }}
            ```

2. Open a Terminal (Linux) or Powershell/Command Prompt **as Administrator** (Windows):

    === "Linux"
        ``` bash
        go build -o rpc ./cmd/main.go
        ```
    === "Windows"
        ``` bash
        go build -o rpc.exe ./cmd/main.go
        ```
    === "Docker (On Linux Host Only)"
        ``` bash
        docker build -f "Dockerfile" -t rpc-go:latest .
        ```
        !!! note
            The image created with the Docker instruction above is only suitable for Docker on a Linux host. 

3. Confirm a successful build:

    === "Linux"
        ``` bash
        sudo ./rpc version
        ```
    === "Windows"
        ``` bash
        .\rpc version
        ```        
    === "Docker (On Linux Host Only)"
        ``` bash
        sudo docker run --device=/dev/mei0 rpc-go:latest version
        ```

## Run RPC to Activate and Connect the AMT Device

The toolkit provides a reference implementation called the Sample Web UI to manage the device. After running device activation instructions below, your device will be listed on the **Devices** tab in the Sample Web UI. 

**To run the application and connect the managed device:**

1. After building the RPC, copy the executable to the managed device.
   
2. On the managed device, open a Terminal (Linux) or Powershell/Command Prompt **as Administrator** (Windows).

3. Navigate to the directory containing the RPC application. 

4. Running RPC with the **activate** command configures or *provisions* Intel® AMT. It will take 1-2 minutes to finish provisioning the device. 
     In the instruction below:

    - Replace **[Development-IP-Address]** with the development system's IP address, where the MPS and RPS servers are running.
    - Replace **[profile-name]** with your created profile in the Sample Web UI. The RPC application command line parameters are case-sensitive.

    === "Linux"
        ``` bash
        sudo ./rpc activate -u wss://[Development-IP-Address]/activate -n -profile [profilename]
        ```
    === "Windows"
        ```
        .\rpc activate -u wss://[Development-IP-Address]/activate -n -profile [profilename]
        ```        
    === "Docker (On Linux Host Only)"
        ``` bash
        sudo docker run --device=/dev/mei0 rpc-go:latest activate -u wss://[Development-IP-Address]/activate -n -profile [profilename]
        ```

    !!! note "Note - RPC Arguments"
        See more about the [flag and other arguments](../Reference/RPC/commandsRPC.md).

    !!! note "Note - Transition Activated Device"
        To learn how to use the RPC application to transition an already activated (provisioned) Intel vPro® Platform device, see [Transition Activated Device](../Reference/RPC/buildRPC_Manual.md#transition-activated-device).


    !!! success
        Example Output after Activating and Configuring a device into ACM:
        <figure class="figure-image">
        <img src="..\..\assets\images\RPC_Success.png" alt="Figure 2: Example output after configuration">
        <figcaption>Figure 2: Example output after configuration</figcaption>
        </figure>


    !!! error "Troubleshooting"
        Run into an issue? Try these [troubleshooting steps](../Reference/troubleshooting.md).
         

## Next up
**[Manage AMT Device](../GetStarted/manageDevice.md)**
