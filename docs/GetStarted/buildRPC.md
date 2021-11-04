--8<-- "References/abbreviations.md"
Developed in Go* programming language, the Remote Provisioning Client (RPC) application runs on the managed device and communicates with the Remote Provisioning Server (RPS) microservice on the development system. The RPC and RPS configure and activate Intel® AMT on the managed device. Once properly configured, the remote managed device can call home to the Management Presence Server (MPS) by establishing a Client Initiated Remote Access (CIRA) connection with the MPS. See Figure 1.

!!! Warning "Beta Version Instructions Ahead"
        This version of the RPC application contains functional enhancements. See [Release Notes](../release-notes.md).

        However, it is a **Beta version release.** 
        
        If you are unable to complete the installation below or you simply require an older release of the RPC, see Open AMT Cloud Toolkit 2.0:

        * [Build & Run RPC (Legacy)](https://open-amt-cloud-toolkit.github.io/docs/2.0/GetStarted/buildRPC/)
        * [RPC Commands (Legacy)](https://open-amt-cloud-toolkit.github.io/docs/2.0/Reference/RPC/commandsRPC/)

!!! tip "Production Environment"
        In a production environment, RPC can be deployed with an in-band manageability agent to distribute it to the fleet of AMT devices. The in-band manageability agent can invoke RPC to run and activate the AMT devices.

[![RPC](../assets/images/RPC_Overview.png)](../assets/images/RPC_Overview.png)
**Figure 1: RPC Configuration** 

!!! note "Figure 1 Details"
    The RPC on a managed device communicates with the Intel® Management Engine Interface (Intel® MEI, previously known as HECI) Driver and the Remote Provisioning Server (RPS) interfaces. The Driver uses the Intel® MEI to talk to Intel® AMT. The RPC activates Intel® AMT with an AMT profile, which is associated with a CIRA configuration (Step 3). The profile, which also distinguishes between Client Control Mode (CCM) or Admin Control Mode (ACM), and configuration were created in [Create a CIRA Config](../GetStarted/createCIRAConfig.md) or [Create an AMT Profile](../GetStarted/createProfileACM.md). After running RPC with a profile, Intel® AMT will establish a CIRA connection with the MPS (Step 4) allowing MPS to manage the remote device and issue AMT commands (Step 5).

## Prerequisites
**Before installing and building the RPC, install:**

* Go* Programming Language
* tdm-gcc (On Windows* only)

    === "Linux"
         **To install prerequisites on Linux*:**

         1. See Go's [Download and Install](https://golang.org/doc/install).
         2. Choose and download a distribution appropriate for your managed device and operating system (e.g., tar.gz).
         3. Extract the archive in the location indicated in Go's installation instructions.
         4. Follow the remaining instructions. 

    === "Windows"
         **To install prerequisites on Windows:**

         1. See Go's [Download and Install](https://golang.org/doc/install).
         2. Choose and download a distribution appropriate for your managed device and operating system (e.g., msi).
         3. Run the downloaded file and follow prompts to install. 
         4. See [tdm-gcc](https://jmeubank.github.io/tdm-gcc/).
         5. Choose a version and download the .exe. 
         6. Run the downloaded file and follow prompts to install. For a new installation, choose **Create** and accept all default installation options.


**To verify Go and tdm-gcc installations:**

1. Open a Terminal or Command Prompt: 
   ``` bash
   go version
   ```
   For Windows only: 
   ``` bash
   gcc -v
   ```
2. Confirm the version numbers.

## Get the RPC

**To clone the repository:**

1. Open a Terminal or Command Prompt and navigate to a directory of your choice for development:
   ``` bash
   git clone --recursive https://github.com/open-amt-cloud-toolkit/rpc-go
   ```
  
2. Change to the cloned `rpc-go` directory:
   ``` bash
   cd rpc-go
   ```

## Build the RPC

**To build the executable:**

1. Open a Terminal (Linux) or Powershell/Command Prompt **as Administrator** (Windows):

    === "Linux"
        ``` bash
        sudo apt install build-essential
        ```
        ``` bash
        go build -o rpc ./cmd
        ```
    === "Docker (On Linux Host Only)"
        ``` bash
        placeholder for Mike
        ```
    === "Windows"
        ``` bash
        go build -o rpc.exe ./cmd
        ```
    !!! note
        The image created with the Docker instruction above is only suitable for Docker on a Linux host.


2. Confirm a successful build:

    === "Linux"
        ``` bash
        sudo rpc version
        ```
    === "Docker (On Linux Host Only)"
        ``` bash
        placeholder for Mike
        ```
    === "Windows"
        ``` bash
        rpc version
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
        sudo rpc activate -u wss://[Development-IP-Address]/activate --profile [profilename]
        ```
    === "Docker (On Linux Host Only)"
        ``` bash
        placeholder for Mike
        ```
    === "Windows"
        ```
        rpc activate -u wss://[Development-IP-Address]/activate --profile [profilename]
        ```

    !!! note "Note - RPC Arguments"
        Find out more information about the [flag and other arguments](../Reference/RPC/commandsRPC.md).


!!! success
    Example Output after Activating and Configuring a device into ACM:

    [![RPC Success](../assets/images/RPC_Success.png)](../assets/images/RPC_Success.png)


    !!! error "Troubleshooting"
        Run into an issue? Try these [troubleshooting steps](../Reference/troubleshooting.md).
         

## Next up
[Manage AMT Device](../GetStarted/manageDevice.md)
