## Manageability Engine BIOS Extensions (MEBX)

Intel® MEBX allows for configuration of the Intel Manageability Engine (ME) platform. Through this interface, you can provision AMT and customize a variety of settings manually.

### Set a DNS Suffix through MEBX
If DHCP option15 is not set, configure the DNS Suffix manually through MEBX. This enables the reactivation of the device remotely at a later time.

!!! important
    **MEBX Must Be Enabled in the BIOS**

    The MEBX screens must be enabled in the BIOS to perform the instructions below. Enter the BIOS configuration at boot to verify MEBX availability. Enable according to manufacturers instructions. 

**To configure the DNS Suffix in the BIOS:**

1. Restart or power on the device.

2. While the device is booting up, press **Ctrl+P** to reach the MEBX login screen. 

    !!! NOTE
        The keystroke combination **Ctrl+P** typically invokes the BIOS to display the MEBX login screen. If this does not work, check the manufacturer's instructions or try function keys (e.g., F2, F12).

3. Enter the AMT password.

    !!! NOTE
        If it is the first time entering MEBX and the device has not been provisioned previously, the default password is `admin`. Create a new password when prompted.

4. Select **Remote Setup and Configuration**.

5. Select **TLS PKI**.

6. Select **PKI DNS Suffix**.

7. Provide a DNS suffix name and press **Enter**.

8. Press **Esc** three times to reach the main menu.

9. Select **MEBX Exit**, and then press **y** to confirm the exit.
