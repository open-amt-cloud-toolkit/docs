# API and Command Reference

This section is a reference to the RPS API methods available in the Open AMT Cloud Toolkit, and to some commands it provides.

RPS APIs allow you to get, create, and delete things such as CIRA Configs, Domains, and Profiles that are used in the remote configuration of Intel AMT devices.

RPS can be configured to run in two different modes, Developer and Production.

- In developer mode, all profiles and configurations are written to the file private/data.json.
- In production mode, all profiles and CIRA configurations are written to the database, and secrets are stored in Vault.


## How to Use the REST API

### Request URL

The request URL is assembled using your RPS server's IP Address, the port, the base path, and profile path with applicable parameters for the API you'd like to call.

#### Base Path

``` yaml
/api/v1/admin/
```

#### Profile Path

``` yaml
/ciraconfigs/
/domains/
/profiles/
```

!!! example
      Example URL for Profile Creation:
      ```
      https://localhost:8081/api/v1/admin/profiles/create
      ```
      Example URL for Domain Deletion:
      ```
      https://localhost:8081/api/v1/admin/domains/mydomain
      ```

## RPS API

The following APIs are available in RPS: 

| Method       |  Description/Usage |
   | :----------- | :------------------------ |   
   | **[CIRA Configuration](./RPSmethods/ciraconfig.md)** | Creating, Editing, Deleting, and Retrieving a CIRA Configuration |
   | **[Intel AMT Domains](./RPSmethods/domains.md)** | Creating, Editing, Deleting, and Retrieving an Intel&reg; AMT domain |
   | **[Intel AMT Profiles](./RPSmethods/profiles.md)** | Creating, Editing, Deleting, and Retrieving an Intel&reg; AMT profile |
   <!-- | **[Network Configuration](./RPSmethods/networkconfig.md)** | Creating, Editing, Deleting, and Retrieving a Network Configuration | -->



