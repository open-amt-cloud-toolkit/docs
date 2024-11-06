--8<-- "References/abbreviations.md"

Developed in Go* programming language, the Remote Provisioning Client (RPC) application runs on the managed device. RPC-Go activates and configures Intel® AMT on the managed device. Once properly configured, the device can be added to Console.

## Export Profiles

1. Export the created profiles to a `.yaml` file that can be given to RPC-Go for device activation and configuration.

2. Click the export button next to the profile.

    <figure class="figure-image">
        <img src="..\..\..\assets\images\Console_ExportProfile.png" alt="Figure 1: Export Button">
        <figcaption>Figure 1: Export Button</figcaption>
    </figure>

3. **Save the given Profile Key.** It is only given this once. This key is used by RPC-Go to decode the encrypted config file.

    <figure class="figure-image">
        <img src="..\..\..\assets\images\Console_ProfileKey.png" alt="Figure 2: Profile Key">
        <figcaption>Figure 2: Profile Key</figcaption>
    </figure>

4. Move the new, downloaded `.yaml` config file to the AMT device.

## Download RPC

On the AMT device, download the latest RPC-Go version from the [RPC-Go GitHub Repo Releases Page](https://github.com/open-amt-cloud-toolkit/rpc-go/releases) for the Operating System of the AMT device (Windows or Linux).

## Activate Device

1. On the AMT device, open a Terminal (Linux) or Powershell/Command Prompt **as Administrator** (Windows).

2. Navigate to the directory containing the RPC application.

3. Run RPC with the local **activate** command to activate and configure Intel® AMT.

    ```
    rpc activate -local -configv2 profileName.yaml -configencryptionkey w31W6548+eDZYziC97DnmkzaA4V4r4nC
    ```

4. After finishing successfully, the device can now be added and connected to using Console. 

!!! success
    <figure class="figure-image">
        <img src="..\..\..\assets\images\Console_DeviceActivation.png" alt="Figure 3: Example Successful Activation and Configuration">
        <figcaption>Figure 3: Example Successful Activation and Configuration</figcaption>
    </figure>

## Next up

[**Add a Device**](addDevice.md)