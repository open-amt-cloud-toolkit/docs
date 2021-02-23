 
The Open Active Management Technology (Open AMT) Cloud Toolkit's [Management Presence Server (MPS)](../Glossary.md#m) and [Remote Provisioning Server (RPS)](../Glossary.md#r) provide support for deploying the microservices as [Docker*](../Glossary.md#d) images, standardized packages containing an application's source code, libraries, environment, and dependencies. 


## Why Docker*?

A Docker container is the instantiation of a Docker image as a virtualized unit that separates the application from the environment. Docker containers start and run reliably, securely, and portably inside different environments, eliminating some of the problems that occur with software deployment on varying platforms. 

Get more information about Docker images and containers at [Docker resources.](https://www.docker.com/resources/what-container)


## Get the Toolkit

**To clone the repositories:**

1. Open a Command Prompt or Terminal and navigate to a directory of your choice for development:

``` bash
git clone --recursive https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit --branch v1.1.0
```
  
## Set Environment Variables  

The  `.env.template` file is used by docker to set environment variables.

**To set the environment variables:**

1.\ Copy the `.env.template` file to `.env`:

    === "Linux/Powershell"
        ```
        cp .env.template .env
        ```
    
    === "Windows (cmd)"
        ```
        copy .env.template .env
        ```

2.\ Set `MPS_COMMON_NAME` to your development system's IP Address. Use a text editor to modify the `.env` file or replace YOURIPADDRESS in the command below to use the command line:

    === "Linux"
        ``` bash
        sed -i "s|MPS_COMMON_NAME=localhost|MPS_COMMON_NAME=YOURIPADDRESS|g" .env
        ```
    === "Windows (Powershell)"
        ``` powershell
        (Get-Content -Path './.env') -replace 'MPS_COMMON_NAME=localhost', 'MPS_COMMON_NAME=YOURIPADDRESS' | Set-Content -Path './.env'
        ```


## Build and Run the Docker Images

Build the MPS, RPS, and Sample UI Docker images and launch the stack.

**To build:**

1.  Use docker-compose:

    ``` bash    
    docker-compose -f "docker-compose.yml" up -d --build
    ```

    !!! important
        While the `docker-compose up` command is running, you may see a pop-up ask for permission for Docker Desktop Filesharing. You must select **Share It** for the `docker-compose up` command to execute successfully.  If the pop-up expires,`docker-compose up` will fail.  You must run `docker-compose down -v` and then rerun `docker-compose up` to successfully start the containers.

        ![Image of filesharing](../assets/images/DockerFileSharing.png)



2. Check that all containers are running:

    ```bash
    docker ps --format table{{.Image}}\t{{.Status}}\t{{.Names}}
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

If any of the above containers are not running, walk through the steps again or file a github issue [here]( https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues).

!!! important
    Because the vault is running in a dev mode, stored secrets will be lost upon a restart, and profiles and configs must be recreated. They are not persistent in this mode. Be sure to run `docker-compose down -v` when bringing down the stack, which removes the volumes, and start fresh upon `docker-compose up`.  To run vault in production mode, follow the guide [here](./dockerLocal_prodVault.md).

## Next up
[**Login to RPS**](../General/loginToRPS.md)
