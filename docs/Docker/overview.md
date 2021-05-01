--8<-- "References/abbreviations.md"
# Prerequisites

This section contains prerequisites for deploying Open AMT Cloud Toolkit's MPS and RPS microservices on a local development system as Docker* containers. 

[![Docker Local Overview](../assets/images/LocalDockerWorkflow.png)](../assets/images/LocalDockerWorkflow.png)


**Figure 1: Deploy microservices on a local development system as Docker containers. **

## What You'll Need

###Hardware

**Configure a network that includes:**

-  A development system 
-  At least one Intel vPro® device
-  A flash drive or equivalent means to transfer files between

Both systems must use a wired (i.e., cable) connection on the same network.

###Development System Software

**Before MPS and RPS installation, install the following software:**

- [Docker* Desktop](https://www.docker.com/products/docker-desktop) for Windows* or Linux*
  
    !!! Info
        **Docker Configuration Details: **
        (1) The Docker for Windows installer defaults to enable all the required settings for this tutorial.
        (2) After successful installation, the Docker icon (whale), will appear on the task bar. 
        (3) To troubleshoot the installation, [see the troubleshooting guide](https:/docs.docker.com/docker-for-windows/troubleshoot/){target=_blank}.

- [git](https://git-scm.com/downloads)

## What You'll Do

**To complete a deployment:**

- Install the prerequisites.
- Run setup to build and deploy microservices with Docker.
- Login and configure RPS.
- Build RPC.
- Copy RPC to a managed device.


**To connect the managed device:**

- Run RPC on a managed device.
- Manage the device with MPS.

These sections include instructions for Windows and Linux* environments. Run instructions in a terminal window, the Windows Command Prompt in Administrator mode or the Linux shell/terminal.

## Why Docker*?

A Docker container is the instantiation of a Docker image as a virtualized unit that separates the application from the environment. Docker containers start and run reliably, securely, and portably inside different environments, eliminating some of the problems that occur with software deployment on varying platforms. Docker streamlines installation to get you up and running faster.

Get more information about Docker images and containers at [Docker resources.](https://www.docker.com/resources/what-container)   

## Next up
[**Build Docker* Images**](dockerLocal.md)

