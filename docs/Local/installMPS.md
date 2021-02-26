

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
    | [Chrome* Browser](https://www.google.com/chrome) | View the WebUI console for configuring profiles and connecting devices | 
    | [git](https://git-scm.com/downloads)| Downloads the OpenAMT Cloud Toolkit repository | 
    | [Node.js* LTS 12.x.x or newer](https://nodejs.org/) | Installs and runs the software | 

## Download and Configure Software

**To download the Open AMT Cloud Toolkit repository on the development system:**

1. Open a Terminal (Linux) or Powershell command prompt (Windows) and navigate to a directory of your choice for development. 

2. Clone the repository.
    ``` bash
    git clone --recursive --branch v1.1.0 https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit
    ```

3. Run the following script to build and install the services. 

    === "Linux"
        ``` bash
        make build
        ```

    === "Windows (Powershell)"
        ``` powershell
        ./build.ps1
        ```

4. Provide the IP Address of your development system and press Enter. 

    !!! info
        The script will update the `./mps/.mpsrc` file and the `./sample-web-ui/src/app.config.js` file with the IP address you enter. It will also run `npm install` for each service to install the necessary dependencies. For more information on all available configuration options for MPS [click here](../Microservices/MPS/configuration.md) and for RPS [click here](../Microservices/RPS/configuration.md).

    !!! note
        Warning messages are okay and expected for optional dependencies.

    All dependencies for MPS, RPS, and the Web UI have now been installed and configured. To learn more about each component and their role click [here](../Microservices/overview.md).

## Start the MPS, RPS, and Sample Web UI

Start the MPS, RPS, and Sample Web UI in three separate command line terminals. 

**To start the MPS:**

1. Open a new Terminal or Command Prompt and navigate to the `mps` directory inside the `open-amt-cloud-toolkit` directory. 

2. Start the MPS server. It may take approximately 2-3 minutes to start.

    === "Linux"
        ``` bash
        npm run devx
        ```

    === "Windows (Powershell)"
        ``` powershell
        npm run dev
        ```

    !!! Success
        The development system's IP Address will be used to connect to the web server. By default, the web server (api) runs on port 3000 and the MPS Server listens on port 4433.

        [![mps](../assets/images/MPS_npmrundev.png)](../assets/images/MPS_npmrundev.png)

        **Figure 1: MPS reports successful deployment.**

    <!-- !!! Note
        Because the `generateCertificates` field is set to true in the `.mpsrc` file, certificates will be generated and stored in the `../mps/private` directory. -->

<br>

**To start the RPS:**

1. Open a new Terminal or Command Prompt and navigate to the `rps` directory inside the `open-amt-cloud-toolkit` directory. 

2. Start the RPS server.

    === "Linux"
        ``` bash
        npm run devx
        ```

    === "Windows (Powershell)"
        ``` powershell
        npm run dev
        ```


    !!! Success
        By default, the RPS web port is 8080 and the RPS Server listens on port 8081.

        [![RPS Output](../assets/images/RPS_npmrundev.png)](../assets/images/RPS_npmrundev.png)

        **Figure 2: RPS reports successful deployment.**

<br>

**To start the Sample Web UI:**

1. Open a new Terminal or Command Prompt and navigate to the `sample-web-ui` directory inside the `open-amt-cloud-toolkit` directory.

2. Start the server.

    ``` bash
    npm start
    ```

3. If prompted to use another port, enter 'y' and note the port that is chosen. Typically, the port defaults to 3001. This is where the UI will be running.

    !!! Success
        Because MPS runs on port 3000, the Sample Web UI may prompt to use port 3001 instead.

        [![Sample UI Output](../assets/images/SampleUI_npmstart.png)](../assets/images/SampleUI_npmstart.png)

        **Figure 3: Sample UI reports successful deployment.**


## Next up

[**Login to RPS**](../General/loginToRPS.md)

