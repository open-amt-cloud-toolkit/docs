--8<-- "References/abbreviations.md"

This tutorial demonstrates how to generate a JWT token for Authorization and construct a API call for [Getting Devices](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/1.3.0#/Devices/get_devices) using Node.js. This method will retrieve information about all devices, including device GUIDs.

[![ConnectedDevices](../assets/images/ConnectedDevicesAPI.png)](../assets/images/ConnectedDevicesAPI.png)

**Figure 1: API Call to Get All Devices**

!!! important
    Successfully deploy the Management Presence Server (MPS) and Remote Provisioning Server (RPS) and connect an Intel® vPro device to MPS before constructing the API call. Start [here](../Docker/overview.md)** to install microservices locally with Docker*.

Modify the tutorial template to implement other MPS REST APIs by changing these values:

- path
- method
- body (if POST method)

View all available MPS methods [here](../APIs/indexMPS.md).

## What You'll Need

**Hardware**

A minimum network configuration must include:

-  A Development system with Windows® 10 or Ubuntu 18.04 or newer
-  An Activated and Configured Intel® vPro device as the managed device

**Software on the Development System** 

- MPS
- RPS
- [Node.js LTS 12.x.x or newer](https://nodejs.org/)
- [Visual Studio Code](https://code.visualstudio.com/) or any other IDE
    
  
## What You'll Do
The following sections describe how to:

- Generate a new JWT for Authorization
- Construct an API Call to MPS for Devices
- View Device GUIDs

## Generate a JWT

### Create a New File

1. Navigate to a file directory of your choice.
2. Create and open a new JavaScript* file with a name of your choice. In this guide, we will refer to it as *generateJWT.js*.
3. Copy and paste the example code below.

    !!! example
        Example generateJWT.js file:

        ```javascript
        const https = require('https')
        process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = 0 //For testing withself-signed certs, remove for production
        let data = JSON.stringify({
            'username': 'standalone',
            'password': 'G@ppm0ym'
        })

        const options = {
            hostname: 'localhost',
            path: '/mps/login/api/v1/authorize',
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        }

        const req = https.request(options, (res) => {
            res.setEncoding('utf8')
            res.on('data', d => {
                console.log(d)
            })
        })

        req.on('error', (e) => {
            console.error(error)
        })

        // Write data to request body
        req.write(data)
        req.end()
        ```

### Execute the REST API

1. Open a Terminal or Command Prompt to execute the call.
2. Navigate to the directory you saved the generateJWT.js file.
3. Run the code snippet using node.

    ```
    node generateJWT.js
    ```

    !!! example
        Example Response:

        ```json
        {"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI5RW1SSlRiSWlJYjRiSWVTc21nY1dJanJSNkh5RVRxYyIsImV4cCI6MTYyMDE2OTg2NH0.GUib9sq0RWRLqJ7JpNNlj2AluuROLICCfdZaQzyWy90"}
        ```

## Construct API Call for Devices

1. Create and open a new JavaScript* file with a name of your choice. In this guide we will refer to it as *myDevices.js*.
2. Copy and paste the example code below.
3. Replace [Your-JWT-Token] with the JWT you generated from the Authorize API Call.

    !!! example
        Example myDevices.js file:

        ```javascript hl_lines="9"
            const https = require('https')
            process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = 0 //For testing with self-signed certs, remove for production
            
            const options = {
                hostname: 'localhost',
                path: '/mps/api/v1/devices',
                method: 'GET',
                headers: {
                    'Authorization': 'Bearer [Your-JWT-Token]' //Replace [Your-JWT-Token] with your generated JWT Token
                }
            }
            
            const req = https.request(options, (res) => {
                res.setEncoding('utf8')
                res.on('data', d => {
                    console.log(d)
                })
            })
            
            req.on('error', (e) => {
                console.error(error)
            })
            
            req.end()

        ```

4. Run the code snippet using node.

    ```
    node myDevices.js
    ```

    !!! important
        This is one way to retrieve a device's GUID in the *host* field.  **For *amt* path methods (i.e. Power Actions, Audit Logs, etc), the device GUID is *required* as part of the GET path.** Save this value if you want to try other MPS methods. Other ways to retrieve a GUID can be found [here](../Topics/guids.md).


    !!! example
        Example Terminal Output:

        ```json
        [{"connectionStatus":1,"hostname":"DESKTOP-R2225SQ",    "guid":"d92b3be1-b04f-49de-b806-54b203054e9d","metadata":   {"guid":"d92b3be1-b04f-49de-b806-54b203054e9d","hostname":"DESKTOP-R2225SQ","tags":    []}}]
        ```
        Example JSON Pretty Print:

        ```json
        [
            {
                "connectionStatus": 1,
                "hostname": "DESKTOP-R2225SQ",
                "guid": "d92b3be1-b04f-49de-b806-54b203054e9d",
                "metadata": {
                    "guid": "d92b3be1-b04f-49de-b806-54b203054e9d",
                    "hostname": "DESKTOP-R2225SQ",
                    "tags": []
                }
            }
        ]
        ```

## Other Methods

The sample Node code snippet can be adapted for other MPS and RPS methods. To learn more, see: 

- [MPS Methods to manage a device](../APIs/indexMPS.md).
- [RPS Methods for server configuration and provisioning](../APIs/indexRPS.md).

## Explore the UI Toolkit
In addition to REST API calls, the Open AMT Cloud Toolkit provides a reference implementation console. Add manageability features to the console with prebuilt React components, such as Keyboard, Video, and Mouse (KVM).

[Get Started with the UI Toolkit](../Tutorials/uitoolkit.md){: .md-button .md-button--primary }
