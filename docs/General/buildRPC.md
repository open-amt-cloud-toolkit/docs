<!-- [![RPC](../assets/animations/forkandbuild.gif)](../assets/animations/forkandbuild.gif =500x) -->

The Remote Provisioning Client (RPC) communicates with the Manageability Engine Interface (MEI) and RPS interfaces. The MEI uses the ME Driver to talk to Intel AMT. By running RPC, we will activate Intel AMT into Client Control Mode (CCM), or Admin Control Mode (ACM) based on the created profile, as well as configure the CIRA connection of the AMT device to the MPS. After successfully running, the AMT device will be ready to be managed remotely using the web interface!

!!! tip "Production Environment"
        In a production environment, RPC can be deployed with an in-band manageability agent to distribute it to the fleet of AMT devices. The in-band manageability agent can invoke RPC to run and activate the AMT devices.

[![RPC](../assets/images/RPC_Overview.png)](../assets/images/RPC_Overview.png)

## Build RPC

We leverage GitHub Actions as a means to build RPC automatically leveraging Github's CI/CD Infrastructure. This avoids having to deal with the challenges of getting your build environment just right on your local machine and allows you to get up and running much faster. However, if you wish to do this locally, please follow the instructions [here](../Microservices/RPC/buildRPC_Manual.md). Optionally, to build RPC with Docker, skip to [Docker Build](#docker-build).

Read more about GitHub Actions [here](https://github.blog/2019-08-08-github-actions-now-supports-ci-cd/#:~:text=GitHub%20Actions%20is%20an%20API,every%20step%20along%20the%20way.)

<img src="../../assets/animations/forkandbuild.gif" width="500"  />

### Github Actions
#### To Build the RPC with Github Actions

1. Create a fork of the repository.

    [Fork rpc on github](https://github.com/open-amt-cloud-toolkit/rpc/fork){: .md-button .md-button--primary }

2. Click on **Actions**, the tab at the top, and select **Build RPC (Native) Debug/Release**.

3. Click the **Run Workflow** dropdown. 

4. Select the **branch: v1.1.0** from the **Use workflow from** dropdown. 

5. By default, the Build Type should be **release**.  

6. Click the **Run Workflow** button.

7. The build time ranges from 15 to 20 minutes.

8. Once the download is complete, click the completed job, which will feature a green checkmark, and download the appropriate RPC for your managed device's OS under the **Artifacts** section.

#### To Delete your workflow run

1. Click the **...** menu for the workflow. 

2. Choose the **Delete workflow run** option.

### Docker Build

To build RPC w/ Docker, use the following command from the root directory of the open-amt-cloud-toolkit:

``` bash
cd ./rpc && docker build -f "Dockerfile" -t rpc:latest .
```  

## Run RPC to Activate and Connect the AMT Device

**To run the application and connect the managed device:**

1. On the managed device, run RPC with the following command to activate and configure Intel&reg; AMT. It will take 1-2 minutes to finish provisioning the device.

    - Replace [Development-IP-Address] with the development system's IP address, where the MPS and RPS servers are running
    - Replace [profile-name] with your created profile from the Web Server.

    === "Linux"
        ``` bash
        sudo ./rpc -u wss://[Development-IP-Address]:8080 --nocertcheck -c "-t activate --profile [profile-name]"
        ```
    === "Docker"
        ``` bash
        sudo docker run --device=/dev/mei0 rpc:latest --url wss://[Development-IP-Address]:8080 --nocertcheck -c "activate --profile [profile-name]"
        ```
    === "Windows"
        ```
        rpc.exe -u wss://[Development-IP-Address]:8080 --nocertcheck -c "-t activate --profile [profile-name]"
        ```

!!! note
    Because we are using a self-signed certificate for easier development testing, we need to supply the **--nocertcheck** flag. In production, you would opt for a CA signed certificate. Find out more information about the flag and other arguments [here](../Microservices/RPC/commandsRPC.md).


!!! success
    Example Output after Activating and Configuring a device into ACM:

    [![RPC Success](../assets/images/RPC_Success.png)](../assets/images/RPC_Success.png)


    !!! tip "Production Environment"
        In a production environment, an in-band agent would invoke this command with the parameters rather than a manual command.

!!! note "Troubleshooting"
        RPC generates this message: Unable to get activation info. 
        
        Try again later or check AMT configuration. Verify that you are running RPC with elevated privileges in Terminal or Command Prompt on the managed device .
         
        
<!-- !!! note
    If you do not remember your created profile's name, you can navigate to the *Profiles* tab on the web server hosted at `https://[Development-IP-Address]:3000`

    **Default login credentials:**
    
    | Field       |  Value    |
    | :----------- | :-------------- |
    | **Username**| standalone |
    | **Password**| G@ppm0ym | -->


## Next up
[Manage AMT Device](../General/manageDevice.md)