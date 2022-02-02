--8<-- "References/abbreviations.md"

1. Go back to the Sample Web UI on your development system.
	
2. Click the Devices tab from the menu on the left.
     <figure class="figure-image">
     <img src="..\..\assets\images\/MPS_ConnectedDevice.png" alt="Figure 1: Devices tab">
     <figcaption>Figure 1: Devices tab</figcaption>
     </figure>

    !!! troubleshooting
        If the activated device is not listed or if it is listed as unconnected, try restarting the AMT device. After successfully restarting the device, refresh the Sample Web UI to see if the *Status* changes to *connected*.

3. Click on your connected device.

4. Select an action to perform from the options in the top-right.

     <figure class="figure-image">
     <img src="..\..\assets\images\MPS_ManageDevice.png" alt="Figure 2: Action options">
     <figcaption>Figure 2: Action options</figcaption>
     </figure>

    !!! note
        If activated in Client Control Mode(CCM), the keyboard, video, mouse (KVM) and serial over LAN (SOL) features require entering a user consent code, which will be displayed on the device. To use KVM/SOL without user consent, follow the [ACM Activation Path](createProfileACM.md) for how to configure a device into Admin Control Mode.

    !!! warning
        Turn off active redirection sessions, such as KVM or SOL, before power state transitions. Power Cycle Reset and Unconditional Power Down (Power Off) will be rejected as invalid if there is an active redirection session. 
        
5. When performing a KVM action for a device activated in CCM or ACM with user consent enabled, input the user consent code displayed on the client device.

     <figure class="figure-image">
     <img src="..\..\assets\images\MPS_UserConsent.png" alt="Figure 2: User Consent">
     <figcaption>Figure 3: User Consent</figcaption>
     </figure>
  
<br>

## Next steps

After successfully deploying the Open AMT Cloud Toolkit microservices and client, explore other tools and topics in the Open AMT Cloud Toolkit architecture:

### REST API Calls
Learn how to send commands to AMT devices with the curl-based REST API tutorial. Generate a JWT token for Authorization and construct an API call to get a list of devices. 

[Get Started with REST API Calls](../Tutorials/apiTutorial.md){: .md-button .md-button--primary }

### UI Toolkit
Explore the Open AMT Cloud Toolkit reference implementation console by adding manageability features with prebuilt React components, such as Keyboard, Video, and Mouse (KVM).

[Get Started with the UI Toolkit](../Tutorials/uitoolkitReact.md){: .md-button .md-button--primary }

### Security
Learn how to use the Open AMT Cloud Toolkit architecture to secure assets. Topics include credentials, allowlisting, best known security methods, and more.

[Learn More about Security and Hardening](../Reference/MPS/securityMPS.md){: .md-button .md-button--primary }


