# Intel AMT Domains

## Create A Domain

* Endpoint: */api/v1/admin/domains/create*
* Method Type: POST
* Headers: *X-RPS-API-Key*
* Payload:

```json
{
    "payload": 
    { 
        "Name":"[Domain-Name]",
        "DomainSuffix":"[Domain-Suffix]",
        "ProvisioningCert":"[Your_ProvisioningCert_Text]",
        "ProvisioningCertStorageFormat":"raw",
        "ProvisioningCertPassword":"[P@ssw0rd]"
    }
}
```

!!! example
    ```json
    {
        "payload": 
        { 
            "Name":"amtDomain",
            "DomainSuffix":"amtDomain.com",
            "ProvisioningCert":"[Your_ProvisioningCert_Text]",
            "ProvisioningCertStorageFormat":"raw",
            "ProvisioningCertPassword":"P@ssw0rd"
        }
    }
    ```

Example Outputs:

???+ success
    Domain amtDomain successfully inserted

???+ failure
    Duplicate Domain. Domain already exists.

## Get a Domain

* Endpoint: */api/v1/admin/domains/{domainName}*
* Method Type: GET
* Headers: *X-RPS-API-Key*
* Payload: Not required. The domain to get is provided in the URL as a query parameter.

Example Outputs:

???+ success
    ```json
    {
        "Name": "domain1",
        "DomainSuffix": "domain1.com",
        "ProvisioningCert": null,
        "ProvisioningCertStorageFormat": "string",
        "ProvisioningCertPassword": null
    }
    ```

???+ failure
    Domain domain12 not found

## Get ALL Domains

* Endpoint: */api/v1/admin/domains/*
* Method Type: GET
* Headers: *X-RPS-API-Key*
* Payload: Not required. No query parameter in URL retrieves all domains.

Example Outputs:

???+ success
    ```json
    [
        {
            "Name": "domain1",
            "DomainSuffix": "domain1.com",
            "ProvisioningCert": null,
            "ProvisioningCertStorageFormat": "string",
            "ProvisioningCertPassword": null
        }
    ]
    ```

???+ failure
    Domains not found

## Edit A Domain

* Endpoint: */api/v1/admin/domains/edit*
* Method Type: POST
* Headers: *X-RPS-API-Key*
* Payload: 

```json
{
    "payload": 
    { 
        "Name":"[Domain-Name]",
        "DomainSuffix":"[Domain-Suffix]",
        "ProvisioningCert":"[Your_ProvisioningCert_Text]",
        "ProvisioningCertStorageFormat":"raw",
        "ProvisioningCertPassword":"[P@ssw0rd]"
    }
}
```

!!! example
    ```json
    {
        "payload": 
        { 
            "Name":"amtDomain",
            "DomainSuffix":"amtDomain.com",
            "ProvisioningCert":"[Your_ProvisioningCert_Text]", 
            "ProvisioningCertStorageFormat":"raw",
            "ProvisioningCertPassword":"P@ssw0rd"
        }
    }
    ```

Example Outputs:

???+ success
    Domain amtDomain successfully updated

???+ failure
    Domain domain1 not found

# Delete a Domain

* Endpoint: */api/v1/admin/domains/{domainName}*
* Method Type: DELETE
* Headers: *X-RPS-API-Key*
* Payload: Not required. The domain to delete is provided in the URL as a query parameter.

Example Outputs:

???+ success
    Domain domain1 successfully deleted

???+ failure
    Domain not found.


Return to [RPS Methods](../indexRPS.md)