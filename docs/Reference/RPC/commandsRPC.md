--8<-- "References/abbreviations.md"

On the managed device, a Remote Provisioning Client (RPC) communicates with the Remote Provision Server (RPS) in the process of activating or deactivating the device. In addition to activation and deactivation, the RPC provides informational and maintenance commands.

## List Commands

RPC must run with elevated privileges. Commands require `sudo` on Linux or an Administrator Command Prompt on Windows.

Run the RPC application on the command line with no arguments to see supported commands:

```
rpc
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

```
rpc [COMMAND]
```

### activate

#### Activate and Configure the device using RPS:

Activate the device with a specified profile:

```
rpc activate -u wss://server/activate -profile profilename
```

#### Activate the device locally:

This capability is only supported for activating unprovisioned (e.g. pre-provisioning state) devices. This command **only** activates AMT. It does not do profile-based configuration.

=== "CCM"
    ```
    rpc activate -local -ccm -password NewAMTPassword
    ```
=== "ACM"

    === "Local Stored Provisioning Cert"
        ```
        rpc activate -local -acm -amtPassword NewAMTPassword -provisioningCert "{BASE64_PROV_CERT}" -provisioningCertPwd certPassword
        ```
    === "Remote Stored Provisioning Cert"
        Currently, the only supported remote network share is Server Message Block (SMB) based shares. 


        ``` title="No Credentials Required"
        rpc activate -local -acm -config smb://server/shareName/filePath/test.pfx -provisioningCertPwd certPassword -amtPassword amtPass
        ```

        ``` title="Credentials Required"
        rpc activate -local -acm -config smb://workgroup;username:password@server/shareName/filePath/test.pfx -provisioningCertPwd certPassword -amtPassword amtPass
        ```

        ``` title="Credentials Required but Prompt for Password"
        rpc activate -local -acm -config smb://workgroup;username:*@server/shareName/filePath/test.pfx -provisioningCertPwd certPassword -amtPassword amtPass
        ```

=== "ACM w/ Config File"
    Options can be passed via a config file. This can also be combined into a single config file with [addwifisettings](#addwifisettings) information.

    === "YAML"
        ```yaml title="config.yaml"
        acmactivate:
          amtPassword: 'P@ssw0rd'
          provisioningCert: 'BASE64_PROV_CERT'
          provivisioningCertPwd: 'CertP@ssw0rd'
        ```

    Example Commands:

    === "Local Stored Config File"
        ```
        rpc activate -local -acm -config config.yaml
        ```
    === "Remote Stored Config File"
        Currently, the only supported remote network share is Server Message Block (SMB) based shares.

        ``` title="No Credentials Required"
        rpc activate -local -acm -config smb://shareName/filePath/config.yaml
        ```

        ``` title="Credentials Required"
        rpc activate -local -acm -config smb://workgroup;username:password@server/shareName/filePath/config.yaml
        ```

        ``` title="Credentials Required but Prompt for Password"
        rpc activate -local -acm -config smb://workgroup;username:*@server/shareName/filePath/config.yaml
        ```


<br>

#### `activate` General Options

| OPTION             | DESCRIPTION                                                                                                                       |
|--------------------|-----------------------------------------------------------------------------------------------------------------------------------|
| -json              | JSON output                                                                                                                       |
| -l string          | Log level (panic,fatal,error,warn,info,debug,trace) (default "info")                                                              |
| -lmsaddress string | LMS address (default "localhost"). Can be used to change location of LMS for debugging.                                           |
| -lmsport string    | LMS port (default "16992")                                                                                                        |
| -n                 | Skip WebSocket server certificate verification                                                                                    |
| -skipIPRenew       | Skip DHCP renewal of the IP address if AMT becomes enabled. Only applicable for 13th Gen Raptor Lake (AMT 16.1) or newer devices. |                                                                                  |
| -t duration        | Time to wait until AMT is ready (e.g. `2m` or `30s`), the default is `2m0s`                                                       |
| -v                 | Verbose output                                                                                                                    |

#### `activate` Remote-Specific Options

| OPTION             | DESCRIPTION                                                                                                                     |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------|
| -d string          | DNS suffix override                                                                                                             |
| -h string          | Hostname override                                                                                                               |
| -n                 | Skip WebSocket server certificate verification                                                                                  |
| -name string       | Friendly name to associate with this device                                                                                     |
| -p string          | Proxy address and port                                                                                                          |
| -password          | Existing set AMT password                                                                                                       |
| -profile string    | Name of the profile to use                                                                                                      |
| -tenant string     | TenantID of profile. If not provided, then assumed empty string (i.e. [no Multitenancy enabled](../middlewareExtensibility.md)) |
| -token string      | JWT Token for Authorization                                                                                                     |
| -u string          | WebSocket address of server to activate against                                                                                 |
| -uuid string       | Override AMT device UUID for use with **non-CIRA** workflow and deployments. This is for specific use cases where the hardware does not have a correctly assigned or formatted UUID. This is **NOT recommended** in other situations and could potentially break features. <br><br> Input must match standard UUID alphanumeric, hyphenated format (e.g. 4c4c4544-005a-3510-8047-b4c04f564433). |

#### `activate` Local-Specific Options

| OPTION                            | DESCRIPTION                                                                           |
|-----------------------------------|---------------------------------------------------------------------------------------|
| -acm                              | Flag for ACM Local Activation.                                                        |
| -amtPassword string               | New AMT Password to set on device.                                                    |
| -ccm                              | Flag for CCM Local Activation.                                                        |
| -config                           | Remote `smb://` or local file path of a `.yaml` file with desired ACM configuration.  |
| -local                            | Execute command to AMT directly without cloud interaction.                            |
| -provisioningCert Base64 string   | Base64 Encoded String of the `.pfx` provisioning certificate.                         |
| -provisioningCertPwd string       | Password of provisioning certificate.                                                 |

