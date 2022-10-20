--8<-- "References/abbreviations.md"

On the managed device, a Remote Provisioning Client (RPC) communicates with the Remote Provision Server (RPS) in the process of activating or deactivating the device. In addition to activation and deactivation, the RPC provides informational and maintenance commands.

## List Commands
On the managed device, open a Terminal (Linux) or Powershell/Command Prompt **as Administrator** (Windows).

Run the RPC application on the command line with no arguments to see supported commands:

=== "Linux"
    ``` bash
    sudo ./rpc
    ```
=== "Windows"
    ```
    .\rpc.exe
    ```

| COMMAND     | DESCRIPTION                                                                           | EXAMPLE                                                       |
|-------------|---------------------------------------------------------------------------------------|---------------------------------------------------------------|
| activate    | Activate this device with a specified profile                                         | ./rpc activate -u wss://server/activate -profile profilename |
| deactivate  | Deactivate this device. You will be prompted for the AMT password.                    | ./rpc deactivate -u wss://server/activate                     |
| maintenance | Execute a maintenance task for the device. You will be prompted for the AMT password. | ./rpc maintenance syncclock -u wss://server/activate          |
| amtinfo     | Display AMT status and configuration                                                  | ./rpc amtinfo                                                 |
| version     | Display the current version of RPC and the RPC Protocol version                       | ./rpc version                                                 |

##List Command Options

Run the application with a command to see available options for the command:

=== "Linux"
    ``` bash
    sudo ./rpc [COMMAND]
    ```
=== "Windows"
    ```
    .\rpc [COMMAND]
    ```

### activate

Activate the device with a specified profile:
=== "Linux"
    ``` bash
    sudo ./rpc activate -u wss://server/activate -profile profilename
    ```
=== "Windows"
    ```xx
    .\rpc activate -u wss://server/activate -profile profilename
    ```

| OPTION             | DESCRIPTION                                                                              |
|--------------------|----------------------------------------------------------------------------------------- |
| -d string          | DNS suffix override                                                                      |
| -h string          | Hostname override                                                                        |
| -json              | JSON output                                                                              |
| -l string          | Log level (panic,fatal,error,warn,info,debug,trace) (default "info")                     |
| -lmsaddress string | LMS address (default "localhost"). Can be used to change location of LMS for debugging.  |
| -lmsport string    | LMS port (default "16992")                                                               |
| -n                 | Skip WebSocket server certificate verification                                           |
| -p string          | Proxy address and port                                                                   |
| -password          | AMT password                                                                             |
| -profile string    | Name of the profile to use                                                               |
| -u string          | WebSocket address of server to activate against                                          |
| -v                 | Verbose output                                                                           |

For more information, see [Build & Run RPC](../../GetStarted/buildRPC.md).

