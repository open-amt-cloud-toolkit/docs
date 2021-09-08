--8<-- "References/abbreviations.md"
#Express Setup

This setup installs the MPS and RPS microservices as Docker* containers, standardized packages containing an application's source code, libraries, environment, and dependencies. 

## Get the Toolkit

**To clone the repositories:**

1. Open a Terminal or Command Prompt and navigate to a directory of your choice for development:

    ``` bash
    git clone --recursive https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit --branch v{{ baseClone.version }}
    ```
  
2. Change to the cloned `open-amt-cloud-toolkit` directory.
    ``` bash
    cd open-amt-cloud-toolkit
    ```

## Set Environment Variables  

The  `.env.template` file is used by docker to set environment variables.

**To set the environment variables:**

1. Copy the `.env.template` file to `.env`:

    === "Linux/Powershell"
        ```
        cp .env.template .env
        ```
    
    === "Windows (Cmd Prompt)"
        ```
        copy .env.template .env
        ```

2. In a text editor or IDE of choice, open the new `.env` file to edit.

3. Update the following fields for configuring the MPS and Sample Web UI. Save and keep track of the values you choose.

    | Field Name | Required | Usage |
    | -------------          | ------------------ | ------------ |
    | MPS_COMMON_NAME        | Development System IP Address. | For connecting to MPS server via UI or APIs. **WARNING: Do not use localhost. Use the development system IP Address.**|
    | MPS_WEB_ADMIN_USER     | Username of your choice            | For logging into the Sample Web UI |
    | MPS_WEB_ADMIN_PASSWORD | **Strong** password of your choice | For logging into the Sample Web UI |
    | MPS_JWT_SECRET         | A strong secret of your choice (Example: A unique, random 256bit string. See another example in [code snippet below](./#set-kong-json-web-token-jwt)).    | Used when generating a JSON Web Token for authentication. This example implementation uses a symmetrical key and HS256 to create the signature. [Learn more about JWT](https://jwt.io/introduction){target=_blank}.|
    
    !!! important "Important - Using Strong Passwords"
        The MPS_WEB_ADMIN_PASSWORD must meet standard, **strong** password requirements:

        - 8 to 32 characters

        - One uppercase, one lowercase, one numerical digit, one special character
        - 
<!-- Will re-add for 2.0
4. Update the fields for connecting to the Postgres database.

    | Field Name              | Required                                                                                         | Usage |
    | -------------           | ------------------                                                                               | ------------ |
    | POSTGRES_PASSWORD       | Password of your choice. Common **strong** password practices are recommended.                   | The database password |
    | MPS_CONNECTION_STRING   | Replace with: `postgresql://postgresadmin:[POSTGRES_PASSWORD]@db:5432/mpsdb?sslmode=no-verify`    | The database connection string for MPS | 
    | RPS_CONNECTION_STRING   | Replace with: `postgresql://postgresadmin:[POSTGRES_PASSWORD]@db:5432/rpsdb?sslmode=no-verify`    | The database connection string for RPS | 

    !!! important "Important - Use Same Value for all 3 Fields"
        The password selected for `MPS_CONNECTION_STRING`,  `RPS_CONNECTION_STRING`, and `POSTGRES_PASSWORD` must all be the same. **Replace [POSTGRES_PASSWORD]** found in `MPS_CONNECTION_STRING` and `RPS_CONNECTION_STRING` with the password selected for `POSTGRES_PASSWORD`.
-->

4. Update the fields for setting up Vault.

    | Field Name        | Required                                                   | Usage |
    | -------------     | ------------------                                         | ------------ |
    | RPS_VAULT_TOKEN   | String value of your choice. **Must match `MPS_VAULT_TOKEN`**. | Root Token for accessing Vault. |
    | MPS_VAULT_TOKEN   | String value of your choice. **Must match `RPS_VAULT_TOKEN`**. | Root Token for accessing Vault. | 


5. Save the file.

## Set Kong JSON Web Token (JWT)

Set the shared secret used in Kong for JWT authentication.

1. Open the `kong.yaml` file.

2. Update the *secret* field with your MPS_JWT_SECRET.

    ``` yaml hl_lines="4"
    jwt_secrets:
      - consumer: admin
        key: 9EmRJTbIiIb4bIeSsmgcWIjrR6HyETqc #sample key
        secret: "Yq3t6w9z$C&E)H@McQfTjWnZr4u7x!A%" #sample secret, DO NOT use for production
    ```

3. Save and close the file.


## <a name="Builddockerimages"></a>Build and Run the Docker Images

Build the MPS, RPS, and Sample Web UI Docker images and launch the stack.


1.  Run docker-compose to start the containers from the `./open-amt-cloud-toolkit` directory.
    
    === "Linux"
        ```
        sudo docker-compose -f "docker-compose.yml" up -d --build
        ```
    
    === "Windows"
        ```
        docker-compose -f "docker-compose.yml" up -d --build
        ```
    
    !!! important "Important - For Windows* 10"
        While the `docker-compose up` command is running, you may see a number of pop-ups asking for permission for Docker Desktop Filesharing. You must select **Share It** for the `docker-compose up` command to execute successfully.  If the pop-up expires,`docker-compose up` will fail.  You must run `docker-compose down -v` and then rerun `docker-compose up` to successfully start the containers.

        ![Image of filesharing](../assets/images/DockerFileSharing.png)


2. Check that all of the containers are running.

    
    === "Linux"
        ```
        {% raw %}
        sudo docker ps --format "table {{.Image}}\t{{.Status}}\t{{.Names}}"
        {% endraw %}
        ```
    
    === "Windows"
        ```
        {% raw %}
        docker ps --format "table {{.Image}}\t{{.Status}}\t{{.Names}}"
        {% endraw %}
        ```
    
    !!! success
        ``` bash    
        IMAGE               STATUS                             NAMES
        postgres            Up 18 seconds                      open-amt-cloud-toolkit_db_1
        kong:2.3            Up 17 seconds (health: starting)   open-amt-cloud-toolkit_kong_1
        eclipse-mosquitto   Up 20 seconds                      open-amt-cloud-toolkit_mosquitto_1
        webui:latest        Up 23 seconds                      open-amt-cloud-toolkit_webui_1
        rps:latest          Up 24 seconds                      open-amt-cloud-toolkit_rps_1
        vault               Up 21 seconds                      open-amt-cloud-toolkit_vault_1
        mpsrouter:latest    Up 23 seconds                      open-amt-cloud-toolkit_mpsrouter_1
        mps:latest          Up 22 seconds                      open-amt-cloud-toolkit_mps_1
        ```
    
If any of the above containers are not running, walk through the steps again or file a GitHub issue [here]( https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues).

!!! important
    Because the vault is running in a dev mode, stored secrets will be lost upon a restart, and profiles and configs must be recreated. They are not persistent in this mode. Be sure to run `docker-compose down -v` when bringing down the stack, which removes the volumes, and start fresh upon `docker-compose up`.  To run vault in production mode, follow the guide [here](./dockerLocal_prodVault.md).

    

## Next up
[**Login to Sample Web UI**](../General/loginToRPS.md)
