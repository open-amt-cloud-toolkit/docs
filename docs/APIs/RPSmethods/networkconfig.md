# Network Configuration

## Create a Network Configuration

* Endpoint: */api/v1/admin/networkconfigs/create*
* Method Type: POST
* Headers: *X-RPS-API-Key*
* Payload:

```json
{
	"payload" :  
    {
        "profileName": "[Network-Profile-Name]",
        "dhcpEnabled": [true/false]
    }
}
```

!!! example
    ```json
    {
    	"payload": {
    		"profileName": "profile1",
            "dhcpEnabled": "false"
    	}
    }
    ```

Example Outputs:

???+ success
    NETWORK Config profile1 successfully inserted

???+ failure
    NETWORK Config insertion failed for profile1. NETWORK Config already exists.

## Get a Network Configuration

* Endpoint: */api/v1/admin/networkconfigs/{networkconfigName}*
* Method Type: GET
* Headers: *X-RPS-API-Key*
* Payload: Not required. The network confid to get is provided in the URL as a query parameter.

Example Outputs:

???+ success 
    ```json
    {
        "ProfileName": "profile1",
        "DHCPEnabled": false,
        "StaticIPShared": true,
        "IPSyncEnabled": true
    }
    ```
???+ failure
    NETWORK Config testProfile1 not found

## Get All Network Configuration

* Endpoint: */api/v1/admin/networkconfigs/*
* Method Type: GET
* Headers: *X-RPS-API-Key*
* Payload: Not required. No query parameter in URL retrieves all network configs.

Example Outputs:

???+ success
    ```json
    [
        {
            "ProfileName": "profile1",
            "DHCPEnabled": false,
            "StaticIPShared": true,
            "IPSyncEnabled": true
        }
    ]
    ```

???+ failure
    No NETWORK Configs found.

## Edit a Network Configuration

* Endpoint: */api/v1/admin/networkconfigs/edit*
* Method Type: POST
* Headers: *X-RPS-API-Key*
* Payload:

```json
{
	"payload" :  
    {
        "profileName": "[Network-Profile-Name]",
        "dhcpEnabled": [true/false]
    }
}
```

!!! example

    ```json
    {
    	"payload": {
    		"profileName": "profile1",
            "dhcpEnabled": "true"
    	}
    }
    ```

???+ success
    UPDATE Successful for NETWORK Config: profile1

???+ failure
    NETWORK Config profile11 not found

## Delete a Network Configuration

* Endpoint: */api/v1/admin/networkconfigs/{networkconfigName}*
* Method Type: DELETE
* Headers: *X-RPS-API-Key*
* Payload: Not required. The network config to delete is provided in the URL as a query parameter.

Example Outputs:

???+ success
    NETWORK Config profile1 successfully deleted

???+ failure
    NETWORK Config profile11 not found


Return to [RPS Methods](../indexRPS.md)