## Manageability Engine BIOS Extensions (MEBX)

Intel® MEBX allows for configuration of the Intel Manageability Engine (ME) platform. Use this interface to provision and unprovision AMT. It also provides a variety of settings to configure manually. 

Use the unprovision functionality to remove a device from MPS control. 

### Unprovision an AMT Device Through MEBX

**To unprovision in the BIOS:**

1. Restart or power on the device. 

2. While the device is booting up, press **Ctrl+P** to reach the MEBX login screen 

    !!! NOTE
        The keystroke combination **Ctrl+P** typically invokes the BIOS to display the MEBX login screen. If this does not work, check the manufacturer's instructions or try function keys (e.g., F2, F12).

3. Enter the AMT password.

    !!! NOTE
        If it is the first time entering MEBX and the device has not been provisioned previously, the default password is `admin`. Create a new password when prompted.


4. Select **Intel AMT configuration**.

5. Select **Unconfigure Network access**.

6. Select **Full unprovision**, and then press **y** to continue 

7. It takes 30 seconds to a minute to unprovision the device. While it is unprovisioning, the up/down arrow keys will not work.
