--8<-- "References/abbreviations.md"

Client Control Mode (CCM) provides full access to features of Intel® Active Management Technology (Intel® AMT), but it does require user consent for all redirection features.

**While Intel® AMT includes the ability to use the features listed below with user consent in CCM, the Open AMT Cloud Toolkit does not currently support it.**

These features require user consent:

- Keyboard, Video, Mouse (KVM) Control
- IDE-Redirection for sharing and mounting images remotely
- Serial-over-LAN (SOL)

![assets/images/Profiles.png](../assets/images/Profiles.png)

**Figure 1: Set up configuration and profiles for N number of clients. **

## Create a Profile

Profiles provide configuration information to the firmware on platforms featuring Intel® AMT during the activation process with the Remote Provisioning Client (RPC).

**To create a CCM profile:**

1. Select the **Profiles** tab from the menu on the left.

2. Under the **Profiles** tab, click **New** in the top-right corner to create a profile.

    [![RPS](../assets/images/RPS_NewProfile.png)](../assets/images/RPS_NewProfile.png)
    **Figure 1: Create a new profile.**

3. Specify a **Profile Name** of your choice.

4. Under **Activation Mode**, select **Client Control Mode** from the dropdown menu.

5. Provide or generate a strong **AMT Password**. AMT will verify this password when receiving a command from a MPS server. This password is also required for device deactivation.
   
    !!! tip
        The two buttons next to the password input are for toggling visibility and generating a new random password. Please note that **if the Vault database is lost or corrupted, all credentials that aren't also stored somewhere else will be lost.** There will be no way to login. The administrator will have to clear the CMOS battery on the managed devices!
   
7. The **MEBX Password** field is disabled, as the password for Intel® Manageability Engine BIOS Extensions (Intel® MEBX) cannot be set when activating in CCM due to the lower level of trust when compared to ACM.

8. Leave DHCP as the default for **Network Configuration**.

9. Optionally, add **Tags** to help in organizing and querying devices as your list of managed devices grow.

10. Select the name of the **CIRA Configuration** you created previously from the drop-down menu.

11. This express setup assumes the managed device (i.e. AMT device) is on a wired connection for quickest setup.  To learn more about a Wireless Setup, see the [Wireless Activation Tutorial](./createWiFiConfig.md).

12. Click **Save.**

    !!! example "Example CCM Profile"
        
        [![RPS](../assets/images/RPS_CreateProfile.png)](../assets/images/RPS_CreateProfile.png)
        
        **Figure 2: Example CCM profile.**

## Next up
**[Build & Run RPC](buildRPC.md)**

