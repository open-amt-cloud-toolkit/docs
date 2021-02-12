# SetAMTFeatures

Use this AMT method to enable or disable Intel&reg; AMT features such as KVM, SOL, and IDE-R.


!!! note
	More information on obtaining an AMT device's GUID can be found [here](../../Topics/guids.md).

* Endpoint: */amt*
* Method Type: POST
* Headers: *X-MPS-API-Key*
* Body:

``` json
{  
   "method":"SetAMTFeatures",
   "payload":{  
      "guid":"038d0240-045c-05f4-7706-980700080009", //Replace with an AMT Device's GUID
      "userConsent":"all",
      "enableSOL": false,
      "enableIDER": false,
      "enableKVM": true
   }
}
```

Example Outputs:

!!! success

    ``` json
    '200':
        {
          "ResponseBody":"Updated"
        }
    ```

Return to [MPS Methods](../indexMPS.md)