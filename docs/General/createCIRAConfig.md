--8<-- "References/abbreviations.md"

OOB Management is a separate channel of remote management that allows administrators to securely access Intel® Active Management Technology (Intel® AMT) devices at a hardware level, beneath the operating system. This is accomplished with Client Initiated Remote Access (CIRA), which enables a CIRA-capable edge device to initiate and establish a persistent connection to the MPS. 

With this persistent connection, administrators can execute various system actions on the remotely managed device, including:

* Reboot
* Reset
* Power on and power up
* Power off and power down
* Boot to BIOS 
* Reset to BIOS

Intel® AMT supports these actions and more.

As long as the managed device is connected to the network and to a power source, it can maintain a persistent connection. 

**To create a CIRA Config:**

1. Select the **CIRA Configs** tab from the left-hand menu.

2. In the top-right corner, click **Add New.**
    [![RPS](../assets/images/RPS_NewCIRAConfig.png)](../assets/images/RPS_NewCIRAConfig.png)
    **Figure 1: Create a new CIRA Config.**

3. Specify a **Config Name** of your choice.

4. Select **IPv4**, and provide your development system's IP Address.

5. **Cert Common Name (CN=)** should auto-populate. If not, provide your development system's IP Address.

6. Leave **Port** as the default, 4433.

7. Leave the **Username** as *admin* or choose your own. These credentials will be used when constructing API calls.

8. Set a strong **Password** of your choice.

    !!! important "Important - Using Strong Passwords"
        This password must meet standard, **strong** password requirements:

        - 8 to 32 characters

        - One uppercase, one lowercase, one numerical digit, one special character

9. Leave the slider set on **Auto-load**.

10. Click **Save.**
    
    !!! example "Example CIRA Config"
            
        [![RPS](../assets/images/RPS_CreateCIRAConfig.png)](../assets/images/RPS_CreateCIRAConfig.png)
        **Figure 2: Example CIRA Config.** 

## Next up

Profiles provide configuration information to the AMT Firmware during the activation process with the Remote Provisioning Client (RPC). Profiles also distinguish between activating in: 

**[Client Control Mode (CCM):](createProfileCCM.md)** This mode offers nearly all manageability features including, but not limited to, power control, audit logs, and hardware info. **While Intel® AMT includes redirection features such as KVM while using user consent in CCM, the Open AMT Cloud Toolkit does not currently support doing so.**

**[Admin Control Mode (ACM):](createProfileACM.md)** ACM mode supports all manageability features **without requiring user consent**. This means it is **not necessary** to have a person on-site to remote in and manage an edge device. In most IoT use cases, edge devices such as digital signage or kiosks may not be easily accessible or have available employees nearby. ACM mode proves immensely helpful in these scenarios.



