--8<-- "References/abbreviations.md"

Network Configuration profiles on the RPS server help to set the desired network on the AMT device. The [AMT Ethernet Port Setting](https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/default.htm?turl=HTMLDocuments%2FWS-Management_Class_Reference%2FAMT_EthernetPortSettings.htm) is the AMT API used to set the network settings in AMT by the RPS. RPS network profiles currently contain three boolean settings.

- **DHCPEnabled** - is a boolean. Indicates whether DHCP is in use. 
- **SharedStaticIp** - is a boolean. Indicates whether the static host IP is shared with ME.   
- **IpSyncEnabled** - is a boolean. Indicates whether the IP synchronization between host and ME is enabled.

### Predefined Profiles

RPS currently supports two predefined network configurations, DHCP_Enabled and DHCP_Disabled, with the following settings.

DHCP_Enabled Network Config:
    ```json
    {
        "ProfileName": "dhcp_enabled",
        "DHCPEnabled": true,
        "StaticIPShared": false,
        "IPSyncEnabled": true
    }
    ```

DHCP_Disabled Network Config:
    ```json
    {
        "ProfileName": "dhcp_disabled",
        "DHCPEnabled": false,
        "StaticIPShared": true,
        "IPSyncEnabled": true
    }
    ```

<!-- Below configuration settings are not yet supported by RPS network profiles. 

- **SharedDynamicIP** - is a boolean.  Indicates whether the dynamic host IP is shared with ME.   
- **IPAddress** - String representation of IP address. Get operation    reports the acquired IP address (whether in static or DHCP mode). Put    operation - sets the IP address (in static mode only).  
 - **SubnetMask** - Subnet mask in a string format. For example: 255.255.0.0 
 - **DefaultGateway** - Default Gateway in a string format. For example: 10.12.232.1   
 - **PrimaryDNS** - Primary DNS in a string format. For example: 10.12.232.1   
- **SecondaryDNS** - Secondary DNS in a string    format. For example: 10.12.232.1 -->

### Example Scenarios

The following are scenarios depicting the result of RPS attempting to set network settings in comparison to the set Host OS settings.

| Host OS | RPS Network Profile Used | Network Settings on Device &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | Result |
| :----------- | :------------------------ |  :----------- |:----------- |
|Static IP| DHCP_Enabled |&#10006; DHCP in Use<br>&#10004; Shared Static IP<br>&#10006; IP Sync| RPS update the device settings as per the profile. Deletes SubnetMask, DefaultGateway, IPAddress, PrimaryDNS, and SecondaryDNS.
|Static IP| DHCP_Disabled|&#10004; DHCP in Use<br>&#10006; Shared Static IP<br>&#10006; IP Sync| RPS update the device settings as per the profile. Deletes SubnetMask, DefaultGateway, IPAddress, PrimaryDNS, and SecondaryDNS.<br>Note: Sets the same static IP address as host.
|Static IP| DHCP_Disabled|&#10006; DHCP in Use<br>&#10004; Shared Static IP<br>&#10006; IP Sync| RPS updates the device settings as per the profile. <br>Note: Sets the same static IP address as host as IP Sync is enabled.
|DHCP| DHCP_Enabled|&#10004; DHCP in Use<br>&#10006; Shared Static IP<br>&#10006; IP Sync| RPS updates the device settings as per the profile. Deletes SubnetMask, DefaultGateway, IPAddress, PrimaryDNS, and SecondaryDNS.
|DHCP| DHCP_Disabled|&#10004; DHCP in Use<br>&#10006; Shared Static IP<br>&#10006; IP Sync| RPS updates the device settings as per the profile. Set SubnetMask, DefaultGateway, IPAddress, PrimaryDNS, and SecondaryDNS.



<!-- All interactions -->

<!-- | Host OS | Network profile in RPS | Network settings on device | Comments |
| :----------- | :------------------------ |  :----------- |:----------- |
|Static IP|DHCPEnabled=true<br>SharedStaticIP=false<br>IPSyncEnabled=false|DHCPEnabled=true<br>SharedStaticIP=false<br>IPSyncEnabled=false| RPS ignore the request as both network profile and device settings are same.
|Static IP| DHCPEnabled=true<br>SharedStaticIP=false<br>IPSyncEnabled=true|DHCPEnabled=false<br>SharedStaticIP=true<br>IPSyncEnabled=false| RPS update the device settings as per the profile.Deletes SubnetMask, DefaultGateway, IPAddress, PrimaryDNS, SecondaryDNS<br>Note: IPSyncEnabled didnt work as expected. It took default DHCP IP instead of static IP of the host.
|Static IP| DHCPEnabled=false<br>SharedStaticIP=true<br>IPSyncEnabled=false|DHCPEnabled=false<br>SharedStaticIP=true<br>IPSyncEnabled=false| RPS ignore the request as both network profile and device settings are same.
|Static IP| DHCPEnabled=false<br>SharedStaticIP=true<br>IPSyncEnabled=false|DHCPEnabled=true<br>SharedStaticIP=false<br>IPSyncEnabled=false| RPS update the device settings as per the profile. Set SubnetMask, DefaultGateway, IPAddress, PrimaryDNS, SecondaryDNS<br>Note: Sets IP address which is different from host static IP address.
|Static IP| DHCPEnabled=false<br>SharedStaticIP=true<br>IPSyncEnabled=true|DHCPEnabled=true<br>SharedStaticIP=false<br>IPSyncEnabled=false| RPS update the device settings as per the profile. Deletes SubnetMask, DefaultGateway, IPAddress, PrimaryDNS, SecondaryDNS<br>Note: Sets the same static IP address as host.
|Static IP| DHCPEnabled=false<br>SharedStaticIP=true<br>IPSyncEnabled=true|DHCPEnabled=false<br>SharedStaticIP=true<br>IPSyncEnabled=false| RPS update the device settings as per the profile. <br>Note: Sets the same static IP address as host as IP Sync is enabled
|DHCP| DHCPEnabled=true<br>SharedStaticIP=false<br>IPSyncEnabled=false|DHCPEnabled=true<br>SharedStaticIP=false<br>IPSyncEnabled=false| RPS ignore the request as both network profile and device settings are same.
|DHCP| DHCPEnabled=true<br>SharedStaticIP=false<br>IPSyncEnabled=true|DHCPEnabled=true<br>SharedStaticIP=false<br>IPSyncEnabled=false| RPS update the device settings as per the profile. Deletes SubnetMask, DefaultGateway, IPAddress, PrimaryDNS, SecondaryDNS.
|DHCP| DHCPEnabled=false<br>SharedStaticIP=true<br>IPSyncEnabled=true|DHCPEnabled=true<br>SharedStaticIP=false<br>IPSyncEnabled=false| RPS update the device settings as per the profile. Set SubnetMask, DefaultGateway, IPAddress, PrimaryDNS, SecondaryDNS.<br>Note: Though the API responded that the requested changes are updated. After few minutes, it turned automatically to DHCP on the AMT.
|DHCP| DHCPEnabled=false<br>SharedStaticIP=true<br>IPSyncEnabled=false|DHCPEnabled=true<br>SharedStaticIP=false<br>IPSyncEnabled=true| RPS update the device settings as per the profile. Set SubnetMask, DefaultGateway, IPAddress, PrimaryDNS, SecondaryDNS. -->