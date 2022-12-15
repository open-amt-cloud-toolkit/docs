
# Specific Changes Required for Version Upgrades

## Upgrade from 2.6 to 2.7

The 2.7 release of MPS requires an upgrade to the `mpsdb` database.

1. Run the following SQL script to add two new columns before upgrading the services:

    ``` sql
    ALTER TABLE devices 
    ADD COLUMN IF NOT EXISTS friendlyname varchar(256),
    ADD COLUMN IF NOT EXISTS dnssuffix varchar(256);
    ```

    ???+ example "Example - Adding Columns to PostgresDB using psql"
        This example walks through one potential option to update a Postgres Database using psql.

        1. Open a Command Prompt or Terminal.

        2. Connect to your Postgres instance and `mpsdb` database. Provide the hostname of the databse, the port (Postgres default is 5432), the database `mpsdb`, and your database user.
            ```
            psql -h [HOSTNAME] -p 5432 -d mpsdb -U [DATABASE USER]
            ```

            ??? example "Example Commands"
                ```
                Azure:
                psql -h myazuredb-sql.postgres.database.azure.com -p 5432 -d mpsdb -U postgresadmin@myazuredb-sql

                AWS:
                psql -h myawsdb-1.jotd7t2abapq.us-west-2.rds.amazonaws.com -p 5432 -d mpsdb -U postgresadmin
                ```

        3. Provide your Postgres user password.

        4. Run the SQL Statement.
            ``` sql
            ALTER TABLE devices 
            ADD COLUMN IF NOT EXISTS friendlyname varchar(256),
            ADD COLUMN IF NOT EXISTS dnssuffix varchar(256);
            ```

        5. Verify the columns were added to the table.
            ``` sql
            SELECT * FROM devices;
            ```

2. Continue with general upgrade steps below.


## Upgrade a Minor Version (i.e. 2.X to 2.Y)

Upgrading from a previous minor version to a new minor version release is simple using Helm. By updating your image tags and upgrading through Helm, a seamless transition can be made. Stored profiles and secrets will be unaffected and any connected devices will transition over to the new MPS pod.

??? note "Note - Using Private Images"
    The steps are the same if using your own images built and stored on a platform like Azure Container Registry (ACR) or Elastic Container Registry (ECR). Simply point to the new private images rather than the public Intel Dockerhub.

1. In the values.yaml file, update the images to the new version wanted. Alternatively, you can use the `latest` tags.

    !!! example "Example - values.yaml File"
        ```yaml hl_lines="2-5"
        images:
          mps: "intel/oact-mps:latest"
          rps: "intel/oact-rps:latest"
          webui: "intel/oact-webui:latest"
          mpsrouter: "intel/oact-mpsrouter:latest"
        mps:
          ...
        ```

2. In Terminal or Command Prompt, go to the deployed open-amt-cloud-toolkit repository directory.

    ```
    cd ./YOUR-DIRECTORY-PATH/open-amt-cloud-toolkit
    ```


3. Use Helm to upgrade and deploy the new images.

    ```
    helm upgrade openamtstack ./kubernetes/charts
    ```

    !!! success "Successful Helm Upgrade"
        ```
        Release "openamtstack" has been upgraded. Happy Helming!
        NAME: openamtstack
        LAST DEPLOYED: Wed Mar 23 09:36:10 2022
        NAMESPACE: default
        STATUS: deployed
        REVISION: 2
        ```

4. Verify the new pods are running. Notice the only restarted and recreated pods are MPS, RPS, and the WebUI.

    ```
    kubectl get pods
    ```

    !!! example "Example - Upgraded Running Pods"
        ```
        NAME                                                 READY   STATUS    RESTARTS   AGE
        mps-55f558666b-5m9bq                                 1/1     Running   0          2m47s
        mpsrouter-6975577696-wn8wm                           1/1     Running   0          27d
        openamtstack-kong-5999cc6b97-wbmdw                   2/2     Running   0          27d
        openamtstack-vault-0                                 1/1     Running   0          27d
        openamtstack-vault-agent-injector-6d6c75f7d5-sh5nm   1/1     Running   0          27d
        rps-597d7894b5-mbdz5                                 1/1     Running   0          2m47s
        webui-6d9b96c989-29r9z                               1/1     Running   0          2m47s
        ```

## Rollback a Version

Is the functionality not working as expected? Rollback to the previous deployment using Helm.

1. Use the Helm rollback command with the Revision you want to rollback to. In this example deployment, we would rollback to the original deployment revision which would be 1.

    ```
    helm rollback openamtstack [Revision-Number]
    ```
    
    !!! success - "Successful Rollback" 
        ```
        Rollback was a success! Happy Helming!
        ```

<!-- ## Upgrade LTS or Major Versions (i.e. 2.X to 3.Y) -->