--8<-- "References/abbreviations.md"

### Introduction
This deployment demonstrates the use of Docker* in swarm mode with the following conditions: 

- All the images are built and tested with docker-compose. To learn more about building the images with docker-compose, please refer to [**Express Setup**](../../Docker/dockerLocal.md). 
- Images can only be deployed on other systems if they are pushed to a registry. 
- Also, if the images are not pushed to any registry, it cannot be deployed on other systems. 


!!! important
    Not for production use. 

### Deploy the stack to the swarm

!!! important "Important - For Linux"
    Before running the following commands on Linux, confirm that the user has been added to the docker group. For instructions on how to do this please refer to [**Add docker group**](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user). Otherwise, you can prefix each command with `sudo`.

1. Initialize a swarm:
   
     ```
     docker swarm init
     ```      

2. Copy docker compose config to temporary swarm.yml file:
   
    ```
    docker-compose -f .\docker-compose.yml config > swarm.yml
    ```

3. Set the network to overlay: 
   
    === "Linux"
        ```
        bash sed -i "s|driver: bridge|driver: overlay|g" swarm.yml
        ```
    === "Windows"
        ```
        powershell (Get-Content -Path './swarm.yml') -replace 'driver: bridge', 'driver: overlay' | Set-Content -Path './swarm.yml'
        ```
4. Create the stack
```
docker stack deploy -c swarm.yml scalingdemo
```

5. Check all the services are running:

    ```
    docker stack services scalingdemo
    ```

    !!! success
        The table below is an example of a services list: 
        
        |ID           |NAME                    |MODE             |REPLICAS         |IMAGE             |PORTS                              |
        | :-----------|:-----------------------| :-------------- | :-------------- | :--------------- | :-------------------------------  |
        |6dye78yg66zp |scalingdemo_db          |replicated       | 1/1             |postgres:latest   | *:5432->5432/tcp                  |
        |nahbub6fxrvu |scalingdemo_kong          |replicated       | 1/1            |kong:2.3  | *:443->8443/tcp, *:8001->8001/tcp                 |
        |nltp54asb8kz |scalingdemo_mps          |replicated       | 1/1             |mps:latest   |  *:4433->4433/tcp                  |
        |uc9jsf5554cv |scalingdemo_mpsrouter          |replicated       | 1/1       |mpsrouter:latest   |                  |
        |ojtcs8qjxct3 |scalingdemo_rps          |replicated       | 1/1             |rps:latest   |             |
        |wbk4of70do63  |scalingdemo_vault          |replicated      | 1/1             |vault:latest   | *:8200->8200/tcp                 |
        |pc143h8ml4ua  |scalingdemo_webui          |replicated      | 1/1             |webui:latest   |                 |


6. Scale the mps service:

    ```
    docker service scale scalingdemo_mps=2
    ```

   
7. Remove the stack:

    ```
    docker stack rm scalingdemo
    ```
