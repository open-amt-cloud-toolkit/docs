--8<-- "References/abbreviations.md"

On the managed device, a Remote Provisioning Client (RPC) communicates with the Remote Provision Server (RPS) in the process of activating or deactivating the device. In addition to activation and deactivation, the RPC provides informational and maintenance commands.

##List Commands
On the managed device, open a Terminal (Linux) or Powershell/Command Prompt **as Administrator** (Windows).

Run the RPC application on the command line with no arguments to see supported commands:

=== "Linux"
    ``` bash
    sudo ./rpc 
    ```
=== "Windows"
    ```
    rpc
    ```

| COMMAND&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | DESCRIPTION &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | EXAMPLE |
| -------------------------- | ---------------------- | ----------- |
| activate | Activate this device with a specified profile | ./rpc activate -u wss://server/activate --profile profilename  |
| deactivate | Deactivate this device. You will be prompted for the AMT password.  | ./rpc deactivate -u wss://server/activate |
| maintenance | Synchronize the managed device's AMT clock with operating system time | ./rpc maintenance -c -u wss://server/activate -n |
| amtinfo | Display AMT status and configuration | ./rpc amtinfo |
| version | Display the current version of RPC and the RPC Protocol version | ./rpc version |

##List Command Options

Run the application with a command to see available options for the command:

=== "Linux"
    ``` bash
    sudo ./rpc [COMMANDS][OPTIONS]
    ```
=== "Windows"
    ```
    rpc [COMMANDS][OPTIONS]
    ```

### activate

Activate this device with a specified profile: 
=== "Linux"
    ``` bash
    sudo ./rpc activate -u wss://server/activate --profile profilename
    ```
=== "Windows"
    ```
    rpc activate -u wss://server/activate --profile profilename
    ```

| OPTION&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | DESCRIPTION |
| -------------------------- | ---------------------- | 
| -d string | DNS suffix override | 
| -h string | Hostname override | 
| -n | Skip WebSocket server certificate verification |
| -p string | Proxy address and port |
| --profile string | name of the profile to use |
| -u string | WebSocket address of server to activate against |
| -v string | Verbose output |

For more information, see [Build & Run RPC](../../GetStarted/buildRPC.md).

### deactivate

Deactivate this device:

=== "Linux"
    ``` bash
    sudo ./rpc deactivate -u wss://server/activate
    ```
=== "Windows"
    ```
    rpc deactivate -u wss://server/activate
    ```

| OPTION&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | DESCRIPTION |
| -------------------------- | ---------------------- | 
| -d | DNS suffix override | 
| -n | Skip WebSocket server certificate verification |
| -p string | Proxy address and port |
| -password string | AMT password |
| -u string | WebSocket address of server to activate against |
| -v string | Verbose output |

For more information, see [Build & Run RPC](../../GetStarted/buildRPC.md).

### maintenance

Synchronize the managed device's AMT clock with operating system time: 

=== "Linux"
    ``` bash
    sudo ./rpc maintenance -u wss://server/activate
    ```
=== "Windows"
    ```
    rpc maintenance -u wss://server/activate
    ```

| OPTION&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | DESCRIPTION |
| -------------------------- | ---------------------- | 
| -c | Synchronize the AMT clock with the operating system time | 
| -n | Skip WebSocket server certificate verification |
| -p string | Proxy address and port |
| -password string | AMT password |
| -u string | WebSocket address of server to activate against |
| -v string | Verbose output |

### amtinfo

 Display AMT status and configuration

=== "Linux"
    ``` bash
    sudo ./rpc amtinfo
    ```
=== "Windows"
    ```
    rpc amtinfo
    ```

| AMT INFO &emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | DESCRIPTION &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | 
| -------------------------- | ---------------------- |
| Version | Intel AMT version.  | 
| Build Number | Intel AMT Build Number. | 
| SKU | | 
| UUID |  | 
| Control Mode |  Control Mode below indicates the managed device's state: a) pre-provisioning or deactivated (b) activated in **client control mode** (c) activated in **admin control mode** | 
|DNS Suffix | |
|DNS Suffix (OS)| |
|Hostname (OS) | |
|RAS Network | |
|RAS Remote Status | |
|RAS Trigger| |
|RAS MPS Hostname | |

**---Wired Adapter---**

| WIRED ADAPTER &emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | DESCRIPTION &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | 
| -------------------------- | ---------------------- |
| DHCP Enabled |   | 
| DHCP Mode | | 
| Link Status | | 
| IP Address |  | 
| MAC Address|   | 

**---Wireless Adapter---**

| WIRED ADAPTER &emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | DESCRIPTION &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | 
| -------------------------- | ---------------------- |
| DHCP Enabled | | 
| DHCP Mode |  | 
| Link Status | | 
| IP Address |  | 
| MAC Address|   | 

For more information, see [Wireless Activation](../../Tutorials/createWiFiConfig.md).

### version

Display the current version of RPC and the RPC Protocol version:

=== "Linux"
    ``` bash
    sudo ./rpc version
    ```
=== "Windows"
    ```
    rpc version
    ```
