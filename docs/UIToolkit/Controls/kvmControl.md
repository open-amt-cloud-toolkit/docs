--8<-- "References/abbreviations.md"
Not sure how to implement Keyboard, Video Mouse (KVM)? View the [UI Toolkit KVM Module Tutorial](../../Tutorials/uitoolkit.md) for a step-by-step walkthrough prerequisites and instructions for implementing a React Control using the UI Toolkit.

## Add KVM Control

Use the following code snippet to add the KVM control to the React Application.
Open `src/App.js` and add the code shown below:

!!! note
    Change `deviceId` value to your device GUID, `mpsServer` value to your MPS server address, and pass in a valid JWT  for `authToken`.

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
                authToken="" // Replace with a valid JWT provided during login of MPS
                canvasHeight="100%"
                canvasWidth="100%"></KVM>
            </div>
        );
    }

export default App;
```

## Adding mouse delay for KVM

If you are implementing the KVM control by just re-using the core logic and UI of your own, you can provide a configurable mouse delay while instantiating the MouseHelper object as shown below.

```
const redirector = new AMTKvmDataRedirector(...)
const module = new AMTDesktop()
const mouseDelay = 300 // setting a mouse delay time of 300ms
const mouseHelper = new MouseHelper(module, redirector, mouseDelay) // the mouseDelay parameter will be used for throttling mouse move events for kvm, the default value configured is 200ms
```

and while binding the mouse move events you can trigger the throttleMouseMove event of the MouseHelper class as shown below

```
const mouseMove = (mouseEvent) => {
  this.mouseHelper.throttleMouseMove(mouseEvent)
}
```

