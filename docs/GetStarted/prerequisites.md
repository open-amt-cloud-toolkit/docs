--8<-- "References/abbreviations.md"
# Prerequisites

This section contains prerequisites for deploying Open AMT Cloud Toolkit's MPS and RPS microservices on a local development system as Docker* containers. 

<figure class="figure-image">
  <img src="..\..\assets\images\LocalDockerWorkflow.png" alt="Figure 1: Deploy microservices on a local development system as Docker containers">
  <figcaption>Figure 1: Deploy microservices on a local development system as Docker containers</figcaption>
</figure>

## What You'll Need

###Hardware

**Configure a network that includes:**

-  A development system 
-  At least one Intel vPro® Platform
-  A flash drive or equivalent means to transfer files between

Both systems must use a wired (i.e., cable) connection on the same network.

###Development System Software

**Before MPS and RPS installation, install the following software on your development system:**

- [git*](https://git-scm.com/downloads)
- [Docker* Desktop](https://www.docker.com/products/docker-desktop) for Windows* or Linux*
  
    !!! Info
        **Docker Configuration Details: **
        (1) The Docker for Windows installer defaults to enable all the required settings for this tutorial.
        (2) After successful installation, the Docker icon (whale), will appear on the task bar. 
        (3) To troubleshoot the installation, [see the troubleshooting guide](https:/docs.docker.com/docker-for-windows/troubleshoot/){target=_blank}.


**For RPC setup, install the following software on your development system:**

* [Go* Programming Language](https://go.dev/)
* [tdm-gcc](https://jmeubank.github.io/tdm-gcc/download/) (On Windows* only)

## What You'll Do

**To complete a deployment:**

- Install the prerequisites.
- Pull and deploy microservices with Docker.
- Login to the Sample Web UI and configure profiles.
- Build RPC.
- Copy RPC to a managed device.


**To connect the managed device:**

- Run RPC on a managed device.
- Manage the device with MPS through the Sample Web UI.

These sections include instructions for Windows and Linux* environments. Run instructions in a terminal window, the Windows Command Prompt in Administrator mode or the Linux shell/terminal.

## Why Docker*?

A Docker container is the instantiation of a Docker image as a virtualized unit that separates the application from the environment. Docker containers start and run reliably, securely, and portably inside different environments, eliminating some of the problems that occur with software deployment on varying platforms. Docker streamlines installation to get you up and running faster.

Get more information about Docker images and containers at [Docker resources.](https://www.docker.com/resources/what-container)   

## Next up
[**Setup - Pull Docker* Images**](setup.md)

