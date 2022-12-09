--8<-- "References/abbreviations.md"
To prepare for a production environment, replace the PostgreSQL* database with that of another provider. 

To replace the database, update these services:

- MPS
- RPS 

## What You'll Do
This guide focuses on updating the RPS with an MS SQL Server (MSSQL) relational database. 

Here are the main tasks:

- Review DB Schema
- Add DB Client Dependency
- Update Configuration
- Implement the Code

!!! warning "Database Recipe"
    The example implementation below provides a step-by-step outline of database deployment. However, it is intended as a general guideline. You will need to write specific source code to support your custom solution. 

## Review DB Schema
The diagrams below illustrates the database schema and relationships. 

### RPS
  ```mermaid
  erDiagram
      DOMAIN {
          string name
          string domain_suffix
          string provisioning_cert
          string provisioning_cert_storage_format
          string provisioning_cert_key
          datetime creation_date
          string created_by
          string tenant_id
      }
  ```
  ``` mermaid 
  erDiagram
      PROFILE o|--o| CIRACONFIG : has
      PROFILE ||--|{ PROFILES_WIRELESSCONFIGS : associated
      PROFILE {
        string profile_name
        string activation
        string amt_password
        string cira_config_name
        datetime creation_date
        string created_by
        string mebx_password
        string tags
        boolean dhcp_enabled
        string tenant_id
      }
      CIRACONFIG 
      CIRACONFIG {
        string cira_config_name
        string mps_server_address
        int mps_port
        string user_name
        string password
        string generate_random_password
        string random_password_length
        string common_name
        int server_address_format
        int auth_method
        string mps_root_certificate
        string proxydetails
        string tenant_id
      }

      WIRELESSCONFIGS ||--|{ PROFILES_WIRELESSCONFIGS : belongs
      WIRELESSCONFIGS {
        string wireless_profile_name 
        integer authentication_method 
        integer encryption_method 
        string ssid 
        int psk_value 
        string psk_passphrase 
        int link_policy 
        datetime creation_date 
        string created_by 
        string tenant_id 
      }
      PROFILES_WIRELESSCONFIGS {
        string wireless_profile_name
        string profile_name
        datetime creation_date
        string created_by
        string tenant_id
      }
  ```
### MPS
  ```mermaid
  erDiagram
      DEVICE {
          guid uuid
          string tags
          string hostname
          string mpsinstance
          boolean connectionstatus
          string mpsusername
          string tenantid
          string friendlyname
          string dnssuffix
      }
  ```

## Add DB Client
Add the database client library you will use to connect to your database. To support MSSQL, this example uses the Microsoft SQL Server client* for Node.js, [`node-mssql`](https://www.npmjs.com/package/mssql).

**To add the database:**

Open a Terminal or Command Prompt and navigate to a directory of your choice for development:

```
npm install node-mssql --save
```

## Update Configuration

Update the connection string and a folder name for your db either in your ENV or .rc file.

**To modify the configuration:**

``` json
"db_provider":"mssql", //This will be the name of the folder you create in the next section.
"connection_string":"Server=localhost,1433;Database=database;User Id=username;Password=password;Encrypt=true'",
```

## Implement the Code

**To support the new database:**

1. Create a new folder in `./src/data`. The name of the new folder should be the name you supplied for the `db_provider` property, which is `mssql` in the example above.

     <figure class="figure-image">
     <img src="..\..\assets\images\DbFolder.png" alt="Figure 2: New folder mssql" style="width:224px">
     <figcaption>Figure 2: New folder mssql</figcaption>
     </figure>



2. Create a file called `index.ts` that implements our IDB interface. Below is an example interface and query method:

     **Interface**

     ``` typescript
     export interface IDB {
       ciraConfigs: ICiraConfigTable
       domains: IDomainsTable
       profiles: IProfilesTable
       wirelessProfiles: IWirelessProfilesTable
       profileWirelessConfigs: IProfilesWifiConfigsTable
       query: (text: string, params?: any) => Promise<any>
     }
     ```

     **Query Method**

     This query function is responsible for taking in the query parameters and performing the execution.

     ``` typescript
     async query <T>(text: string, params?: any): Promise<mssql.IResult<T>> {
        let result
        const start = Date.now()
        return await new Promise((resolve, reject) => {
          this.sqlPool.connect(async (err) => {
            if (err) {
              this.log.error(err)
              reject(err)
            }
            result = await this.sqlPool.request().query(text)
            const duration = Date.now() - start
            this.log.verbose(`executed query: ${JSON.stringify({ text, duration, rows: result.recordset.length })}`)
            resolve(result)
            })
        })
     }
     ```

3. Implement each of the table interfaces. The base interface looks like this: 
    ``` typescript
    export interface ITable<T> {
      getCount: (tenantId?: string) => Promise<number>
      get: (limit: number, offset: number, tenantId?: string) => Promise<T[]>
      getByName: (name: string, tenantId?: string) => Promise<T>
      delete: (name: string, tenantId?: string) => Promise<boolean>
      insert: (item: T) => Promise<T>
      update: (item: T) => Promise<T>
    }
    ```
    There are interfaces for each table in the `./interfaces/database` which adds specific functions on top of the base `ITable<>` interface.
    
    Here's an example of the get implementation for Domains:

    ``` typescript
    /**
     * @description Get all Domains from DB
     * @param {number} top
     * @param {number} skip
     * @returns {AMTDomain[]} returns an array of AMT Domain objects from DB
     */
    async get (top: number = DEFAULT_TOP, skip: number = DEFAULT_SKIP, tenantId: string = ''): Promise<AMTDomain[]> {
       const results = await this.db.query(`
       SELECT name as  profileName, domain_suffix as  domainSuffix, provisioning_cert as  provisioningCert, provisioning_cert_storage_format as  provisioningCertStorageFormat, provisioning_cert_key as  provisioningCertPassword, tenant_id tenantId
       FROM domains 
      ORDER BY name`)
      return result
     }

    ```

  4. Complete all the queries for each table's functions to finish the implementation.

!!! tip "Best Practice"
    That's it! Deployment complete.

    After replacing the database, ensure all the APIs are working as expected by running the API Tests with the Postman* application. You'll find the tests in the `./src/test/collections` folder.
