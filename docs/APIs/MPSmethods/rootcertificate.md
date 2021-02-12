# RootCertificate

This Admin method downloads the MPS Root Certificate.

Click [here](types.md) for supported input and output types.

* Endpoint: */admin*
* Method Type: POST
* Headers: *X-MPS-API-Key*
* Body:

``` json
{  
   "method":"MPSRootCertificate",
   "payload":{}
}
```

Example Outputs:

!!! success
    ```
    -----BEGIN CERTIFICATE-----
    Your MPS Root Certificate String
    -----END CERTIFICATE-----
    ```


Return to [MPS Methods](../indexMPS.md)