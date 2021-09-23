When it comes time to deploy the Open AMT Cloud Toolkit to production there are some crucial decisions that need to made in order to determine the work to be done to prepare the toolkit properly. For each topic below we list what is provided as a reference implementation and as well as some recommended options that can be used as a replacement for the reference implementation.

## Database Selection
The docker based PostgreSQL image that is used in the `docker-compose.yml` is great for proof-of-concept of and development with the Open AMT Cloud Toolkit. However, when gearing up for production it is recommended to leverage a managed database instance offered by a public cloud provider or perhaps a database hosted by your internal IT. Regardless of your deployment scenario (ie. a VM, Kubernetes, Docker Swarm, a native environment), managing state in your own cluster comes with a higher risk of data loss than that of a managed database instance. 

#### Reference Implementation

<img src="./../../assets/images/logos/elephant.png" alt="postgres" style="width:50px;"/>

- Postgres


#### Example Replacements

- Azure Managed Postgres
- Azure MSSQL
- Amazon RDS
- MySQL
- MariaDB

For a short guide on how to swap out the database read [this guide](./database.md).
## Secret Management/Handling

Secret Management is essential in a microservice architecture as it provides a secure repository for the services to access required sensitive assets. The Open AMT Cloud toolkit uses Hashicorp Vault as its tool for securely accessing these assets. A secret is anything that you want to tightly control access to, such as API keys, passwords, or certificates. Vault provides a unified interface to any secret, while providing tight access control and recording a detailed audit log. Similar to the database section above, when it comes time to scale Open AMT Cloud Toolkit for production, managing state can be difficult. While Vault has a comprehensive solution for managing and persisting state in a K8s cluster, we recommend leveraging a managed secret provider such as Azure Key Vault to offload this role and help reduce the overhead of managing this aspect of the toolkit. Additionally, you may consider that a Secret Provider is not necessary for your deployment and may wish to remove it leveraging some other backing store for secrets.

#### Reference Implementation
<img src="./../../assets/images/logos/vault.png" alt="vault" style="width:50px;"/>

- HashiCorp Vault


#### Example Replacements
- Azure Key Vault
- AWS Key Management Service      

For a short guide on how to swap out the secret provider read [this guide](./secrets.md).



## API Gateway 

The API gateway is an important concept in microservices architecture. It provides an entry point for external clients(anything that is not part of the microservice system). It is a component that acts as an entry point for the Open AMT Cloud toolkit. We have chosen Kong as our reference implementation as it is open source and provides a comprehensive suite of plugins for various scenarios.



### Reference Implementation

<img src="./../../assets/images/logos/kong.svg" alt="kong" style="width:100px;"/>

- Kong

### Example Replacements

- Azure API Gateway
- Amazon API Gateway
- Google Cloud Endpoints
- Tyk 