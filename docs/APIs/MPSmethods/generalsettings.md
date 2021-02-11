# GeneralSettings

This AMT method returns the general network settings for the specified guid.

Click [here](types.md) for supported input and output types.

!!! note
	More information on obtaining an AMT device's GUID can be found [here](../../Topics/guids.md).

* Endpoint: */amt*
* Method Type: POST
* Headers: *X-MPS-API-Key*
* Body:

``` json
{  
   "method":"GeneralSettings",
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
	      "ResponseBody":
			{
				"amtNetworkEnabled": 1,
				"ddnsPeriodicUpdateInterval": 1440,
				"ddnsTTL": 900,
				"ddnsUpdateByDHCPServerEnabled": true,
				"ddnsUpdateEnabled": false,
				"dhcpv6ConfigurationTimeout": 0,
				"digestRealm": "Digest:A4070000000000000000000000000000",
				"elementName": "Intel(r) AMT: General Settings",
				"hostName": "Madhavi",
				"hostOSFQDN": "DESKTOP-1A99FM4",
				"idleWakeTimeout": 65535,
				"instanceID": "Intel(r) AMT: General Settings",
				"networkInterfaceEnabled": true,
				"pingResponseEnabled": true,
				"powerSource": 0,
				"preferredAddressFamily": 0,
				"presenceNotificationInterval": 0,
				"privacyLevel": 0,
				"rmcpPingResponseEnabled": true,
				"sharedFQDN": true,
				"wsmanOnlyMode": false
			}
		}
	```

Return to [MPS Methods](../indexMPS.md)