
Not sure how to implement? View the [UI Toolkit KVM Module Tutorial](../../Tutorials/uitoolkit.md) for a step-by-step walkthrough on pre-requisites and implementing a React Control using the UI Toolkit.


## Add Serial Over LAN Control

The following code snippet shows how to add Serial Over LAN control to the React application.
Open `src/App.js`, add the following code as show below:

!!! note
    Change `deviceId` value to your device GUID `mpsServer` value to your MPS server address and appropriate port.

```javascript hl_lines="12 13"
import React from "react";
import { Sol } from "ui-toolkit";
import '../node_modules/ui-toolkit/i18n.ts'

const App = () => {
  return (
    <div>
        <Sol deviceId="038d0240-045c-05f4-7706-980700080009" //The AMT Device's GUID
        mpsServer="[MPS-Server-IP-Address]:3000"></Sol>
    </div>
  );
}

export default App;
```