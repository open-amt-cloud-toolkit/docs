# Intel AMT Profiles

## Create a Profile


* Endpoint: */api/v1/admin/profiles/create*
* Method Type: POST
* Headers: *X-RPS-API-Key*
* Payload:

```json
{
    "payload": {
        "ProfileName": "[amt-profile-name]",
        "AMTPassword": "[strong-AMT-password]", //required if GenerateRandomPassword is false
        "MEBxPassword": "[strong-MEBx-password]", //required if GenerateRandomMEBxPassword is false
        "GenerateRandomMEBxPassword": [true/false],
        "RandomMEBxPasswordLength": null, //required if GenerateRandomMEBxPassword is true
        "GenerateRandomPassword": [true/false],
        "RandomPasswordLength": null, //required if GenerateRandomPassword is true
        "CIRAConfigName": "[CIRA-config-name]",
        "Activation": "[acmactivate/ccmactivate]",
        "NetworkConfigName": "[dhcp_enabled/dhcp_disabled]"
    }
}
```

!!! example
    ACM Profile using Static Passwords
    ``` json
    {
        "payload": {
            "profileName": "ACM-Static-profile",
            "amtPassword": "StrongP@ssw0rd",
            "mebxPassword": "StrongP@ssw0rd",
            "activation": "acmactivate",
            "ciraConfigName": "ciraconfig",
            "networkConfigName": "dhcp_enabled"
        }
    }
    ```

!!! example
    ACM Profile using Random Generated Passwords
    ``` json
    {
        "payload": {
            "profileName": "ACM-Random-profile",
            "generateRandomPassword": true,
            "passwordLength": 8,
            "generateRandomMEBxPassword": true,
            "mebxPasswordLength": 8,
            "activation": "acmactivate",
            "ciraConfigName": "ciraconfig",
            "networkConfigName": "dhcp_enabled"
        }
    }
    ```

!!! example
    CCM Profile using Random Generated Password
    ``` json
    {
        "payload": {
            "profileName": "CCM-Random-Profile",
            "generateRandomPassword": true,
            "passwordLength": 8,
            "activation": "ccmactivate",
            "ciraConfigName": "ciraconfig",
            "networkConfigName": "dhcp_enabled"
        }
    }
    ```

    !!! note
        An MEBx password is not required when activating into Client Control Mode.

Outputs:

???+ success
    Profile testProfile1 successfully inserted

???+ failure
    Profile insertion failed for testProfile1. Profile already exists. 

???+ failure 
    Referenced CIRA Config testconfig58 doesn't exist.

## Get a Profile

* Endpoint: */api/v1/admin/profiles/{profileName}*
* Method Type: GET
* Headers: *X-RPS-API-Key*
* Payload: Not required. The profile to get is provided in the URL as a query parameter.

Example Outputs:

???+ success
    ```json
    {
        "ProfileName": "ccm-Profile",
        "AMTPassword": null,
        "MEBxPassword": null,
        "GenerateRandomMEBxPassword": false,
        "RandomMEBxPasswordLength": null,
        "GenerateRandomPassword": true,
        "RandomPasswordLength": 8,
        "CIRAConfigName": "ciraconfig",
        "Activation": "ccmactivate",
        "NetworkConfigName": "dhcp_enabled"
    }
    ```
    
    !!! note
        The API will not return the AMTPassword or MEBxpassword. These must be retrieved from Vault or other storage.

???+ failure
    Profile testProfile1 not found

## Get All Profiles

* Endpoint: */api/v1/admin/profiles/*
* Method Type: GET
* Headers: *X-RPS-API-Key*
* Payload: Not required. No query parameter in URL retrieves all profiles.

???+ success
    ```json
    [
        {
            "ProfileName": "ccm-Profile",
            "AMTPassword": null,
            "MEBxPassword": null,
            "GenerateRandomMEBxPassword": false,
            "RandomMEBxPasswordLength": null,
            "GenerateRandomPassword": true,
            "RandomPasswordLength": 8,
            "CIRAConfigName": "ciraconfig",
            "Activation": "ccmactivate",
            "NetworkConfigName": "dhcp_enabled"
        }
    ]
    ```

???+ failure 
    No profiles found.


## Edit a Profile

* Endpoint: */api/v1/admin/profiles/edit*
* Method Type: POST
* Headers: *X-RPS-API-Key*
* Payload:

```json
{
    "payload": {
        "ProfileName": "[amt-profile-name]",
        "AMTPassword": "[strong-AMT-password]", //required if GenerateRandomPassword is false
        "MEBxPassword": "[strong-MEBx-password]", //required if GenerateRandomMEBxPassword is false
        "GenerateRandomMEBxPassword": [true/false],
        "RandomMEBxPasswordLength": null, //required if GenerateRandomMEBxPassword is true
        "GenerateRandomPassword": [true/false],
        "RandomPasswordLength": null, //required if GenerateRandomPassword is true
        "CIRAConfigName": "[CIRA-config-name]",
        "Activation": "[acmactivate/ccmactivate]",
        "NetworkConfigName": "[dhcp_enabled/dhcp_disabled]"
    }
}
```

!!! example
    ``` json
    {
        "payload": {
            "profileName": "testProfile1",
            "amtPassword": "StrongP@ssw0rd",
            "mebxPassword": "StrongP@ssw0rd",
            "activation": "acmactivate",
            "ciraConfigName": "ciraconfig",
            "networkConfigName": "dhcp_enabled"
        }
    }
    ```

???+ success
    Profile testProfile1 successfully updated.

???+ failure
    Referenced CIRA Config testconfig58 not found.

???+ failure
    Profile testProfile11 not found

## Delete a Profile

* Endpoint: */api/v1/admin/profiles/{profileName}*
* Method Type: DELETE
* Headers: *X-RPS-API-Key*
* Payload: Not required. The profile to delete is provided in the URL as a query parameter.

???+ success
    Profile testProfile1 successfully deleted

???+ failure
    Profile not found.

Return to [RPS Methods](../indexRPS.md)