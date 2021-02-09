# Disconnect

Use this Admin method to disconnect a CIRA connection for a specified guid.

Click [here](types.md) for supported input and output types.

!!! note
      More information on obtaining an AMT device's GUID can be found [here](../../Topics/guids.md).

* Endpoint: */admin*
* Method Type: POST
* Headers: *X-MPS-API-Key*
* Body:

``` json
{  
   "method":"Disconnect",
   "payload":{
      "guid": "038d0240-045c-05f4-7706-980700080009"
   }
}
```

Example Outputs:

!!! success
    ``` json
    {
        "success": 200,
        "description": "CIRA connection disconnected : 038d0240-045c-05f4-7706-980700080009"
    }
    ```

!!! failure
    ``` JSON
    {
        "status": 404,
        "error": "Device not found/connected. Please connect again using CIRA.",
        "errorDescription": "guid : 038d0240-045c-05f4-7706-980700080009"
    }
    ```

Return to [MPS Methods](../indexMPS.md)