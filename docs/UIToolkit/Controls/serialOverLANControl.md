
Not sure how to implement? View the [UI Toolkit KVM Module Tutorial](../../Tutorials/uitoolkit.md) for a step-by-step walkthrough on pre-requisites and implementing a React Control using the UI Toolkit.


## Add Serial Over LAN Control

The following code snippet shows how to add Serial Over LAN control to the React application.
Open `src/App.js`, add the following code as show below:

!!! note
    Change `deviceId` value to your device GUID, `mpsServer` value to your MPS server address, and pass in a valid JWT  for `authToken`.

``` javascript hl_lines="7 8 9"
import React from "react";
import { Sol } from "@open-amt-cloud-toolkit/ui-toolkit/reactjs/SerialOverLAN";

function App() {
  return (
    <div>
        <Sol deviceId="038d0240-045c-05f4-7706-980700080009"//Replace with AMT Device GUID
        mpsServer="https://localhost/mps/ws" //Replace 'localhost' with Development System or MPS Server IP Address
        authToken=""> // Replace with a valid JWT provided during login of MPS
        </Sol>
    </div>
  );
}
​
export default App;
```