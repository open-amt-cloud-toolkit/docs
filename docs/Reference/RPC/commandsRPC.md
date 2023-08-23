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

| COMMAND                     | DESCRIPTION                                                                                 | EXAMPLE                                                      |
|-----------------------------|---------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| [activate](#activate)       | Activate this device with a specified profile.                                              | ./rpc activate -u wss://server/activate -profile profilename |
| [deactivate](#deactivate)   | Deactivate this device. You will be prompted for the AMT password.                          | ./rpc deactivate -u wss://server/deactivate                  |
| [maintenance](#maintenance) | Execute a maintenance task for the device. You will be prompted for the AMT password.       | ./rpc maintenance syncclock -u wss://server/maintenance      |
| [configure](#configure)     | Local configuration of a feature on this device. You will be prompted for the AMT password. | ./rpc configure addwifisettings ...                          |
| [amtinfo](#amtinfo)         | Display AMT status and configuration.                                                       | ./rpc amtinfo                                                |
| [version](#version)         | Display the current version of RPC and the RPC Protocol version.                            | ./rpc version                                                |

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

#### Activate and Configure the device using RPS:

Activate the device with a specified profile:

=== "Linux"
    ``` bash
    sudo ./rpc activate -u wss://server/activate -profile profilename
    ```
=== "Windows"
    ```
    .\rpc activate -u wss://server/activate -profile profilename
    ```

#### Activate the device locally:

Currently, this capability is only supported for activating unprovisioned (e.g. pre-provisioning state) devices. This command **only** activates AMT. It does not do profile-based configuration.

=== "Linux"
    ``` bash
    sudo ./rpc activate -local -password NewAMTPassword
    ```
=== "Windows"
    ```
    .\rpc activate -local -password NewAMTPassword
    ```

<br>

#### `activate` Options

| OPTION             | DESCRIPTION                                                                                                                     |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------|
| -d string          | DNS suffix override                                                                                                             |
| -h string          | Hostname override                                                                                                               |
| -json              | JSON output                                                                                                                     |
| -l string          | Log level (panic,fatal,error,warn,info,debug,trace) (default "info")                                                            |
| -lmsaddress string | LMS address (default "localhost"). Can be used to change location of LMS for debugging.                                         |
| -lmsport string    | LMS port (default "16992")                                                                                                      |
| -local             | Execute command to AMT directly without cloud interaction.                              |
| -n                 | Skip WebSocket server certificate verification                                                                                  |
| -name              | Friendly name to associate with this device                                                                                     |
| -p string          | Proxy address and port                                                                                                          |
| -password          | AMT password                                                                                                                    |
| -profile string    | Name of the profile to use                                                                                                      |
| -t duration        | Time to wait until AMT is ready (e.g. `2m` or `30s`), the default is `2m0s`                                                     |
| -tenant string     | TenantID of profile. If not provided, then assumed empty string (i.e. [no Multitenancy enabled](../middlewareExtensibility.md)) |
| -token string      | JWT Token for Authorization                                                                                                     |
| -u string          | WebSocket address of server to activate against                                                                                 |
| -v                 | Verbose output                                                                                                                  |

For more information, see [Build & Run RPC](../../GetStarted/buildRPC.md).

To learn how to use the RPC application to transition an already activated (provisioned) Intel vPro® Platform, see [Transition Activated Device](../../Reference/RPC/buildRPC_Manual.md#TransitionDevice).

### deactivate

!!! warning "Warning - Future Deprecation: Changing of Kong Routes"
    **We have now enabled the `/deactivate` Kong route.** The previous `/activate` route will still function for deactivate commands to avoid breaking changes. However, the `/activate` route's use with deactivate will be deprecated in the future and it is recommended to utilize the new, `/deactivate` route for new development.

#### Deactivate the device using RPS:

=== "Linux"
    ``` bash
    sudo ./rpc deactivate -u wss://server/deactivate
    ```
=== "Windows"
    ```
    .\rpc deactivate -u wss://server/deactivate
    ```

#### Deactivate the device locally:

=== "Linux"
    ``` bash
    sudo ./rpc deactivate -local
    ```
=== "Windows"
    ```
    .\rpc deactivate -local
    ```

<br>

#### `deactivate` Options

| OPTION             | DESCRIPTION                                                                             |
|--------------------|-----------------------------------------------------------------------------------------|
| -f                 | Force deactivate even if device is not registered with the RPS server                   |
| -json              | JSON output                                                                             |
| -l string          | Log level (panic,fatal,error,warn,info,debug,trace) (default "info")                    |
| -lmsaddress string | LMS address (default "localhost"). Can be used to change location of LMS for debugging. |
| -lmsport string    | LMS port (default "16992")                                                              |
| -local             | Execute command to AMT directly without cloud interaction.                              |
| -n                 | Skip WebSocket server certificate verification                                          |
| -p string          | Proxy address and port                                                                  |
| -password string   | AMT password                                                                            |
| -t duration        | Time to wait until AMT is ready (e.g. `2m` or `30s`), the default is `2m0s`             |
| -token string      | JWT Token for Authorization                                                             |
| -u string          | WebSocket address of server to activate against                                         |
| -v                 | Verbose output                                                                          |

For more information, see [Build & Run RPC](../../GetStarted/buildRPC.md).

### maintenance

!!! warning "Warning - Future Deprecation: Changing of Kong Routes"
    **We have now enabled the `/maintenance` Kong route.** The previous `/activate` route will still function for maintenance commands to avoid breaking changes. However, the `/activate` route's use with maintenance will be deprecated in the future and it is recommended to utilize the new, `/maintenance` route for new development.

Execute a maintenance command for the managed device:

| SUBCOMMAND                            | DESCRIPTION                                                                                           |
|---------------------------------------|-------------------------------------------------------------------------------------------------------|
| [changepassword](#changepassword)     | Change the AMT password. <br> A random password is generated by default if `-static` is not provided. |
| [syncclock](#syncclock)               | Sync the host OS clock to AMT.                                                                        |
| [synchostname](#synchostname)         | Sync the OS hostname to AMT Network Settings.                                                         |
| [syncip](#syncip)                     | Sync the static IP of host OS to AMT Network Settings.                                                |

<br>

#### Common `maintenance` Options

| OPTION             | DESCRIPTION                                                                                                                      |
|--------------------|--------------------------------------------------------------------------------------------------------------------------------- |
| -f                 | Force maintenance commands even if device is not registered with a server                                                        |
| -json              | JSON output                                                                                                                      |
| -l string          | Log level (panic,fatal,error,warn,info,debug,trace) (default "info")                                                             |
| -lmsaddress string | LMS address (default "localhost"). Can be used to change location of LMS for debugging.                                          |
| -lmsport string    | LMS port (default "16992")                                                                                                       |
| -n                 | Skip WebSocket server certificate verification                                                                                   |
| -p string          | Proxy address and port                                                                                                           |
| -password string   | AMT password                                                                                                                     |
| -t duration        | Time to wait until AMT is ready (e.g. `2m` or `30s`), the default is `2m0s`                                                      |
| -tenant string     | TenantID of profile. If not provided, then assumed empty string (i.e. [no Multitenancy enabled](../middlewareExtensibility.md))  |
| -token string      | JWT Token for Authorization                                                                                                      |
| -u string          | WebSocket address of server to activate against                                                                                  |
| -v                 | Verbose output                                                                                                                   |

<br>

#### changepassword

Change the AMT password. A random password is generated by default if `static` option is not passed.

=== "Linux"
    ``` bash
    sudo ./rpc maintenance changepassword -u wss://server/maintenance
    ```
=== "Windows"
    ```
    .\rpc maintenance changepassword -u wss://server/maintenance
    ```

| OPTION  | DESCRIPTION             |
|---------|-------------------------|
| -static | New password to be used |

<br>

#### syncclock

Syncs the host OS clock to AMT.

=== "Linux"
    ``` bash
    sudo ./rpc maintenance syncclock -u wss://server/maintenance
    ```
=== "Windows"
    ```
    .\rpc maintenance syncclock -u wss://server/maintenance
    ```

<br>

#### synchostname

Sync the OS hostname to AMT Network Settings.

=== "Linux"
    ``` bash
    sudo ./rpc maintenance synchostname -u wss://server/maintenance
    ```
=== "Windows"
    ```
    .\rpc maintenance synchostname -u wss://server/maintenance
    ```

<br>

#### syncip

Sync the static IP of host OS to AMT Network Settings.

=== "Linux"
    ```
    sudo ./rpc maintenance syncip -staticip 192.168.1.7 -netmask 255.255.255.0 -gateway 192.168.1.1 -primarydns 8.8.8.8 -secondarydns 4.4.4.4 -u wss://server/maintenance
    ```
=== "Windows"
    ```
    .\rpc maintenance syncip -staticip 192.168.1.7 -netmask 255.255.255.0 -gateway 192.168.1.1 -primarydns 8.8.8.8 -secondarydns 4.4.4.4 -u wss://server/maintenance
    ```

| OPTION        | DESCRIPTION                                                                                                         |
|---------------|---------------------------------------------------------------------------------------------------------------------|
| -staticip     | IP address to be assigned to AMT<br>If not specified, the IP address of the active OS newtork interface is used     |
| -netmask      | Network mask to be assigned to AMT<br>If not specified, the network mask of the active OS newtork interface is used |
| -gateway      | Gateway address to be assigned to AMT                                                                               |
| -primarydns   | Primary DNS address to be assigned to AMT                                                                           |
| -secondarydns | Secondary DNS address to be assigned to AMT                                                                         |

<br>

### configure

Execute a configuration command for the managed device:

| SUBCOMMAND                            | DESCRIPTION                                                                                           |
|---------------------------------------|-------------------------------------------------------------------------------------------------------|
| [addwifisettings](#addwifisettings)   | Configure wireless 802.1x locally with RPC (no communication with RPS and EA)                         |

<br>

#### Common `configuration` Options

| OPTION             | DESCRIPTION                                                                                                                      |
|--------------------|--------------------------------------------------------------------------------------------------------------------------------- |
| -json              | JSON output                                                                                                                      |
| -l string          | Log level (panic,fatal,error,warn,info,debug,trace) (default "info")                                                             |
| -password string   | AMT password                                                                                                                     |
| -v                 | Verbose output                                                                                                                   |

<br>

#### addwifisettings

Configure wireless 802.1x settings of an existing, activated AMT device by passing credentials and certificates directly to AMT rather than through RPS/EA/RPC. More information on configuring AMT to use 802.1x can be found in [802.1x Configuration](../EA/ieee8021xconfig.md).

On failure, the `addwifisettings` maintenance command will rollback any certificates added before the error occurred.

##### via Config file

The Config file can be formatted as either YAML or JSON. This example shows YAML but a JSON template is provided as well.

1. Create a new file called `config.yaml`. Copy and paste the corresponding template below.

    These templates show how to create a simple Wireless profile called **exampleWifiWPA2** and a Wireless profile utilizing 802.1x called **exampleWifi8021x**.

    === "YAML"
        ```yaml title="config.yaml"
        wifiConfigs:
        - profileName: 'exampleWifiWPA2' # friendly name (ex. Profile name)
            ssid: 'exampleSSID'
            priority: 1
            authenticationMethod: 6
            encryptionMethod: 4
            pskPassphrase: ''
        - profileName: 'exampleWifi8021x' # friendly name (ex. Profile name)
            ssid: 'ssid'
            priority: 2
            authenticationMethod: 7
            encryptionMethod: 4
            pskPassphrase: ''
            ieee8021xProfileName: 'exampleIeee8021xEAP-TLS'
        ieee8021xConfigs:
        - profileName: 'exampleIeee8021xEAP-TLS'
            username: "exampleUserName"
            password: "" # 8021x password if authenticationProtocol is PEAPv0/EAP-MSCHAPv2(2)
            authenticationProtocol: 0 #8021x profile (ex. EAP-TLS(0))
            clientCert: ''
            caCert: ''
            privateKey: ''
        ```

    === "JSON"
        ```json title="config.json"
        {
          "wifiConfigs": [
            {
              "profileName": "exampleWifiWPA2",
              "ssid": "exampleSSID",
              "priority": 1,
              "authenticationMethod": 6,
              "encryptionMethod": 4,
              "pskPassphrase": ""
            },
            {
              "profileName": "exampleWifi8021x",
              "ssid": "ssid",
              "priority": 2,
              "authenticationMethod": 7,
              "encryptionMethod": 4,
              "pskPassphrase": "",
              "ieee8021xProfileName": "exampleIeee8021xEAP-TLS"
            }
          ],
          "ieee8021xConfigs": [
            {
              "profileName": "exampleIeee8021xEAP-TLS",
              "username": "exampleUserName",
              "password": "",
              "authenticationProtocol": 0,
              "clientCert": "",
              "caCert": "",
              "privateKey": ""
            }
          ]
        }
        ```

2. Fill in fields with desired options and secrets.  If the secrets are **not** provided (e.g. field is an empty string or not given), the secrets will be prompted for as user input in the command line.

    Alternatively, secrets can be stored and referenced in a separate file. See [with Secrets file](#with-secrets-file) for more information.

3. Provide the `config.yaml` file using the `-configFile` flag. 

    === "Linux"
        ``` bash
        sudo ./rpc configure addwifisettings -configFile config.yaml
        ```
    === "Windows"
        ```
        .\rpc configure addwifisettings -configFile config.yaml
        ```

###### with Secrets file

If a secrets file is included with the configuration file, those secrets will be used in the matching `profileName` configuration.

1. Create a new file called `secrets.yaml`. Copy and paste the template below.

    === "YAML"
        ```yaml title="secrets.yaml"
        secrets:
        - profileName: 'exampleWifiWPA2'
          pskPassphrase: ''
        - profileName: 'exampleIeee8021xEAP-TLS'
          privateKey: ''
        - profileName: 'ieee8021xPEAPv0'
          password: ''
        ```
    === "JSON"
        ```json title="secrets.json"
        {
          "secrets": [
            {
              "profileName": "exampleWifiWPA2",
              "pskPassphrase": ""
            },
            {
              "profileName": "exampleIeee8021xEAP-TLS",
              "privateKey": ""
            },
            {
              "profileName": "ieee8021xPEAPv0",
              "password": ""
            }
          ]
        }
        ```

2. Fill in fields with the secrets. The `profileName` given in the secrets file must match the corresponding Wireless or 802.1x configuration `profileName`.
   
3. Provide the `secrets.yaml` file using the `-secretFile` flag. 

    === "Linux"
        ``` bash
        sudo ./rpc configure addwifisettings -configFile config.yaml -secretFile secrets.yaml
        ```
    === "Windows"
        ```
        .\rpc configure addwifisettings -configFile config.yaml -secretFile secrets.yaml
        ```


##### via CLI

Alternatively, provide all options directly in the command line. The user will be prompted for missing secrets (i.e. password, privateKey, pskPassphrase, ieee8021xPassword), if not provided.

This can be done two ways:

- Pass individual options
- Pass all data in a single JSON string using `-configJson` option

!!! warning "Warning - Use Case and Security"
    The CLI option is intended for use as part of an integration of RPC as a shared library. The passing of secrets directly via command line is highly insecure and **NOT** recommended.

###### Pass by Individual Options

=== "Linux"
    ``` bash
    sudo ./rpc configure addwifisettings -profileName profileName -authenticationMethod 7 -encryptionMethod 4 -ssid "networkSSID" -username "username" -authenticationProtocol 0 -priority 1 -clientCert {CLIENT_CERT} -caCert {CA_CERT}
    ```
=== "Windows"
    ```
    .\rpc configure addwifisettings -profileName profileName -authenticationMethod 7 -encryptionMethod 4 -ssid "networkSSID" -username "username" -authenticationProtocol 0 -priority 1 -clientCert {CLIENT_CERT} -caCert {CA_CERT}
    ```

###### Pass by JSON String

=== "Linux"
    ``` bash
    sudo ./rpc configure addwifisettings -configJson "{ "profileName": "exampleWifi8021x", "authenticationMethod": 7, "encryptionMethod": 4, "ssid": "ssid", "username": "username", "authenticationProtocol": 0, "priority": 1, "clientCert": "{CLIENT_CERT}", "caCert": "{CA_CERT}" }"
    ```
=== "Windows"
    ```
    .\rpc configure addwifisettings -configJson "{ "profileName": "exampleWifi8021x", "authenticationMethod": 7, "encryptionMethod": 4, "ssid": "ssid", "username": "username", "authenticationProtocol": 0, "priority": 1, "clientCert": "{CLIENT_CERT}", "caCert": "{CA_CERT}" }"
    ```

<br>

| OPTION                  | DESCRIPTION                                                                                                                                                                                            |
|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| -authenticationMethod   | Wifi authentication method. Valid Values = {5, 7} where `5` = WPA_IEEE8021X, `7` = WPA2_IEEE8021X                                                                                                      |
| -authenticationProtocol | 802.1x profile protocol. Valid Values = {0, 2} where `0` = EAP-TLS, `2` = EAPMSCHAPv2                                                                                                                  |
| -caCert                 | Trusted Microsoft root CA or 3rd-party root CA in Active Directory domain                                                                                                                              |
| -clientCert             | Client certificate chained to the `caCert`. Issued by enterprise CA or mapped to computer account in Active Directory. <br>AMT provides this certificate to authenticate itself with the Radius Server |
| -configFile             | File path of a `.yaml` or `.json` file with desired wireless 802.1x configuration, see [via Config File](#via-config-file)                                                                             |
| -configJson             | Configuration as a JSON string                                                                                                                                                                         |
| -encryptionMethod       | Wifi encryption method. Valid Values = {3, 4} where `3` = TKIP, `4` = CCMP                                                                                                                             |
| -ieee8021xPassword      | 8021x profile password if authenticationProtocol is PEAPv0/EAP-MSCHAPv2(2)                                                                                                                             |
| -profileName            | Profile name (Friendly name), must be alphanumeric                                                                                                                                                     |
| -priority               | Ranked priority over other profiles                                                                                                                                                                    |
| -privateKey             | 8021x profile private key of the `clientCert`                                                                                                                                                          |
| -pskPassphrase          | Wifi pskPassphrase if `authenticationMethod` is WPA2_IEEE8021X(6)                                                                                                                                      |
| -secretFile             | File path of a `.yaml` or `.json` file with secrets to be applied to the configurations, see [with Secrets File](#with-secrets-file)                                                                   |
| -ssid                   | Wifi SSID                                                                                                                                                                                              |
| -username               | 802.1x username, must match the Common Name of the `clientCert`                                                                                                                                        |

<br>

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
| Control Mode      | -mode     | Control Mode below indicates the managed device's state: <br>(a) pre-provisioning state <br>(b) activated in client control mode <br>(c) activated in admin control mode          | 
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
