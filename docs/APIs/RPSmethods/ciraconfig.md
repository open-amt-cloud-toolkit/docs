# CIRA Configurations


## Create a CIRA Configuration

* Endpoint: */api/v1/admin/ciraconfigs/*
* Method Type: POST
* Headers: *X-RPS-API-Key*
* Payload:

proxyDetails is an optional field. 

```json
{
    	"payload": {
    		"configName": "[CIRA-Config-Name]",
    		"mpsServerAddress": "localhost",
    		"mpsPort": 4433,
    		"username": "admin", //mps username
    		"password": "P@ssw0rd", //mps password
    		"commonName": "localhost",
    		"serverAddressFormat": 201,
    		"mpsRootCertificate": "",
    		"proxyDetails": "", 
    		"authMethod": 2
    	}
    }
```


!!! example
    ```json
    {
    	"payload": {
    		"configName": "config1",
    		"mpsServerAddress": "localhost",
    		"mpsPort": 4433,
    		"username": "admin",
    		"password": "P@ssw0rd",
    		"commonName": "localhost",
    		"serverAddressFormat": 201,
    		"mpsRootCertificate": "",
    		"proxyDetails": "", 
    		"authMethod": 2
    	}
    }
    ```

Example Outputs:

???+ success
    CIRA Config config1 successfully inserted


???+ failure
    CIRA Config insertion failed for config1. CIRA Config already exists.


## Get a CIRA configuration

* Endpoint: */api/v1/admin/ciraconfigs/{ciraconfigName}*
* Method Type: GET
* Headers: *X-RPS-API-Key*
* Payload: Not required. The cira config to get is provided in the URL as a query parameter.


!!! success
    ```json
    {
        "ConfigName": "config1",
        "MPSServerAddress": "localhost",
        "MPSPort": 4433,
        "Username": "admin",
        "Password": null,
        "CommonName": "localhost",
        "ServerAddressFormat": 201,
        "AuthMethod": 2,
        "MPSRootCertificate": "",
        "ProxyDetails": ""
    }
    ```

!!! failure
    CIRA Config config2 not found

## Get all CIRA configurations

* Endpoint: */api/v1/admin/ciraconfigs/*
* Method Type: GET
* Headers: *X-RPS-API-Key*
* Payload: Not required. No query parameter in URL retrieves all profiles.

Example Outputs:

!!! success
    ```json
    [
        {
            "ConfigName": "config1",
            "MPSServerAddress": "13.64.233.163",
            "MPSPort": 4433,
            "Username": "admin",
            "Password": null,
            "CommonName": "13.64.233.163",
            "ServerAddressFormat": 201,
            "AuthMethod": 2,
            "MPSRootCertificate": "null",
            "ProxyDetails": "null"
        },
        {
            "ConfigName": "config2",
            "MPSServerAddress": "localhost",
            "MPSPort": 4433,
            "Username": "admin",
            "Password": null,
            "CommonName": "localhost",
            "ServerAddressFormat": 201,
            "AuthMethod": 2,
            "MPSRootCertificate": "",
            "ProxyDetails": ""
        }
    ]
    ```

!!! failure
    No CIRA configs found.

## Edit a CIRA Configuration

* Endpoint: */api/v1/admin/ciraconfigs/edit*
* Method Type: POST
* Headers: *X-RPS-API-Key*
* Payload: 

proxyDetails is an optional field.

```json
{
    	"payload": {
    		"configName": "[CIRA-Config-Name]",
    		"mpsServerAddress": "localhost",
    		"mpsPort": 4433,
    		"username": "admin", //mps username
    		"password": "P@ssw0rd", //mps password
    		"commonName": "localhost",
    		"serverAddressFormat": 201,
    		"mpsRootCertificate": "",
    		"proxyDetails": "", 
    		"authMethod": 2
    	}
    }
```

!!! example
    ```json
    {
    	"payload": {
    		"configName": "config1",
    		"mpsServerAddress": "localhost",
    		"mpsPort": 4434,
    		"username": "admin",
    		"password": "P@ssw0rd",
    		"commonName": "localhost",
    		"serverAddressFormat": 201,
    		"mpsRootCertificate": "",
    		"proxyDetails": "", 
    		"authMethod": 2
    	}
    }
    ```


Example Outputs:

???+ success
    CIRA Config config1 successfully inserted

???+ failure
    CIRA Config config11 not found

## Delete a CIRA configuration

* Endpoint: */api/v1/admin/ciraconfigs/{ciraconfigName}*
* Method Type: DELETE
* Headers: *X-RPS-API-Key*
* Payload: Not required. The cira config to delete is provided in the URL as a query parameter.

???+ success
    CIRA Config config1 successfully deleted


???+ failure
    Deletion failed for CIRA Config: config1. Profile associated with this Config. 


Return to [RPS Methods](../indexRPS.md)