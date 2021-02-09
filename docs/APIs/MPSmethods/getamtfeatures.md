# GetAMTFeatures

This AMT method returns the enabled/disabled settings for AMT out-of-band features. 

Click [here](types.md) for supported input and output types.

!!! note
	More information on obtaining an AMT device's GUID can be found [here](../../Topics/guids.md).

* Endpoint: */amt*
* Method Type: POST
* Headers: *X-MPS-API-Key*
* Body:

``` json
{  
   "method":"GetAMTFeatures",
   "payload":{  
      "guid":"038d0240-045c-05f4-7706-980700080009" //Replace with an AMT Device's GUID
   }
}
```

Example Outputs:

!!! success
    ``` json
    '200':
      {
          "ResponseBody":{
              "userConsent": "all",
              "redirection": true,
              "KVM": true,
              "SOL": false,
              "IDER": false
          }
      }
    ```

Return to [MPS Methods](../indexMPS.md)