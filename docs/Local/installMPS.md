The Open Active Management Technology (AMT) Cloud Toolkit repository includes: 

- [Management Presence Server (MPS)](../Glossary.md#m)
- [Remote Provisioning Server (RPS)](../Glossary.md#r)
- [UI Toolkit](../Glossary.md#u)
- [Remote Provisioning Client (RPC)](../Glossary.md#r)

Find details about architectural details, security issues, and more in [Microservices](../Microservices/MPS/overview.md).

## Network, Hardware, and Software Prerequisites

**Before installing the toolkit, prepare the environment:**

1\. Configure a network that includes:

-  A development system running Windows® 10 or Ubuntu* 18.04 or newer 
-  One or more [Intel vPro®](https://www.intel.com/content/www/us/en/architecture-and-technology/vpro/what-is-vpro.html) device(s) to manage

!!! tip
    A **flash drive** or equivalent means of transfer is necessary to copy the RPC to the managed device.

!!! Info
    Both development systems and managed devices must use a **wired (i.e., cable) connection** on the same network.

2\. Install the prerequisite software on the development system:

| Prerequisite Software | Purpose |
| :----------- |  :--|
| [Chrome* Browser](https://www.google.com/chrome) | Runs the WebUI console for configuring profiles and connecting devices | 
| [git](https://git-scm.com/downloads)| Downloads the OpenAMT Cloud Toolkit repository | 
| [Node.js* LTS 12.x.x or newer](https://nodejs.org/) | Installs the software | 

## Download and Configure Software

**To download the Open AMT Cloud Toolkit repository on the development system:**

1\. Open a Command Prompt or Terminal and navigate to a directory of your choice for development. 

2\. Clone the repository.
``` bash
git clone --recursive https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit
```
3\. Navigate to the `mps` directory:
``` bash
cd open-amt-cloud-toolkit/mps
```

**Run the scripts to modify the MPS configuration file and the WebUI file:**

4\. Run the MPS configuration script.
``` bash
mps-configure -c [your dev system IP address] -a [false]
```
This script makes the following changes to the configuration in the `.mpsrc` file:

| Field       |  Change to    | Description |
| :----------- | :-------------- | :- |
| `use_allowlist` | false |A value of false disables the allowlist functionality. For information about allowlist, see the allowlist [tutorial](../Tutorials/allowlist.md) |
| `common_name` | Development system's IP address. <br> **Note:** For this guide, you **cannot** use localhost because the managed device would be unable to reach the MPS and RPS servers. | For this guide, the address will be used in a self-signed certificate. It may be an IP address or FQDN in real world deployment.|

5\. Navigate to the `src` directory in `.\mps\webui\src\`.
``` bash
cd webui/src
```

6\. Run the app configuration file which modifies the `app.config.js` file with 
``` bash
app-configure [RPS ip address] [MPS ip address]
```

## Install
1\. Navigate back to the `./open-amt-cloud-toolkit` base installation directory.
2\. Run the install commands to install all required dependencies.
    ``` bash
    npm install
    ```
!!! Info
    This installs both MPS and RPS. Find information about them [here](../Microservices/MPS/overview.md). 

## Start the MPS and RPS
Start the MPS and RPS in two separate command line terminals. 

**To start the MPS:**

1\. Open a new Command Prompt or Terminal and navigate to a directory to the ```mps``` directory. 
``` bash
npm run dev
```
2\. Figure 1 demonstrates successful deployment. The web server runs on port 3000 by default, and the MPS Server listens on port 4433. It will take approximately 2-3 minutes to start.

!!! Success
    The development system's IP Address will be used to connect to the web server.

[![mps](../assets/images/MPS_npmrundev.png)](../assets/images/MPS_npmrundev.png)

**Figure 1: MPS reports successful deployment.**

!!! Note
    Because the `generateCertificates` field is set to true in the `.mpsrc` file, certificates will be generated and stored in the `../mps/private` directory.

**To start the RPS:**

3\. Open a new Command Prompt or Terminal and navigate to a directory to the ```rps``` directory. 

4\. Run the install command to install all required dependencies. 

    ``` bash
    npm install
    ```

5\. Then, start the server. By default, the RPS web port is 8080.

    ``` bash
    npm run dev
    ```

    !!! note
        Warning messages are okay and expected for optional dependencies.

    Example Output:

    
[![RPS Output](../assets/images/RPS_npmrundev.png)](../assets/images/RPS_npmrundev.png)

**Figure 2: RPS reports successful deployment.**

## Next up
[**Login to RPS**](../General/loginToRPS.md)