--8<-- "References/abbreviations.md"
To deploy the Open AMT Cloud Toolkit to a production environment, replace default reference implementation components with more robust or full-featured components. Each section below lists the default reference implementation component included with toolkit along with suggestions for replacement. 

## Database Selection
The Docker-based PostgreSQL* image used in `docker-compose.yml` provides enough functionality for proof-of-concept creation and development. However, to enable the toolkit for production, leverage a managed database instance offered by a public cloud provider or a database hosted by your internal IT. 

Regardless of the deployment scenario (e.g. a VM, Kubernetes, Docker Swarm, or a native environment), managing state in your cluster comes with a higher risk of data loss than that of a managed database instance.

### Default Component

<img src="./../../assets/images/logos/elephant.png" alt="postgres" style="width:50px;"/>

- [PostgreSQL](https://www.postgresql.org/)


### Example Replacements

- [Azure Database for PostgreSQL](https://azure.microsoft.com/en-us/services/postgresql/)
- [Azure SQL Database](https://azure.microsoft.com/en-us/products/azure-sql/database)
- [Amazon Relational Database Service (RDS)](https://aws.amazon.com/rds/)
- [MS SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-2019)
- [MariaDB](https://mariadb.org/)

For more information about replacing the default toolkit database, see the [database guide](./database.md).

## Secrets Management

A secret is any asset requiring controlled access, such as API keys, passwords, or certificates. 

The toolkit enables secrets management with HashiCorp Vault*, which provides a secure repository for storing and accessing sensitive assets. Vault offers a unified interface to any secret, tight access control, and a detailed audit log. 

While Vault provides a comprehensive solution for managing and persisting state in a K8s cluster, use of a managed secret provider, such as Azure Key Vault, offloads this role and helps reduce the overhead of secrets management in the toolkit. 

Additionally, if a secret provider is not necessary for your deployment, consider removing it and leveraging some other backing store for secrets.

### Default Component
<img src="./../../assets/images/logos/vault.png" alt="vault" style="width:50px;"/>

- [HashiCorp Vault](https://www.vaultproject.io/)


### Example Replacements
- [Azure Key Vault](https://docs.microsoft.com/en-us/azure/key-vault/)
- [AWS Key Management Service (KMS)](https://aws.amazon.com/kms/)

For more information about replacing the default secret provider, see the [secrets guide](./secrets.md).

## API Gateway 

The toolkit uses Kong as its open source API gateway. Kong provides an entry point for external clients, anything not a part of the microservice system, and a comprehensive suite of plugins for various scenarios.

### Default Component

<img src="./../../assets/images/logos/kong.svg" alt="kong" style="width:100px;"/>

- [Kong](https://konghq.com/)

### Example Replacements

- [Azure API Gateway](https://docs.microsoft.com/en-us/azure/architecture/microservices/design/gateway)
- [Amazon API Gateway](https://aws.amazon.com/api-gateway/)
- [Google Cloud Endpoints](https://cloud.google.com/endpoints)
- [Tyk](https://tyk.io/)