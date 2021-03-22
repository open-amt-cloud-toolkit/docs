[**Client Control Mode (CCM)**](../Glossary.md#c) provides full access to features of Intel® Active Management Technology (Intel® AMT), but it does require user consent for all redirection features.

These features require user consent:

- Keyboard, Video, Mouse (KVM) Control
- IDE-Redirection for sharing and mounting images remotely
- Serial-over-LAN (SOL)

![assets/images/Profiles.png](../assets/images/Profiles.png)

**Figure 1: Set up configuration and profiles for N number of clients. **

## Create a Profile

[Profiles](../Glossary.md#p) provide configuration information to the AMT Firmware during the activation process with the [Remote Provisioning Client (RPC)](../Glossary.md#r).

**To create a CCM profile:**

1. Select the **Profiles** tab from the menu on the left.

2. Under the **Profiles** tab, click **New** in the top-right corner to create a profile.

3. Specify a **Profile Name** of your choice.

4. Under **Activation**, select **Client Control Mode** from the dropdown menu.

5. Leave **Generate Random AMT Password** unchecked.
   
    !!! tip "Production Environment"
        In a production environment, you typically generate a random password for each AMT device to create a stronger, more secure AMT environment.

6. Provide a strong **AMT Password**.

    !!! important
        This password must meet standard, **strong** password requirements:

        - 8 to 32 characters

        - One uppercase, one lowercase, one numerical digit, one special character

7. Leave **Generate Random MEBX Password** unchecked.
   
8. Provide a strong **MEBX Password**.

9. Select DHCP as **Network Configuration**.

10. Select the name of the **CIRA Configuration** you created previously from the drop-down menu.

11. Click **Create.**

    !!! example
        Example CCM Profile:

        [![RPS](../assets/images/RPS_CreateProfile.png)](../assets/images/RPS_CreateProfile.png)

## Next up
**[Build & Run RPC](buildRPC.md)**

