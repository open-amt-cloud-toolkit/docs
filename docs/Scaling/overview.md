--8<-- "References/abbreviations.md"

# Scaling Overview
Scaling functionality in MPS enables Open AMT Cloud Toolkit to support a greater number of managed devices. The toolkit offers various methods for deploying scaling, including Kubernetes (K8s), Azure Kubernetes Service* (AKS), and Docker Swarm*. In addition, administrators can use kuberctl to manage the AKS. 


![../assets/images/HighLevelArchitectureScaling](../assets/images/HighLevelArchitectureScaling.png)

**Figure 1: High-level Architecture of Scaling Implementation**

Figure 1 illustrates the basic high-level software flow:

* Managed devices use CIRA to connect and call home to instances of the MPS in the cloud. 
* RPCs connect to an available instance of the MPS Server with WSS calls. These calls are funneled through Kong* API Gateway, which supports a variety of APIs. Kong manages load balancing, logging, authentication and more. 
* The Kong* API Gateway handles requests from client apps, such as the Sample Web UI included in Open AMT Cloud Toolkit, sending them along to an available RPS.
* The MPS Router chooses an available instance of the MPS.
* The RPS microservices communicate with MPS microservices through the REST API. 
* Vault is a tool used to secure, store, and tightly control access to secrets. Storing passwords used by MPS in Vault will increase the security of these assets.


## Docker in Swarm Mode
If you're new to scaling, Docker in swarm mode is a great way to start developing a scaling proof of concept. 

Docker in swarm mode is a container orchestration tool, software used to deploy and manage large numbers of containers and services. In this mode, Docker enables the administrator to deploy and manage Docker nodes or worker nodes that are added to a Docker swarm instance. Administrator can then deploy a service to the swarm instance and expose ports to an external load balancer.  

!!! Information
    To learn more about Docker in swarm mode, start with [Swarm mode overview](https://docs.docker.com/engine/swarm/).

[Get Started with Docker Swarm](../Scaling/Docker%20Swarm/docker-swarm.md){: .md-button .md-button--primary target="_blank"}

## Kubernetes
Kubernetes is a container orchestration system that enables administrators to deploy and manage large numbers of containers and services.

!!! Warning
    The Kubernetes deployment section is not a tutorial for beginners. It intended for those who have prior knowledge of the service. To begin learning about K8s, start with [Kubernetes](https://kubernetes.io/).

[Get Started with Kubernetes](../Scaling/Kubernetes/kubernetes.md){: .md-button .md-button--primary target="_blank"}

## Kubernetes (K8s)
K8s is a container orchestration system that enables administrators to deploy and manage large numbers of containers and services. The instructions use kubectl, a command line tool for managing Kubernetes clusters.


!!! Warning
    The K8s deployment section is not a tutorial for beginners. It intended for those who have prior knowledge of the service. To begin learning about K8s, start with [Kubernetes](https://kubernetes.io/).

[Get Started with K8s](../Kubernetes/deployingk8s.md){: .md-button .md-button--primary target="_blank"}

## Azure Kubernetes Service (AKS)
AKS is a container orchestration system that enables administrators to deploy and manage large numbers of containers and services. 

!!! Warning
    The AKS deployment section is not a tutorial for beginners. It intended for those who have prior knowledge of the service. To begin learning about AKS, start with [Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/aks/).

[Get Started with AKS](../Kubernetes/deployingk8s-aks.md){: .md-button .md-button--primary target="_blank"}
