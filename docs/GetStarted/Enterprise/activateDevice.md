--8<-- "References/abbreviations.md"

Developed in Go* programming language, the Remote Provisioning Client (RPC) application runs on the managed device. RPC-Go activates and configures Intel® AMT on the managed device. Once properly configured, the device can be added to Console.

## Download RPC

On the AMT device, download the latest RPC-Go version from the [RPC-Go GitHub Repo Releases Page](https://github.com/open-amt-cloud-toolkit/rpc-go/releases) for the Operating System of the AMT device (Windows or Linux).

## Activate Device

1. On the AMT device, open a Terminal (Linux) or Powershell/Command Prompt **as Administrator** (Windows).

2. Navigate to the directory containing the RPC application.

3. Intel AMT can be activated in one of two modes:

    - **Client Control Mode (CCM):** This mode offers all manageability features including, but not limited to, power control, audit logs, and hardware info. Redirection features, such as KVM or SOL, **require user consent**. The managed device will display a 6-digit code that **must** be entered by the remote admin to access the remote device via redirection.

    - **Admin Control Mode (ACM):** ACM mode supports all manageability features **without requiring user consent**. This means it is **not necessary** to have a person on-site to remote in and manage an edge device. In most IoT use cases, edge devices such as digital signage or kiosks may not be easily accessible or have available employees nearby. ACM mode proves immensely helpful in these scenarios.

    === "Client Control Mode (CCM)"

        1. Run the following command. Choose a **strong** password to set as the AMT Password.

            ```
            rpc activate -local -ccm -password NewAMTPassword
            ```

            !!! success
                ```
                time="2024-07-02T10:29:22-07:00" level=info msg="Status: Device activated in Client Control Mode"
                ```

    === "Admin Control Mode (ACM)"

        Admin Control Mode requires additional steps to establish strong security due to the elevated privileges.
        
        <br>

        **Provisioning Certificate**

        - [DigiCert](https://www.intel.com/content/www/us/en/support/articles/000055009/technologies.html)
        - [Entrust](https://www.intel.com/content/www/us/en/support/articles/000055010/technologies/intel-active-management-technology-intel-amt.html)
        - [GoDaddy](https://www.intel.com/content/www/us/en/support/articles/000020785/software.html)

        !!! Important "Important - Intel AMT and using CAs"
            For ACM in Open Active Management Technology (Open AMT) Cloud Toolkit, **use only** certificate vendors that support Intel® AMT.

            Alternatively, for development, custom provisioning certificates can be generated. See [Custom Provisioning Certificate](../../Reference/Certificates/generateProvisioningCert.md) for additional details.
        
        <br>

        **DNS Suffix**

        The DNS suffix encompasses the domain suffix (e.g., .com) and follows the hostname. Consider the following DNS Name example:

        !!! example "Example - DNS"
            DNS Name: cb-vending1.burgerbusiness.com

        In this example, the hostname is **cb-vending1** and the DNS suffix is **burgerbusiness.com.**

        **To set the DNS suffix:**

        - Manually set it using MEBX on the managed device. [See MEBX Documentation](../../Reference/MEBX/dnsSuffix.md).

        - Alternately, change the DHCP Option 15 to the DNS suffix within the Router settings.

        <br>

        **Activate into ACM**

        After obtaining a provisioning certificate and setting the DNS suffix, the AMT device is ready to be activated.

        1. Run the following command. Choose a **strong** password to set as the AMT Password.
        
            ```
            rpc activate -local -acm -amtPassword NewAMTPassword -provisioningCert "{BASE64_PROV_CERT}" -provisioningCertPwd certPassword
            ```

            !!! Note "Note - Using Config File and/or SMB Share"
                If you do not want to provide the base64 string of the provisioning certificate on the command line, a config file and/or SMB share can be used as a more secure method. See the [Local Activation RPC CLI Documentation](../../Reference/RPC/commandsRPC.md#activate-the-device-locally).

            !!! success
                ```
                time="2024-07-02T10:38:32-07:00" level=info msg="Status: Device activated in Admin Control Mode"
                ```

## Configure Network Settings

AMT can be configured for both wired and wireless networks. **Intel AMT does not currently support wireless for Linux-based devices.**

=== "Wired"

    1. Create a new file called `config.yaml`. Copy and paste the corresponding template below.

        These templates show how to create a simple Wired profile for configuring a device for either DHCP or a Static IP Address.

        === "DHCP"

            ```yaml title="config.yaml"
            password: 'AMTPassword' # alternatively, you can provide the AMT password of the device in the command line
            wiredConfig:
              dhcp: true
              ipsync: true
            ```

        === "Static"

            ```yaml title="config.yaml"
            password: 'AMTPassword' # alternatively, you can provide the AMT password of the device in the command line
            wiredConfig:
              static: true
              ipaddress: 192.168.1.50
              subnetmask: 255.255.255.0
              gateway: 192.168.1.1
              primarydns: 8.8.8.8
              secondarydns: 4.4.4.4
            ```        

    2. Change the fields with your desired values.

    3. Save the file.

    4. Provide the `config.yaml` file using the `-config` flag. 

        ```
        rpc configure wired -config config.yaml
        ```

=== "Wireless"

    1. Create a new file called `config.yaml`. Copy and paste the corresponding template below.

        These templates show how to create a simple Wireless profile called **exampleWifiWPA2**.

        ```yaml title="config.yaml"
        password: 'AMTPassword' # alternatively, you can provide the AMT password of the device in the command line
        wifiConfigs:
          - profileName: 'exampleWifiWPA2' # friendly name (ex. Profile name)
            ssid: 'exampleSSID' # network name
            priority: 1
            authenticationMethod: 6 # 4 for WPA, 6 for WPA2
            encryptionMethod: 4 # 3 for TKIP, 4 for CCMP
            pskPassphrase: '' # network password
        ```

    2. Fill in fields with desired options and secrets. If the secrets are **not** provided (e.g. secret field is an empty string or not given), the secrets will be prompted for as user input in the command line.

        Alternatively, secrets can be stored and referenced in a separate file. See the [RPC-Go Configure Wireless documentation](../../Reference/RPC/commandsRPC.md#wireless).

    3. Save the file.

    4. Provide the `config.yaml` file using the `-config` flag. 

        ```
        rpc configure wireless -config config.yaml
        ```

<br>

After the device has been activated and the network configured, the device can now be added and connected to using Console. 

## Next up

[**Add a Device**](addDevice.md)