--8<-- "References/abbreviations.md"

**To create a WiFi Config:**

1. Select the **Wireless** tab from the left-hand menu.

2. In the top-right corner, click **Add New.**
    [![RPS New Wireless Profile](../assets/images/RPS_NewWireless.png)](../assets/images/RPS_NewWireless.png)
    **Figure 1: Create a new WiFi Config.**

3. Specify a **Wireless Profile Name** of your choice.

4. Under **Authentication Method**, select **WPA PSK** or **WPA2 PSK**.

5. Under **Encryption Method**, select **TKIP** or **CCMP**.

6. Specify a **SSID**. This is the name of your wireless network.

7. Provide a strong **PSK Passphrase**. This is the password to the WiFi Network.

8. Click **Save.**

    !!! example "Example Wireless Profile"
        [![RPS Wireless Profile](../assets/images/RPS_WirelessCreate.png)](../assets/images/RPS_WirelessCreate.png)
        **Figure 2: Example Wireless Profile.** 

9. **Important**: After saving, continue on to create either a CCM or ACM profile. When prompted, select your new Wireless Profile from the drop-down menu. The selected Wi-Fi Profiles will be shown under **Associated Wireless Profiles** and can be re-ordered by dragging them.

    !!! example "Example - Select Wireless Profile"
        [![RPS Bottom of Profile](../assets/images/RPS_CreateProfile_withWiFi.png)](../assets/images/RPS_CreateProfile_withWiFi.png)
        **Figure 3: Selection of Wireless Profile in CCM/ACM Profile**

## Next up

Profiles provide configuration information to the AMT Firmware during the activation process with the Remote Provisioning Client (RPC). Profiles also distinguish between activating in: 

**[Client Control Mode (CCM):](createProfileCCM.md)** This mode offers nearly all manageability features including, but not limited to, power control, audit logs, and hardware info. **While Intel® AMT includes redirection features such as KVM while using user consent in CCM, the Open AMT Cloud Toolkit does not currently support doing so.**

[Create a CCM Profile](createProfileCCM.md){: .md-button .md-button--primary }

**[Admin Control Mode (ACM):](createProfileACM.md)** ACM mode supports all manageability features **without requiring user consent**. This means it is **not necessary** to have a person on-site to remote in and manage an edge device. In most IoT use cases, edge devices such as digital signage or kiosks may not be easily accessible or have available employees nearby. ACM mode proves immensely helpful in these scenarios.

[Create an ACM Profile](createProfileACM.md){: .md-button .md-button--primary }