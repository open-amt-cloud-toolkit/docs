
Not sure how to implement? View the [UI Toolkit KVM Module Tutorial](../../Tutorials/uitoolkit.md) for a step-by-step walkthrough on pre-requisites and implementing a React Control using the UI Toolkit.

## Add Keyboard, Video, Mouse (KVM) Control

The following code snippet shows how to add KVM control to the React application.
Open `src/App.js`, add the following code as show below:

!!! note
    Change `deviceId` value to your device GUID `mpsServer` value to your MPS server address and appropriate port.

``` javascript hl_lines="13 14"
import React from "react";
import "./App.css";
import { KVM, MpsProvider } from "ui-toolkit";
import '../node_modules/ui-toolkit/i18n.ts';

function App() {
  const data = {
    mpsKey: '<MPS API key>'
  };
  return (
    <div className="App">
      <MpsProvider data={data}>
        <KVM deviceId="038d0240-045c-05f4-7706-980700080009" //The AMT Device's GUID
        mpsServer="[MPS-Server-IP-Address]:3000/relay"
        mouseDebounceTime="200"
        canvasHeight="100%"
        canvasWidth="100%"></KVM>
      </MpsProvider>
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

