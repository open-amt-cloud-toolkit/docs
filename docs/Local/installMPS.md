

The Open Active Management Technology (AMT) Cloud Toolkit repository includes: 

- [Management Presence Server (MPS)](../Glossary.md#m)
- [Remote Provisioning Server (RPS)](../Glossary.md#r)
- [UI Toolkit](../Glossary.md#u)
- [Remote Provisioning Client (RPC)](../Glossary.md#r)

Find details about architectural details, security issues, and more in [Microservices](../Microservices/overview.md).

## Network, Hardware, and Software Prerequisites

**Before installing the toolkit, prepare the environment:**

1. Configure a network that includes:

    -  A development system running Windows® 10 or Ubuntu* 18.04 or newer 
    -  One or more [Intel vPro®](https://www.intel.com/content/www/us/en/architecture-and-technology/vpro/what-is-vpro.html) device(s) to manage

    !!! tip
        A **flash drive** or equivalent means of transfer is necessary to copy the RPC to the managed device.

    !!! Info
        Both development systems and managed devices must use a **wired (i.e., cable) connection** on the same network.

2. Install the prerequisite software on the development system:

    | Prerequisite Software | Purpose |
    | :----------- |  :--|
    | [Chrome* Browser](https://www.google.com/chrome) | Runs the WebUI console for configuring profiles and connecting devices | 
    | [git](https://git-scm.com/downloads)| Downloads the OpenAMT Cloud Toolkit repository | 
    | [Node.js* LTS 12.x.x or newer](https://nodejs.org/) | Installs the software | 

## Download and Configure Software

**To download the Open AMT Cloud Toolkit repository on the development system:**

1. Open a Powershell command prompt (Windows) or Terminal (Linux) and navigate to a directory of your choice for development. 

2. Clone the repository.
    ``` bash
    git clone --recursive https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit
    ```

3. Build and Install the services. Run the following script which will update the `./mps/.mpsrc` file and the `./sample-web-ui/src/app.config.js` file with the IP address you enter. It will also run `npm install` for each service to install necessary dependencies. For more information on all available configuration options for MPS see [click here](../Microservices/MPS/configuration.md) and for RPS [click here](../Microservices/RPS/configuration.md).

    === "Windows (Powershell)"
        ``` powershell
        ./build.ps1
        ```
    === "Linux"
        ``` bash
        make build
        ```


All dependencies for MPS, RPS, and the Web UI have now been installed and configured. To learn more about each component and their role click [here](../Microservices/overview.md). 
## Start the MPS and RPS
Start the MPS and RPS in two separate command line terminals. 

**To start the MPS:**

1. Open a new Command Prompt or Terminal and navigate to a directory to the `mps` directory. 
    ``` bash
    npm run dev
    ```
2. Figure 1 demonstrates successful deployment. The web server (api) runs on port 3000 by default, and the MPS Server listens on port 4433. It will take approximately 2-3 minutes to start.

    !!! Success
        The development system's IP Address will be used to connect to the web server.

    [![mps](../assets/images/MPS_npmrundev.png)](../assets/images/MPS_npmrundev.png)

    **Figure 1: MPS reports successful deployment.**

    !!! Note
        Because the `generateCertificates` field is set to true in the `.mpsrc` file, certificates will be generated and stored in the `../mps/private` directory.

**To start the RPS:**

1. Open a new Command Prompt or Terminal and navigate to a directory to the `rps` directory. 

2. Then, start the server. By default, the RPS web port is 8080.

    ``` bash
    npm run dev
    ```

    !!! note
        Warning messages are okay and expected for optional dependencies.

    Example Output:


    
[![RPS Output](../assets/images/RPS_npmrundev.png)](../assets/images/RPS_npmrundev.png)

**Figure 2: RPS reports successful deployment.**

**To start the Sample Web UI:**

1. Open a new Command Prompt or Terminal and navigate to a directory to the `sample-web-ui` directory. 

2. Then, start the server. You may be prompted to use another port if one is already in use. Enter 'y' if prompted and note the port that is chosen, this is where the UI will be running.

    ``` bash
    npm start
    ```

    !!! note
        Warning messages are okay and expected for optional dependencies.


## Next up

[**Login to RPS**](../General/loginToRPS.md)

