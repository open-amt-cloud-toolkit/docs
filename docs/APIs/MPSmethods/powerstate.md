# PowerState

This AMT method retrieves the current state of the Intel&reg; AMT device, and returns a number that that maps to [PowerActions](poweraction.md) table.

Click [here](types.md) for supported input and output types.

!!! note
	More information on obtaining an AMT device's GUID can be found [here](../../Topics/guids.md).

* Endpoint: */amt*
* Method Type: POST
* Headers: *X-MPS-API-Key*
* Body:

``` json
{  
   "method":"PowerState",
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
			"powerState" : 2
		}
	```

Return to [MPS Methods](../indexMPS.md)