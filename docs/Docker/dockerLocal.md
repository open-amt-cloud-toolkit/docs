--8<-- "References/abbreviations.md"
#Express Setup

This setup installs the MPS and RPS microservices as Docker* containers, standardized packages containing an application's source code, libraries, environment, and dependencies. 

## Get the Toolkit

**To clone the repositories:**

1. Open a Terminal or Powershell and navigate to a directory of your choice for development:

    ``` bash
    git clone --recursive https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit --branch v1.4.0
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

3. Update the following 4 fields. Save and keep track of the values you choose.

    | Field Name | Required | Usage |
    | ------------- | ------------------ | ------------ |
    | MPS_COMMON_NAME | Development System IP Address | For connecting to MPS server via UI or APIs |
    | MPS_WEB_ADMIN_USER | Username of your choice | For logging into the Sample Web UI |
    | MPS_WEB_ADMIN_PASSWORD | **Strong** password of your choice | For logging into the Sample Web UI |
    | MPS_JWT_SECRET | A strong secret of your choice | Used when generating a JSON Web Token for authentication |

    !!! important
        This password must meet standard, **strong** password requirements:

        - 8 to 32 characters

        - One uppercase, one lowercase, one numerical digit, one special character

4. Save and close the file.

## Set Kong JSON Web Token (JWT)

Set the shared secret used in Kong for JWT authentication.

1. Open the `kong.yaml` file.

2. Update the *secret* field with your MPS_JWT_SECRET.

    ``` yaml hl_lines="4"
    jwt_secrets:
      - consumer: admin
        key: 9EmRJTbIiIb4bIeSsmgcWIjrR6HyETqc #sample key
        secret: "mySecret"
    ```

3. Save and close the file.


## Build and Run the Docker Images

Build the MPS, RPS, and Sample Web UI Docker images and launch the stack.


1.  Run docker-compose to start the containers.
    
    === "Linux"
        ```
        sudo docker-compose -f "docker-compose.yml" up -d --build
        ```
    
    === "Windows (Powershell)"
        ```
        docker-compose -f "docker-compose.yml" up -d --build
        ```
    
    !!! important "Important - For Windows* 10"
        While the `docker-compose up` command is running, you may see a pop-up ask for permission for Docker Desktop Filesharing. You must select **Share It** for the `docker-compose up` command to execute successfully.  If the pop-up expires,`docker-compose up` will fail.  You must run `docker-compose down -v` and then rerun `docker-compose up` to successfully start the containers.

        ![Image of filesharing](../assets/images/DockerFileSharing.png)



2. Check that all of the containers are running.

    
    === "Linux"
        ```
        sudo docker ps --format "table {{.Image}}\t{{.Status}}\t{{.Names}}"
        ```
    
    === "Windows (Powershell)"
        ```
        docker ps --format "table {{.Image}}\t{{.Status}}\t{{.Names}}"
        ```
    
    !!! success
        ``` bash    
        IMAGE              STATUS                     NAMES
        webui:latest       Up 6 seconds               open-amt-cloud-toolkit_webui_1
        rps:latest         Up 6 seconds               open-amt-cloud-toolkit_rps_1
        vault              Up 6 seconds               open-amt-cloud-toolkit_vault_1
        mps:latest         Up 6 seconds               open-amt-cloud-toolkit_mps_1
        postgres           Up 6 seconds               open-amt-cloud-toolkit_db_1
        kong:2.3           Up 6 seconds (healthy)     open-amt-cloud-toolkit_kong_1
        ```
    
If any of the above containers are not running, walk through the steps again or file a github issue [here]( https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues).

!!! important
    Because the vault is running in a dev mode, stored secrets will be lost upon a restart, and profiles and configs must be recreated. They are not persistent in this mode. Be sure to run `docker-compose down -v` when bringing down the stack, which removes the volumes, and start fresh upon `docker-compose up`.  To run vault in production mode, follow the guide [here](./dockerLocal_prodVault.md).

## Next up
[**Login to Sample Web UI**](../General/loginToRPS.md)
