
1. On your development system, browse to the web server in Chrome* using the development system's IP Address.
	
    ```
    http://[Development-IP-Address]:3001
    ```

2. Log in with the default credentials below.

    **Default credentials:**

    | Field       |  Value    |
    | :----------- | :-------------- |
    | **Username**| standalone |
    | **Password**| G@ppm0ym |

3. After logging in, click on Management Presence Server. If already logged in, click the Home icon in the top left corner.

    [![WebUI](../assets/images/WebUI_HomeMPS.png)](../assets/images/WebUI_HomeMPS.png)


4. Click the devices tab from the menu on the left, or click *Connected* in the default homepage.

    [![mps](../assets/images/MPS_ConnectedDevice.png)](../assets/images/MPS_ConnectedDevice.png)

    !!! troubleshooting
        If the activated device is not listed or if it is listed as unconnected, unplug and then plug back in the power of the AMT device. After succesfully restarting the device, refresh the WebUI to see if the *Status* changes to *Connected* and turns green.

5. Select the checkbox by the connected device you want to manage.

6. Select an action to perform from the options on the right.

    [![mps](../assets/images/MPS_ManageDevice.png)](../assets/images/MPS_ManageDevice.png)

    !!! note
        Since the device was activated in Client Control Mode(CCM), the KVM feature will    not function in this current release. To use KVM, follow the [ACM Activation   Tutorial](createProfileACM.md) to see how to configure a device into Admin Control    Mode.

    !!! note
        Activated in Admin Control Mode already? Try out the Keyboard, Video, Mouse (KVM)   feature to remotely view and control the AMT device.  Issue a Reset to BIOS command   and be able to view and make live changes to BIOS settings.

<br>

## Next steps

After successfully deploying the Open AMT Cloud Toolkit microservices and client, explore other tools and topics in the Open AMT Cloud Toolkit architecture:

### REST API Calls
Use the REST API tutorial to construct an Admin method API call to connected devices using node.js. Then modify the template to create other MPS REST API calls. 

[Get Started with REST API Calls](../Tutorials/apiTutorial.md){: .md-button .md-button--primary }

### UI Toolkit
Explore the Open AMT Cloud Toolkit reference implementation console by adding manageability features with prebuilt React components, such as Keyboard, Video, and Mouse (KVM).

[Get Started with the UI Toolkit](../Tutorials/uitoolkit.md){: .md-button .md-button--primary }

### Security
Learn how to use the Open AMT Cloud Toolkit architecture to secure assets. Topics include credentials, allowlisting, best known security methods, and more.

[Learn More about Security and Hardening](../Microservices/MPS/securityMPS.md){: .md-button .md-button--primary }

