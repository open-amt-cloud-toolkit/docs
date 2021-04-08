### Introduction
Note: Not for production use!!
This guide with provide detail on how to deploy the AMTCloudToolkit services in Microsoft(C) Azure(R).
Functionality has been added to MPS to allow it to scale and support a greater number of devices. 
For this deployment, kubernetes will be used running in Azure(R) along with utilizing both redis and consul.

### High level Design

####Figure #1 MPS Scaling Architecture
[![Scaling architechure](../assets/images/ScallingHighLevel.png)](../assets/images/ScallingHighLevel.png)
Figure # 1 shows a high-level diagram of the overall architechture of the MPS scaling mode.
    
1. Devices connect to an available MPS Server through the load balancer.
1. The REST api requests are routed to an available Web Server (a component of MPS running in scale mode) though a load balancer.
1. The Web Server determines which MPS Server to route the traffic to based on which MPS Server the device is connected to and sends that traffic through the MPS Proxy connection. 
1. The MPS Server sends the traffic to the corresponding device.

### MPS Configuration
To support running the service in a distributed environment, some configuration settings were added to MPS.

1. key\value store (consul) settings:
    1. distributed_kv_name - name of key/value store used.
    1. distributed_kv_ip - ip of key value store.
    1. distributed_kv_port - port used by key/value store.

1. web_proxy_port - port the web server used to communicate to MPS.
1. network_adaptor - network identifier used when device connects to MPS. Can be either an adaptor name such as `eth0` or starting ip address such as `192.168`.
1. startup_mode - microservice run mode. `standalone` when running in non scaling mode or run components in `mps` and `web` for distributated mode.

1. redis settings:
    1. redis_enable - enable redis caching for web session
    1. redis_host - redis host
    1. redis_port - redis port
    1. redis_password - password used to authenticate to redis 

## Get the Toolkit

**To clone the repositories:**

1. Open a Command Prompt or Terminal and navigate to a directory of your choice for development:

``` bash
git clone --recursive https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit
```

### Prerequisite
**Install required software in Windows environment(in admin mode):**

1. Run \open-amt-cloud-toolkit\scripts\kubernetes\installchoco.bat to install the choco package manager
1. Close and reopen command window
1. Run \open-amt-cloud-toolkit\scripts\kubernetes\installpackages.bat to install the required packages

### Steps to Deploy

1. Edit entries in the launch.bat file to fit deployment.

1. Update section `images` in stack environmental variables in open-amt-cloud-toolkit\scripts\kubernetes\serversChart\values.yaml that correspond with desired images for launch.

1. If containers are in a private container registry, a base64 auth token needs to be created and placed in open-amt-cloud-toolkit\scripts\kubernetes\config.json

1. Launch with command "launch.bat [resourceGroupName]" [replace the resourceGroupName with the desired resource group name for the deployment]

1. Use the settings in the \open-amt-cloud-toolkit\scripts\kubernetes\\.env file to update the values in \open-amt-cloud-toolkit\scripts\kubernetes\serversChart\values.yaml

1. From \open-amt-cloud-toolkit\scripts\kubernetes run `helm install openamtcloudstack ./serversChart` to deploy the services into kubernetes.

1. After deployment is complete use the command `kubectl get pods` to verify all pods have been launched successfully.

NOTE: please restore values.yaml to its prelaunch condition before subsiquesnt deployments