For more information, see [Build & Run RPC](../../GetStarted/buildRPC.md).

To learn how to use the RPC application to transition an already activated (provisioned) Intel vPro® Platform, see [Transition Activated Device](../../Reference/RPC/buildRPC_Manual.md#TransitionDevice).

### deactivate

!!! warning "Warning - Future Deprecation: Changing of Kong Routes"
    **We have now enabled the `/deactivate` Kong route.** The previous `/activate` route will still function for deactivate commands to avoid breaking changes. However, the `/activate` route's use with deactivate will be deprecated in the future and it is recommended to utilize the new, `/deactivate` route for new development.

#### Deactivate the device using RPS:

```
rpc deactivate -u wss://server/deactivate
```

#### Deactivate the device locally:

```
rpc deactivate -local -password AMTPassword
```

<br>

#### `deactivate` Options

| OPTION             | DESCRIPTION                                                                             |
|--------------------|-----------------------------------------------------------------------------------------|
| -json              | JSON output                                                                             |
| -l string          | Log level (panic,fatal,error,warn,info,debug,trace) (default "info")                    |
| -lmsaddress string | LMS address (default "localhost"). Can be used to change location of LMS for debugging. |
| -lmsport string    | LMS port (default "16992")                                                              |
| -local             | Execute command to AMT directly without cloud interaction.                              |
| -password string   | AMT password                                                                            |
| -t duration        | Time to wait until AMT is ready (e.g. `2m` or `30s`), the default is `2m0s`             |
| -v                 | Verbose output                                                                          |

#### `deactivate` Remote-Specific Options

| OPTION             | DESCRIPTION                                                                             |
|--------------------|-----------------------------------------------------------------------------------------|
| -f                 | Force deactivate even if device is not registered with the RPS server                   |
| -n                 | Skip WebSocket server certificate verification                                          |
| -p string          | Proxy address and port                                                                  |
| -token string      | JWT Token for Authorization                                                             |
| -u string          | WebSocket address of server to activate against                                         |

For more information, see [Build & Run RPC](../../GetStarted/buildRPC.md).

### maintenance

!!! warning "Warning - Future Deprecation: Changing of Kong Routes"
    **We have now enabled the `/maintenance` Kong route.** The previous `/activate` route will still function for maintenance commands to avoid breaking changes. However, the `/activate` route's use with maintenance will be deprecated in the future and it is recommended to utilize the new, `/maintenance` route for new development.

Execute a maintenance command for the managed device:

| SUBCOMMAND                            | DESCRIPTION                                                                                           |
|---------------------------------------|-------------------------------------------------------------------------------------------------------|
| [changepassword](#changepassword)     | Change the AMT password. <br> A random password is generated by default if `-static` is not provided. |
| [syncclock](#syncclock)               | Sync the host OS clock to AMT.                                                                        |
| [syncdeviceinfo](#syncdeviceinfo)     | Sync the device info stored in the MPS database with the current local AMT device info.               |
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
| -uuid string       | Override AMT device UUID for use with **non-CIRA** workflow and deployments. This is for specific use cases where the hardware does not have a correctly assigned or formatted UUID. This is **NOT recommended** in other situations and could potentially break features. <br><br> Input must match standard UUID alphanumeric, hyphenated format (e.g. 4c4c4544-005a-3510-8047-b4c04f564433). |
| -v                 | Verbose output                                                                                                                   |

<br>

#### changepassword

Change the AMT password. A random password is generated by default if `static` option is not passed.

```
rpc maintenance changepassword -u wss://server/maintenance
```

| OPTION  | DESCRIPTION             |
|---------|-------------------------|
| -static | New password to be used |

<br>

#### syncclock

Syncs the host OS clock to AMT.

```
rpc maintenance syncclock -u wss://server/maintenance
```

<br>

#### syncdeviceinfo

Sync stored device info within the MPS database to the current, local device info. On device activation, MPS will store some device information as a JSON object. Some of this data may change over time like the firmware versions, activation modes, or IP address and could be outdated.

```
rpc maintenance syncdeviceinfo -u wss://server/maintenance
```

<br>

#### synchostname

Sync the OS hostname to AMT Network Settings.

```
rpc maintenance synchostname -u wss://server/maintenance
```

<br>

#### syncip

Sync the static IP of host OS to AMT Network Settings.

```
rpc maintenance syncip -staticip 192.168.1.7 -netmask 255.255.255.0 -gateway 192.168.1.1 -primarydns 8.8.8.8 -secondarydns 4.4.4.4 -u wss://server/maintenance
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
| [enablewifiport](#enablewifiport)     | Enables WiFi port and local profile synchronization settings in AMT. AMT password is required.        |
| [tls](#tls)     | Enables WiFi port and local profile synchronization settings in AMT. AMT password is required.        |


<br>

#### Common `configure` Options

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


=== "Config File"
    ##### via Config file

    The Config file can be formatted as either YAML or JSON. This example shows YAML but a JSON template is provided as well.

    1. Create a new file called `config.yaml`. Copy and paste the corresponding template below.

        These templates show how to create a simple Wireless profile called **exampleWifiWPA2** and a Wireless profile utilizing 802.1x called **exampleWifi8021x**.

        === "YAML"
            ```yaml title="config.yaml"
            password: 'amtPassword' # optionally, you can provide the AMT password of the device in the config file
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
            "password": "amtPassword",
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

    2. Fill in fields with desired options and secrets.  If the secrets are **not** provided (e.g. secret field is an empty string or not given), the secrets will be prompted for as user input in the command line.

        Alternatively, secrets can be stored and referenced in a separate file. See **Config w/ Secrets File** tab for more information.

    3. Provide the `config.yaml` file using the `-config` flag. 

        ```
        rpc configure addwifisettings -config config.yaml
        ```

=== "Config w/ Secrets File"
    ##### via Config with Secrets file

    If a secrets file is included with the configuration file, those secrets will be used in the matching `profileName` configuration. These templates show how to create a simple Wireless profile called **exampleWifiWPA2** and a Wireless profile utilizing 802.1x called **exampleWifi8021x**.

    1. Create a new file called `config.yaml`. Copy and paste the corresponding template below.

        This `config.yaml` is slightly different from the standard one as we either delete or leave blank the secret fields `pskPassphrase`, `password`, and `privateKey`.

        === "YAML"
            ```yaml title="config.yaml"
            wifiConfigs:
              - profileName: 'exampleWifiWPA2' # friendly name (ex. Profile name)
                ssid: 'exampleSSID'
                priority: 1
                authenticationMethod: 6
                encryptionMethod: 4
              - profileName: 'exampleWifi8021x' # friendly name (ex. Profile name)
                ssid: 'ssid'
                priority: 2
                authenticationMethod: 7
                encryptionMethod: 4
                ieee8021xProfileName: 'exampleIeee8021xEAP-TLS'
            ieee8021xConfigs:
              - profileName: 'exampleIeee8021xEAP-TLS'
                username: "exampleUserName"
                password: "" # 8021x password if authenticationProtocol is PEAPv0/EAP-MSCHAPv2(2)
                authenticationProtocol: 0 #8021x profile (ex. EAP-TLS(0))
                clientCert: ''
                caCert: ''
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
                }
            ]
            }
            ```

    2. Create a new file called `secrets.yaml`. Copy and paste the template below.

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

    3. Fill in fields with the secrets. The `profileName` given in the secrets file must match the corresponding Wireless or 802.1x configuration `profileName`.
    
    4. Provide the `secrets.yaml` file using the `-secrets` flag. 

        ```
        rpc configure addwifisettings -config config.yaml -secrets secrets.yaml
        ```


=== "Individual Options"
    ##### via Individual Options
    
    Alternatively, provide all options directly in the command line. The user will be prompted for missing secrets (i.e. password, privateKey, pskPassphrase, ieee8021xPassword), if not provided.

    !!! warning "Warning - Use Case and Security"
        The CLI option is intended for use as part of an integration of RPC as a shared library. The passing of secrets directly via command line is highly insecure and **NOT** recommended.

    ```
    rpc configure addwifisettings -profileName profileName -authenticationMethod 7 -encryptionMethod 4 -ssid "networkSSID" -username "username" -authenticationProtocol 0 -priority 1 -clientCert "{CLIENT_CERT}" -caCert "{CA_CERT}" -privateKey "{PRIVATE_KEY}"
    ```

=== "-configJson String Option"
    ##### via -configJson Option
    
    Or, provide the JSON string directly in the command line. The user will be prompted for missing secrets (i.e. password, privateKey, pskPassphrase, ieee8021xPassword), if not provided.

    !!! warning "Warning - Use Case and Security"
        The CLI option is intended for use as part of an integration of RPC as a shared library. The passing of secrets directly via command line is highly insecure and **NOT** recommended.

    === "Wireless Only"
        ```
        rpc configure addwifisettings -configJson "{ "wifiConfigs": [ { "profileName": "exampleWifi", "authenticationMethod": 6, "encryptionMethod": 4, "ssid": "networkSSID", "username": "username", "authenticationProtocol": 0, "priority": 1 } ] }"
        ```

    === "Wireless w/ 802.1x"
        ```
        rpc configure addwifisettings -configJson "{ "wifiConfigs": [ { "profileName": "exampleWifi8021x", "ssid": "networkSSID", "priority": 1, "authenticationMethod": 7, "encryptionMethod": 4, "ieee8021xProfileName": "exampleIeee8021xEAP-TLS" } ], "ieee8021xConfigs": [ { "profileName": "exampleIeee8021xEAP-TLS", "username": "exampleUserName", "password": "", "authenticationProtocol": 0, "clientCert": "{CLIENT_CERT}", "caCert": "{CA_CERT}", "privateKey": "{PRIVATE_KEY}" } ] }"
        ```

!!! success "Example Successful Output of Configuring Two Wireless Profiles"
    ```
    time="2023-08-30T13:21:39-07:00" level=info msg="configuring wifi profile: exampleWifiWPA2"
    time="2023-08-30T13:21:39-07:00" level=info msg="successfully configured: exampleWifiWPA2"
    time="2023-08-30T13:21:39-07:00" level=info msg="configuring wifi profile: exampleWifi8021x"
    time="2023-08-30T13:21:39-07:00" level=info msg="successfully configured: exampleWifi8021x"
    ```

<br>

| OPTION                  | DESCRIPTION                                                                                                                                                                                             |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| -authenticationMethod   | Wifi authentication method. Valid Values = {4, 5, 6, 7} where `4` = WPA PSK, `5` = WPA_IEEE8021X, `6` = WPA2 PSK, `7` = WPA2_IEEE8021X                                                                  |
| -authenticationProtocol | 802.1x profile protocol. Valid Values = {0, 2} where `0` = EAP-TLS, `2` = EAP/MSCHAPv2                                                                                                                  |
| -caCert                 | Trusted Microsoft root CA or 3rd-party root CA in Active Directory domain.                                                                                                                              |
| -clientCert             | Client certificate chained to the `caCert`. Issued by enterprise CA or mapped to computer account in Active Directory. <br>AMT provides this certificate to authenticate itself with the Radius Server. |
| -config                 | File path of a `.yaml` or `.json` file with desired wireless and/or wireless 802.1x configuration.                                                                                                      |
| -configJson             | Configuration as a JSON string                                                                                                                                                                          |
| -encryptionMethod       | Wifi encryption method. Valid Values = {3, 4} where `3` = TKIP, `4` = CCMP                                                                                                                              |
| -ieee8021xPassword      | 802.1x profile password if authenticationProtocol is PEAPv0/EAP-MSCHAPv2(2).                                                                                                                            |
| -profileName            | Profile name (Friendly name), must be alphanumeric.                                                                                                                                                     |
| -priority               | Ranked priority over other profiles.                                                                                                                                                                    |
| -privateKey             | 802.1x profile private key of the `clientCert`.                                                                                                                                                         |
| -pskPassphrase          | Wifi `pskPassphrase`, if `authenticationMethod` is WPA PSK(4) or WPA2 PSK(6).                                                                                                                           |
| -secrets                | File path of a `.yaml` or `.json` file with secrets to be applied to the configurations.                                                                                                                |
| -ssid                   | Wifi SSID                                                                                                                                                                                               |
| -username               | 802.1x username, must match the Common Name of the `clientCert`.                                                                                                                                        |

<br>

#### enablewifiport

Enables WiFi port and local profile synchronization settings in AMT. This feature synchronizes the wireless profile set in the OS with the wireless profile set in AMT. AMT Password is required.

```
rpc configure enablewifiport -password AMTPassword
```

<br>

#### tls

Configures TLS in AMT. AMT password is required.

!!! note "Note - Current Implementation of `configure tls`"
    The current implementation only includes support for self-signed TLS certificates. [See our backlog](https://github.com/orgs/open-amt-cloud-toolkit/projects/10) for updates and details on expanded support for retrieving certificates and CSRs during local configuration using Enterprise Assistant.


```
rpc configure tls -mode Server -password AMTPassword
```

<br>

| OPTION  | DESCRIPTION                                                                                                                            |
|---------|----------------------------------------------------------------------------------------------------------------------------------------|
| -delay  | Delay time in seconds after putting remote TLS settings. Default is 3 seconds if not provided.                                         |
| -mode   | TLS authentication usage model. Valid Values = {Server, ServerAndNonTLS, Mutual, MutualAndNonTLS}. Default is Server if not provided.  |

<br>

### amtinfo

Display AMT status and configuration:

```
rpc amtinfo [OPTIONS]
```

**Not passing `[OPTIONS]` will print all information.**

| AMT INFO             | OPTION            | DESCRIPTION                                                                                                                                                                           | 
|----------------------|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|                      | -json             | JSON Output                                                                                                                                                                           |
| Version              | -ver              | Intel AMT version.                                                                                                                                                                    | 
| Build Number         | -bld              | Intel AMT Build Number.                                                                                                                                                               |
| System Certificates  | -cert             | System Certificate Hashes. If given `-password`, will print both System and User Certificate Hashes.                                                                                  |
| User Certificates    | -userCert         | User Certificate Hashes. Will prompt for AMT password. Or, provide `-password` flag.                                                                                                  |
| SKU                  | -sku              | Product SKU                                                                                                                                                                           | 
| UUID                 | -uuid             | Unique Universal Identifier of the device. Used when creating device-specific MPS API calls as part of the REST API's URL path.                                                       | 
| Control Mode         | -mode             | Control Mode below indicates the managed device's state: <br>(a) pre-provisioning state <br>(b) activated in client control mode <br>(c) activated in admin control mode              | 
| Operational State    | -operationalState | Enabled/Disabled boolean. Returns state of AMT for 13th Gen Raptor Lake (AMT 16.1) or newer devices. N/A for earlier generation devices.                                              |
| DNS Suffix           | -dns              | DNS Suffix set according to PKI DNS Suffix in Intel MEBX or through DHCP Option 15. Required for ACM activation.                                                                      |
| DNS Suffix (OS)      | -dns              |                                                                                                                                                                                       |
| Hostname (OS)        | -hostname         | Device's hostname as set in the Operating System.                                                                                                                                     |
| RAS Network          | -ras              |                                                                                                                                                                                       |
| RAS Remote Status    | -ras              | Unconnected or connected. State of connection to a management server.                                                                                                                 |
| RAS Trigger          | -ras              | User initiated or periodic. When activated, periodic signifies CIRA established. By default, CIRA sends a heartbeat to the server every 30 seconds to verify and maintain connection. |
| RAS MPS Hostname     | -ras              | IP Address or FQDN of the MPS server.                                                                                                                                                 |

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

```
rpc version
```
