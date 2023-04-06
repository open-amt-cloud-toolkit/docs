--8<-- "References/abbreviations.md"

The sections below detail commonly asked questions about Open AMT Cloud toolkit as well as possible errors that may occur when activating or deactivating managed devices along with some potential solutions.

Can't find the answer to your questions or issue below? Reach out to the team [via Discord](https://discord.com/invite/yrcMp2kDWh) for direct help. Or file a GitHub issue.

## Commonly Asked Questions

**How do releases work with Open AMT?**

Open AMT carries two releases, the Rapid ("Monthly") Release and the Long-Term Support (LTS) Release. 

Rapid Releases occur every 4-6 weeks. Support for security and bug fixes is only for the duration of that rapid release. Customers will be encouraged to move to a latest rapid release for the most up to date security and bug fixes.

LTS Releases occur roughly every 1 to 1.5 years. Support for security and bug fixes exist until the next LTS version is available. At that point, we will provide migration documentation and support to help customers move over to the new LTS release.

<br>

**How does versioning work with Open AMT?**

Open AMT follows [SemVer](https://semver.org/) practices for versioning. This means:

- Major Version Increment - Breaking Changes (ex: 2.0.0 -> 3.0.0)
- Minor Version Increment - New Features (ex: 2.0.0 -> 2.1.0)
- Patch Version Increment - Security and Bug Fixes (ex: 2.0.0 -> 2.0.1)

All microservices with the same minor version should be compatible.

The separate repos for microservices and libraries are versioned individually. These versions are separate from the `open-amt-cloud-toolkit` repo version.  The `open-amt-cloud-toolkit` repo is where we have the monthly release. This repo might carry a higher version than some of the individual repos but is tagged as `{Month} {Year}`. All sub-repos referenced within `open-amt-cloud-toolkit` for a specific release are guaranteed to be compatible.

<br>

**What versions of Intel&reg; AMT are supported?**

Open AMT aligns to the Intel Network and Edge (NEX) Group support roadmap for Intel vPro&reg; Platform and Intel&reg; AMT devices. This is currently calculated as `Latest AMT Version - 7`.

<br>

**How do I migrate versions to a new release?**

Resources and information for migrating releases for either a Kubernetes deployment or local Docker deployment can be found in the [Upgrade Toolkit Version documentation](../Deployment/upgradeVersion.md).

<br>

**How do I find more information about the MPS and RPS configuration files and security details?**

Details and descriptions of configuration options can be found in [MPS Configuration](../MPS/configuration/) and [RPS Configuration](../RPS/configuration/).

Security information can be found in [MPS Security Information](../MPS/securityMPS/) and [RPS Security Information](../RPS/securityRPS/).

<br>


## Most Common Issues

???+ question "Why does an activated device show disconnected in MPS?"
    1. Are your login credentials stale? Try to log out of the Sample Web UI and back in.

    2. Is your Vault service initialized and unsealed? (Only applicable if using production mode Vault)

    3. Is your CIRA certificate correct? 
    
        You can verify this by going to https://[your-stack]:4433 and looking at the certificate.  The Issued party should match either your IP Address or FQDN.  If it is incorrect, delete your Profile and CIRA Config. Delete the existing MPS Certificate from Vault and restart the MPS service.  This will generate a new, correct certificate.  Then create new CIRA Config/Profile and run RPC to reconfigure the AMT device with the new profiles.

    4. Try to unplug the ethernet or power cable of the AMT device and replug. Wait 30 seconds and refresh the Sample Web UI to see if the device has connected. Alternatively, run `amtinfo` via RPC to see if the status has changed to Connected.

    5. Try updating the AMT device's BIOS/AMT version.

???+ question "Why can't I login to the Sample Web UI?"
    1. Have you accepted the certificate warning? If not, re-navigate to https://[your-stack] and accept the warning. 
    
    2. Is the Kong service running and healthy?

    3. For local deployment, does the Kong secret match in the `.env` and the `kong.yaml` files?

    4. For cloud deployment, is the Vault initialized and unsealed?  Vault will reseal itself if the pod is restarted and must be unsealed again. 

???+ question "Why does MPS or RPS show as Unhealthy"
    Both MPS and RPS have health API routes that they perform as part of startup for both Docker and Kubernetes. The health check verifies that the database and Vault are both available and reachable by the microservices. 
    
    If MPS or RPS return unhealthy, then one of the two, database or Vault, are unavailable.

???+ question "Why is there an 'Error Retrieving Device Stats' on Login?"
    This warning typically means that the Sample Web UI and MPS is unable to reach the MPS database.

    1. Is the MPS service healthy?

    2. For cloud deployment, is the Kubernetes secret for the MPS DB connection string correct?

    3. For cloud deployment, is the database reachable? Is the IP Address whitelisted and correct?

???+ question "Why do 'Profiles/CIRA Configs/Domains' tabs in the Sample Web UI return errors?"
    This warning typically means that the Sample Web UI and RPS is unable to reach the RPS database.

    1. Is the RPS service healthy?

    2. For cloud deployment, is the Kubernetes secret for the RPS DB connection string correct?

    3. For cloud deployment, is the database reachable? Is the IP Address whitelisted and correct?

## Specific Microservice or Library Errors

### RPC

More information about specific RPC error codes can be found in the [RPC Library Documentation](../RPC/libraryRPC/#rpc-error-code-charts).

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

### MPS

Additional logging details can be enabled by modifying the `log_level` field in the MPS configuration.

| Error Issue or Message | Possible Solutions |
| ------------- | ------------------ |
| Vault is empty in dev mode. | Profiles and configs are not persistent in this mode. To run vault in production mode, follow the [Use Docker and Vault in Production Mode](../Reference/productionVault.md).|
|MPS is missing from list of running services. | (1) Check for error messages in the logs. <br> (2) Verify that the `.env` file contains correct values in each field. <br> (3) Verify that the Kong secret provided in the `.env` matches the secret in `kong.yaml` |


### RPS

Additional logging details can be enabled by modifying the `log_level` field in the RPS configuration.

| Error Issue or Message | Possible Solutions |
| ------------- | ------------------ |
| Create a profile fails or information cannot be read from vault. | Make sure both Vault and Postgres are running. For details, see the `docker ps` command in [Build and Run Docker Images](../GetStarted/setup.md#Builddockerimages).|
| An error occurred during provisioning. | (1) Verify that the correct certificate is being used. <br> (2) Verify the Domain suffix. <br> (3) Verify RPS is able to reach the AMT device. Check firewalls and pings. |


### UI Toolkit
- If you encounter an error during the installation, verify the prerequisites and version numbers, such as Node.js* LTS, by consulting the tutorial [Add MPS UI Toolkit Controls to a WebUI](../Tutorials/uitoolkitReact.md). 
- If adding a control results in an error, double-check the device ID, mpsServer IP address value, and authToken.

## General Troubleshooting Tips

If a configuration becomes unworkable, it may be necessary to clean up the environment by:

- unprovisioning, also known as deactivating, the managed device
- stopping all Docker services

Do all the above if it becomes necessary to reset your environment completely. See instructions below.

1. **Unprovision the Managed Device:** Use rpc.exe to dectivate the managed device as described in [RPC Activate/Deactivate Examples](./RPC/commandsRPC.md#RPCexamples). The `deactivate` parameter executes a full unprovision of the managed device. It is also possible to implement a full unprovision via MEBX. See [Unprovisioning](../Reference/MEBX/unprovision.md).
2. **Shut down Docker Services:** Use `docker image prune` and `docker image rm` to stop or remove all images, containers, and volumes, as described in [Build and Run Docker Images](../GetStarted/setup.md#Builddockerimages).

The best practice example below stops Docker and then prunes all volumes. 

!!! example "Example - Cleanup of Docker Images"
    1. Stop Docker containers.

        ```
        docker-compose down -v
        ```

    2. Prune the images and volumes.

        ```
        docker system prune -a --volumes
        ```




