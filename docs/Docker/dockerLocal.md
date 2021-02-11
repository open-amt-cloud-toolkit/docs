# Build and Deploy Docker* Images for MPS and RPS Locally



The Open AMT Cloud Toolkit's [Management Presence Server (MPS)](../Glossary.md#m) and [Remote Provisioning Server (RPS)](../Glossary.md#r) provide support for deploying the microservices as [Docker*](../Glossary.md#d) images, standardized packages containing an application's source code, libraries, environment, and dependencies. 


## Why Docker*?

A Docker container is the instantiation of a Docker image as a virtualized unit that separates the application from the environment. Docker containers start and run reliably, securely, and portably inside different environments, eliminating some of the usual problems that occur with software deployment on varying platforms. 

Get more information about Docker images and containers at [Docker resources.](https://www.docker.com/resources/what-container)


## Clone OpenAMT Cloud Toolkit

**To clone the repositories:**

1. Open a Command Prompt or Terminal and navigate to a directory of your choice for development.

``` bash
git clone --recursive https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit --branch v1.1.0
```
  
## Set the Environment Variables  

**To set the environment variables:**

1. Create a copy the of the `.env.template` file to `.env`. This file is used by docker to set environment variables. 

    === "Linux/Powershell"
        ```
        cp .env.template .env
        ```
    
    === "Windows (cmd)"
        ```
        copy .env.template .env
        ```

2. Set `MPS_COMMON_NAME` to your development system's IP Address. You can use a text editor to modify the .env file or replace YOURIPADDRESS in the command below to use the command line:

    === "Linux"
        ``` bash
        sed -i "s|MPS_COMMON_NAME=localhost|MPS_COMMON_NAME=YOURIPADDRESS|g" .env
        ```
    === "Windows (Powershell)"
        ``` powershell
        (Get-Content -Path './.env') -replace 'MPS_COMMON_NAME=localhost', 'MPS_COMMON_NAME=YOURIPADDRESS' | Set-Content -Path './.env'
        ```


## Build and Run the Docker Images

The environment file (`.env`) now contains the MPS and RPS environment variables to pass to the Docker engine.

1.  Build the MPS, RPS, and Sample UI Docker images and launch the stack

    ``` bash    
    docker-compose -f "docker-compose.yml" up -d --build
    ```

    !!! important
        While the `docker-compose up` command is running, you may see a pop-up ask for permission for Docker Desktop Filesharing. You must select **Share It** for the `docker-compose up` command to execute successfully.  If the pop-up expires,`docker-compose up` will fail.  You must run `docker-compose down -v` and then rerun `docker-compose up` to successfully start the containers.

        ![Image of filesharing](../assets/images/DockerFileSharing.png)



2. To check all containers are up and running run the following command.

    ```bash
    `docker ps --format 'table{{.Image}}\t{{.Status}}\t{{.Names}}'`
    ```

    !!! success
        ``` bash    
        IMAGE                             STATUS
        samplewebui                       Up 6 seconds    open-amt-cloud-toolkit_webui_1
        rps-microservice:v1               Up 6 seconds    open-amt-cloud-toolkit_rps_1
        mps-microservice:v1               Up 6 seconds    open-amt-cloud-toolkit_mps_1
        vault                             Up 6 seconds    open-amt-cloud-toolkit_vault_1
        postgres                          Up 6 seconds    open-amt-cloud-toolkit_rpsdb_1
        ```
    
        !!! note
            On completion, a security warning is normal during local setup with the default values for developer testing environments.



!!! important
    Since the vault is running in a dev mode, you will not be able to restart the vault and maintain the secrets stored since they are not persisted. You will need to recreate profiles and configs again. Be sure and run `docker-compose down -v` when bringing down the stack so as to remove the volumes and start fresh upon `docker-compose up`.  You may follow the guide [here](./dockerLocal_prodVault.md) to run vault in production mode.

If any of the above containers report that it is not running. Try walking through the steps again, or filing a github issue [here]( https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues).

## Next up
[**Login to RPS**](../General/loginToRPS.md)
