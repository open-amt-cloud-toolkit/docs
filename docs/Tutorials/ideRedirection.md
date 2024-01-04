--8<-- "References/abbreviations.md"

IDE-Redirection (IDER) allows a trusted administrator to remotely mount disk images on an Intel AMT computer over the network. The device can then reboot using this image to perform computer recovery, OS re-installation, virus scanning and more.

## What You'll Need

**Hardware**

A minimum network configuration must include:

-  A Development system with Windows® 10 or Ubuntu 18.04 or newer
-  An Activated and Configured Intel® vPro device as the managed device

**Software on the Development System** 

- MPS and Sample Web UI
- An `.iso` File ([netboot.xyz](https://netboot.xyz/downloads/#x86_64-combined-legacy-and-uefi-ipxe-bootloaders) is used in this guide as a demonstration. Custom images can be used.)

    !!! Note
        For instructions to setup the MPS and RPS servers to connect a managed device, see the [Get Started Guide](../GetStarted/prerequisites.md)
  
## What You'll Do
The following sections describe how to:

- Start an IDER session
- Remote Mount an ISO
- Reimage the AMT Device


## Start an IDER Session

1. In the Sample Web UI, navigate to the Devices page.

2. Select the device to reimage.

3. Start a KVM session.

4. Click **Attach Disk Image (.iso)** button in the upper-right corner.

    <figure class="figure-image">
    <img src="..\..\assets\images\SampleUI_StartIDER.png" alt="Figure 1: Start IDER Session">
    <figcaption>Figure 1: Start IDER Session</figcaption>
    </figure>

## Remote Mount an ISO

1. Select the `.iso` file to mount to the AMT device.

    <figure class="figure-image">
    <img src="..\..\assets\images\SampleUI_IDER_ChooseFile.png" alt="Figure 2: Choose .iso File">
    <figcaption>Figure 2: Choose .iso File</figcaption>
    </figure>

2. After uploading the `.iso` file, MPS will start to transfer and mount the image to the AMT device. 

3. To verify the image was successfully mounted, view the available mounted drives on the AMT device. When the mount is listed, it is ready.

    <figure class="figure-image">
    <img src="..\..\assets\images\SampleUI_IDER_Drives.png" alt="Figure 3: View Mounted Drives">
    <figcaption>Figure 3: View Mounted Drives</figcaption>
    </figure>

## Reimage the Device

1. Reset the device to IDE-R (CD-ROM).

    <figure class="figure-image">
    <img src="..\..\assets\images\SampleUI_IDER_Reset.png" alt="Figure 4: Reset to IDE-R">
    <figcaption>Figure 4: Reset to IDE-R</figcaption>
    </figure>

2. After the device has finished POST, a menu or process will begin. This will vary based on the `.iso` file used. In this example, *netboot.xyz* is used and its menu can be seen.

    !!! success
        <figure class="figure-image">
        <img src="..\..\assets\images\SampleUI_IDER_netboot.png" alt="Figure 5: IDER Session">
        <figcaption>Figure 5: IDER Session</figcaption>
        </figure>

<br>

## Learn How to Integrate into a Custom UI

Explore how to add redirection features, such as Keyboard, Video, and Mouse (KVM) and IDE-Redirect (IDER), with prebuilt React components.

[Get Started with the UI Toolkit](../Tutorials/uitoolkitReact.md){: .md-button .md-button--primary }

<br>