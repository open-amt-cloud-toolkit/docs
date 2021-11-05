--8<-- "References/abbreviations.md"

### Create a Profile

During the activation process with the Remote Provisioning Client (RPC), profiles provide configuration information to the firmware on platforms featuring Intel® AMT.

In **Profiles**, the Open AMT Cloud Toolkit supports Client Initiated Remote Access (CIRA) connections, which use Transport Layer Security (TLS), and plain TLS. TLS connections encrypt Intel® AMT network traffic, increasing data security and privacy. 

!!! Important
    * TLS works with both ACM And CCM.
    * Because CIRA connections already use TLS, the option to use both in a profile is not available, as it would double the amount of encryption/decryption and potentially impact performance.

## To create a profile with TLS Config

1. Select the **Profiles** tab from the menu on the left.

2. Under the **Profiles** tab, click **New** in the top-right corner to create a profile.

  [![RPS](../assets/images/RPS_NewProfile.png)](../assets/images/RPS_NewProfile.png)
    **Figure 1: Create a new profile.**

3. Specify a **Profile Name** of your choice.

4. Under **Activation Mode** from the dropdown menu.

5. Provide or generate a strong **AMT Password**. AMT will verify this password when receiving a command from a MPS server. This password is also required for device deactivation.

     !!! tip
        The two buttons next to the password input are for toggling visibility and generating a new random password. Please note that **if the Vault database is lost or corrupted, all credentials that aren't also stored somewhere else will be lost.** There will be no way to login. The administrator will have to clear the CMOS battery on the managed devices!
   
7. The **MEBX Password** field is disabled, as the password for Intel® Manageability Engine BIOS Extensions (Intel® MEBX) cannot be set when activating in CCM due to the lower level of trust when compared to ACM.

8. Leave DHCP as the default for **Network Configuration**.

9. Optionally, add **Tags** to help in organizing and querying devices as your list of managed devices grow.

10. Select **Connection Configuration** to **TLS (Enterprise)**

11. Under **TLS (Enterprise)**, select **TLS Mode from** the dropdown menu. 

12. This express setup assumes the managed device (i.e. AMT device) is on a wired connection for quickest setup.  To learn more about a Wireless Setup, see the [Wireless Activation Tutorial](../Tutorials/createWiFiConfig.md).

13. Click **Save.**

    !!! example "Example profile with TLS Config"
        
        [![RPS](../assets/images/RPS_CreateProfileTLSConfig)](../assets/images/RPS_CreateProfileTLSConfig.png)
        
        **Figure 2: Example profile with TLS Config.**

## Next up
**[Build & Run RPC](../GetStarted/buildRPC.md)**

