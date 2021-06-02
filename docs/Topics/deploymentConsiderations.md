When it comes time to deploy the Open AMT Cloud Toolkit to production there are some crucial decisions that need to made in order to determine the work to be done to prepare the toolkit properly. For each topic below we list what is provided as a reference implementation and as well as some recommended options that can be used as a replacement for the reference implementation.

## Database Selection
The docker based PostgreSQL image that is used in the `docker-compose.yml` is great for proof-of-concept of and development with the Open AMT Cloud Toolkit. However, when gearing up for production it is recommended to leverage a managed database instance offered by a public cloud provider or perhaps a database hosted by your internal IT. Regardless of your deployment scenario (ie. a VM, Kubernetes, Docker Swarm, a native environment), managing state in your own cluster comes with a higher risk of data loss than that of a managed database instance. 

Reference Implementation:

<img src="./../../assets/images/logos/elephant.png" alt="postgres" style="width:50px;"/>

Example Replacements:

<img src="./../../assets/images/logos/azurePostgres.png" alt="azurePostgres" style="width:50px;"/>
<img src="./../../assets/images/logos/amazonRDS.png" alt="amazonRDS" style="width:50px;"/>

## Secret Management/Handling



Reference Implementation:

### HashiCorp Vault
<img src="./../../assets/images/logos/vault.png" alt="vault" style="width:50px;"/>

Example Replacements:
<div style="width:100%:display:block;height:100px">
    <div style="width: 250px;text-align:center;float:left">
        <h4>Azure Key Vault</h4>
        <img src="./../../assets/images/logos/keyvault.jpg" alt="keyvault" style="width:50px;"/>
    </div>
    <div style="width: 250px;text-align:center;float:left">
        <h4>AWS Key Management Service</h4>
        <img src="./../../assets/images/logos/amazonRDS.png" alt="postgres" style="width:50px;"/>
    </div>
</div>



## Authentication Integration

Reference Implementation:

<img src="./../../assets/images/logos/kong.svg" alt="kong" style="width:100px;"/>

Example Replacements:

<img src="./../../assets/images/logos/azurePostgres.png" alt="postgres" style="width:50px;"/>
<img src="./../../assets/images/logos/amazonRDS.png" alt="postgres" style="width:50px;"/>