To learn how to use the RPC application to transition an already activated (provisioned) Intel vPro® Platform, see [Transition Activated Device](../../Reference/RPC/buildRPC_Manual.md#TransitionDevice).

### deactivate

Deactivate the device:

=== "Linux"
    ``` bash
    sudo ./rpc deactivate -u wss://server/activate
    ```
=== "Windows"
    ```
    .\rpc deactivate -u wss://server/activate
    ```

| OPTION             | DESCRIPTION                                                                              |
|--------------------|----------------------------------------------------------------------------------------- |
| -f                 | force deactivate even if device is not registered with a server                          |
| -json              | JSON output                                                                              |
| -l  string         | Log level (panic,fatal,error,warn,info,debug,trace) (default "info")                     |
| -lmsaddress string | LMS address (default "localhost"). Can be used to change location of LMS for debugging.  |
| -lmsport string    | LMS port (default "16992")                                                               |
| -n                 | Skip WebSocket server certificate verification                                           |
| -p string          | Proxy address and port                                                                   |
| -password string   | AMT password                                                                             |
| -u string          | WebSocket address of server to activate against                                          |
| -v                 | Verbose output                                                                           |

For more information, see [Build & Run RPC](../../GetStarted/buildRPC.md).

### maintenance

Execute a maintenance task for the managed device:

=== "Linux"
    ``` bash
    sudo ./rpc maintenance changepassword -u wss://server/activate
    sudo ./rpc maintenance syncclock -u wss://server/activate
    sudo ./rpc maintenance syncip -u wss://server/activate
    ```
=== "Windows"
    ```
    .\rpc maintenance changepassword -u wss://server/activate
    .\rpc maintenance syncclock -u wss://server/activate
    .\rpc maintenance syncip -u wss://server/activate
    ```

| SUBCOMMAND     | DESCRIPTION                                                                                                                           |
|----------------|---------------------------------------------------------------------------------------------------------------------------------------|
| changepassword | Change the AMT password. <br>A random password is generated by default. <br>Specify `-static newpassword` to set manually. AMT password is required |
| syncclock      | Sync the host OS clock to AMT. AMT password is required                                                                               |
| syncip         | Sync the static IP of host OS to AMT Network Settings. AMT password is required                                                       |

| OPTION             | DESCRIPTION                                                          |
|--------------------|----------------------------------------------------------------------|
| -json              | JSON output                                                          |
| -l string          | log level (panic,fatal,error,warn,info,debug,trace) (default "info") |
| -lmsaddress string | lms address (default "localhost")                                    |
| -lmsport string    | lms port (default "16992")                                           |
| -n                 | Skip WebSocket server certificate verification                       |
| -p string          | Proxy address and port                                               |
| -password string   | AMT password                                                         |
| -u string          | WebSocket address of server to activate against                      |
| -v                 | Verbose output                                                       |

### amtinfo

Display AMT status and configuration:

=== "Linux"
    ``` bash
    sudo ./rpc amtinfo [OPTIONS]
    ```
=== "Windows"
    ```
    .\rpc amtinfo [OPTIONS]
    ```

**Not passing `[OPTIONS]` will print all information.**

| AMT INFO          | OPTION    | DESCRIPTION                                                                                                                                                                           | 
|-------------------|-----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|                   | -json     | JSON Output                                                                                                                                                                           |
| Version           | -ver      | Intel AMT version.                                                                                                                                                                    | 
| Build Number      | -bld      | Intel AMT Build Number.                                                                                                                                                               |
| Certificate       | -cert     | Certificate Hashes                                                                                                                                                                    |
| SKU               | -sku      | Product SKU                                                                                                                                                                           | 
| UUID              | -uuid     | Unique Universal Identifier of the device. Used when creating device-specific MPS API calls as part of the REST API's URL path.                                                       | 
| Control Mode      | -mode     | Control Mode below indicates the managed device's state: a) pre-provisioning or deactivated (b) activated in **client control mode** (c) activated in **admin control mode**          | 
| DNS Suffix        | -dns      | DNS Suffix set according to PKI DNS Suffix in Intel MEBX or through DHCP Option 15. Requried for ACM activation.                                                                      |
| DNS Suffix (OS)   | -dns      |                                                                                                                                                                                       |
| Hostname (OS)     | -hostname | Device's hostname as set in the Operating System.                                                                                                                                     |
| RAS Network       | -ras      |                                                                                                                                                                                       |
| RAS Remote Status | -ras      | Unconnected or connected. State of connection to a management server.                                                                                                                 |
| RAS Trigger       | -ras      | User initiated or periodic. When activated, periodic signifies CIRA established. By default, CIRA sends a heartbeat to the server every 30 seconds to verify and maintain connection. |
| RAS MPS Hostname  | -ras      | IP Address or FQDN of the MPS server.                                                                                                                                                 |

**---Wired/Wireless Adapters---**

| WIRED/WIRELESS ADAPTER | OPTION | DESCRIPTION                                                              | 
|------------------------|--------|--------------------------------------------------------------------------|
| DHCP Enabled           | -lan   | True/False. Whether or not the network is using DHCP or Static IPs.      | 
| DHCP Mode              | -lan   |                                                                          | 
| Link Status            | -lan   | Up/Down. Shows whether or not this adapter is being used by Intel AMT.   | 
| IP Address             | -lan   | If using CIRA or the device is unactivated, this field will show 0.0.0.0 | 
| MAC Address            | -lan   | Device's MAC Address                                                     | 

For more information,
see [Wireless Activation](../../Tutorials/createWiFiConfig.md).

### version

Display the current version of RPC and the RPC Protocol version:

=== "Linux"
    ``` bash
    sudo ./rpc version
    ```
=== "Windows"
    ```
    .\rpc version
    ```
