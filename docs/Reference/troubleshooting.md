--8<-- "References/abbreviations.md"

The sections below detail possible errors that may occur when activating or de-activating managed devices along with some potential solutions.

# Intel&reg; AMT Device

| Error Issue or Message | Possible Solutions |
| ------------- | ------------------ |
| Intel&reg; AMT device fails to reconnect after MPS is down for 2 or more days | Update to latest firmware.  Workarounds include: a) Reboot device b) unplug and re-plug network cable |

# MPS

| Error Issue or Message | Possible Solutions |
| ------------- | ------------------ |
| Vault is empty in dev mode. | Profiles and configs are not persistent in this mode. To run vault in production mode, follow the [Use Docker and Vault in Production Mode](../Reference/productionVault.md).|
|MPS is missing from list of running services. | (1) Check for error messages in the logs. |
| | (2) Verify that the .env file contains correct values in each field.|

# RPS

| Error Issue or Message | Possible Solutions |
| ------------- | ------------------ |
| Create a profile fails or information cannot be read from vault. | Make sure Vault and PostGres are running. For details, see the `docker ps` command in [Build and Run Docker Images](../GetStarted/setup.md#Builddockerimages).|
| An error occurred during provisioning. | (1) Verify that the correct certificate is being used. |
|  | (2) Verify the Domain suffix. |



# RPC

| Error Issue or Message | Possible Solutions |
| ------------- | ------------------ |
| "Decrypting provisioning certificate failed"| Double check the password is correct on the certificate loaded into the "domains" on the UI | 
| "Exception reading from device"  | If MPS and RPS are running in Docker, check to ensure Vault has been unsealed. |
| "Unable to connect to Local Management Service (LMS). Please ensure LMS is running" | Check to ensure no application has bound to port 16992 |
| "Unable to launch MicroLMS." Check that Intel ME is present, MEI Driver installed and run this executable as administrator | Check to ensure no application has bound to port 16992 |
| "Device xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx activation failed. Error while adding the certificates to AMT."  | Unplug the device, from both network and power, let it sit for a while. If that doesn't work, file a github issue | 
| Device xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx activation failed. Missing DNS suffix. | Run `.\rpc amtinfo` and ensure there is a DNS suffix. If it is blank, double check your router settings for DHCP. Alternatively, you can override the DNS suffix with `-d mycompany.com`. To learn more, see [DNS Suffix](../Reference/MEBX/dnsSuffix.md) and [Create a Profile with ACM](../GetStarted/createProfileACM.md).| 
| Error: amt password DOES NOT match stored version for Device 6c4243ba-334d-11ea-94b5-caba2a773d00 | Ensure you have provided the `-password` flag for the `-cmd` you are trying to execute, and that it is the password you used when provisioning the device. |
| Unable to connect to websocket server. Please check url. | After ensuring you can reach your server. Ensure that the certificate common name on the server matches the FQDN/IP of your host address. |
| Error while activating the AMT in admin mode. | Check the logs on the RPS server. | 
| The rpc.exe fails to connect. | If a device has already been provisioned, [unprovision](../Reference/MEBX/unprovision.md) it and then reprovision. To deactivate and reactivate devices, see the Mircoservices section for RPC, [RPC Activate/Deactivate Examples](./RPC/commandsRPC.md) | 

# UI Toolkit
- If you encounter an error during the installation, verify the prerequisites and version numbers, such as Node.js* LTS, by consulting the tutorial [Add MPS UI Toolkit Controls to a WebUI](../Tutorials/uitoolkitReact.md). 
- If adding a control results in an error, double-check the device ID, mpsServer IP address value, and authToken.

# General Troubleshooting Tips

If a configuration becomes unworkable, it may be necessary to clean up the environment by:

- unprovisioning, also known as deactivating, the managed device
- stopping all Docker services

Do all the above if it becomes necessary to reset your environment completely. See instructions below.

1. **Unprovision the Managed Device:** Use rpc.exe to dectivate the managed device as described in [RPC Activate/Deactivate Examples](./RPC/commandsRPC.md#RPCexamples). The `deactivate` parameter executes a full unprovision of the managed device. It is also possible to implement a full unprovision via MEBX. See [Unprovisioning](../Reference/MEBX/unprovision.md).
2. **Shut down Docker Services:** Use `docker image prune` and `docker image rm` to stop or remove all images, containers, and volumes, as described in [Build and Run Docker Images](../GetStarted/setup.md#Builddockerimages).

The best practice example below stops Docker and then prunes all volumes. 

Example:

Stop Docker services.

=== "Linux"
     ```
     sudo docker-compose down -v
     ```
    
=== "Windows"
     ```
     docker-compose down -v
     ```

Prune the volumes.

=== "Linux"
     ```
     sudo docker system prune -a --volumes
     ```

=== "Windows"
     ```
     docker system prune -a --volumes
     ```




