--8<-- "References/abbreviations.md"
# Add MPS UI Toolkit Controls to a WebUI

The UI Toolkit allows developers to add manageability features to a console with prebuilt React components. The code snippets simplify the task of adding complex manageability UI controls, such as the Keyboard, Video, Mouse (KVM). A sample web application, based on React.js, is provided for test and development. 

The tutorial outlines how to add various controls to the sample React web application provided. Developers can use the sample code below as a springboard for developing their own consoles.

## What You'll Need

### Hardware

**Configure a network that includes:**

- A development system running Windows® 10 or Ubuntu* 18.04 or newer
- At least one Intel vPro® Platform to manage

### Software

- [MPS](https://github.com/open-amt-cloud-toolkit/MPS), the Management Presence Server
- [RPS](https://github.com/open-amt-cloud-toolkit/RCS), the Remote Provisioning Server
- Intel&reg; vPro device, configured and connected to MPS

!!! Note
    For instructions to setup the MPS and RPS servers to connect a managed device, see the [Get Started Guide](../Docker/overview.md)

- The **development system** requires the following software:
    - [git](https://git-scm.com/)
    - [Visual Studio Code](https://code.visualstudio.com/) or any other IDE
    - [Node.js* LTS 12.x.x or newer](https://nodejs.org/)
  

## What You'll Do
Follow the steps in these sections sequentially: 

- Create a new React app
- Add UI controls to the React app


[![UI Toolkit](../assets/images/HelloWorld.png)](../assets/images/HelloWorld.png)

## Create a New React App

The React app can be created in any preferred development directory. The MPS can continue to run while creating and running the app.

1. In a Terminal or Command Prompt, go to your preferred development directory. 

2. Run the following commands to create sample React app named `my-app`.

  ``` bash
  npx create-react-app my-app
  ```
3. Change to the my-app directory:
   ``` bash
   cd my-app
   ```
## Add UI Toolkit

1. Run the following command to add the UI Toolkit and install the required dependencies:

    ``` bash
    npm install @open-amt-cloud-toolkit/ui-toolkit@{{ uiClone.version }}
    ```

2. Run the following commands to start the web UI locally:

    ``` bash
    npm start
    ```

By default, React apps run on port `3000`. If port `3000` is already used by the MPS server or any other application, you'll be prompted to use another port. If this happens, enter 'Y'.

!!! success

    [![UI Toolkit start](../assets/images/UIToolkit_npmstart.png)](../assets/images/UIToolkit_npmstart.png)

    **Figure 2: React reports successful deployment.**

!!! Note "Note - Using Chromium Browser and Refreshing"
    By default, React launches in your machine's default browser. However for best experience, navigate to the page using a Chromium based web browser.
    When you make changes, you do not need to stop the application and restart. It will update and refresh automatically as you make code changes.


## Add a Sample Control
The following sections outline how to add controls. To use the code snippets provided, replace what is in the `App.js` file with the provided code snippet.

Refresh the web browser after adding a control if it does not update automatically after a few seconds.

### Add Keyboard, Video, Mouse (KVM) Redirection 

The code snippet below adds KVM control to the React application. 

1. Open `./my-app/src/App.js` in a text editor or IDE of choice, such as Visual Studio Code or Notepad.

2. Delete the current code and replace with the code snippet below.

3. Change the following values:

    | Field       |  Value   |
    | :----------- | :-------------- |
    | `deviceId` | **Replace the example deviceId** value with the GUID of the Intel® AMT device.  See [How to Find GUIDs in Intel® AMT](../Topics/guids.md). |
    | `mpsServer` | **Replace the localhost** with the IP Address or FQDN of your Development Device or MPS Server. When using KONG, `/mps/ws/relay` must be appeneded to the IP or FQDN. |
    | `authToken` | **Provide valid JWT.** See instructions on [Generating a JWT by using an Authorize API call](../apiTutorial/#generate-a-jwt){target=_blank}. |


    ``` javascript hl_lines="8 9 11"
    import React from "react";
    import "./App.css";
    import { KVM } from "@open-amt-cloud-toolkit/ui-toolkit/reactjs/KVM";

    function App() {
        return (
            <div className="App">
                <KVM deviceId="038d0240-045c-05f4-7706-980700080009" //Replace with AMT Device GUID
                mpsServer="https://localhost/mps/ws/relay" //Replace 'localhost' with Development System or MPS Server IP Address
                mouseDebounceTime="200"
                authToken="" // Replace with a valid JWT token from 'Authorize' API Method
                canvasHeight="100%"
                canvasWidth="100%"></KVM>
            </div>
        );
    }

    export default App;
    ```


4. Save and close the file.

5. If the React app hasn't updated automatically, refresh the page.


You are now able to remotely control your Intel® AMT device using Keyboard, Video, Mouse control.


You will see the errors in the following scenarios:

- Compilation errors if the ui-toolkit was not downloaded and installed to your react app.
- MPS/RPS server not running, appropriate controls will fail to work.
- MPS server running and device not connected.
- If your browser is IE/Edge, there might be compatibility issues.
- Incorrect or invalid JWT for authToken, see instructions on [Generating a JWT by using an Authorize API call](../apiTutorial/#generate-a-jwt){target=_blank}.
    
    !!! example "Example authToken Format"

        ```json
        {"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI5RW1SSlRiSWlJYjRiSWVTc21nY1dJanJSNkh5RVRxYyIsImV4cCI6MTYyMDE2OTg2NH0.GUib9sq0RWRLqJ7JpNNlj2AluuROLICCfdZaQzyWy90"}
        ```

<br>

## Next Steps

### Try Other Controls

Try out other React controls such as [Serial Over LAN](../UIToolkit/Controls/serialOverLANControl.md).

### Customize and Create Bundles

Try out creating and customizing React bundles for things such as Serial Over LAN or KVM [here](../UIToolkit/Bundles/kvm.md).


## License Note

If you are distributing the FortAwesome Icons, please provide attribution to the source per the [CC-by 4.0](https://creativecommons.org/licenses/by/4.0/deed.ast) license obligations.
