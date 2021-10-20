--8<-- "References/abbreviations.md"

#Modify User Authentication     

The MPS hosts a default authentication service that issues a JSON Web Token (JWT) for user authentication. The default service offers authentication functionality, but it does not support many common configuration options, such as user groups. In a production environment, more robust authentication is available in 0Auth 2*, Lightweight Directory Access Protocol (LDAP), Kerberos*, etc.

 The instructions below explain how to add an LDAP plugin to Kong.

!!! Prerequisite
    Install and run an LDAP server on the development system before running these instructions. For this tutorial, Go-lang LDAP Authentication* (GLAuth) is referenced.  
    
    1. To install, see the **Quickstart** section of the [GLAuth Readme](https://github.com/glauth/glauth). 
    
    2. Add users and groups as described in the **Configuration** section. 

    3. Open a Terminal or Powershell/Command Prompt and start the LDAP server with your preconfigured configuration file (e.g., .\glauth-win64.exe -c .\yourfile.cfg)
    
    4. Allow the Terminal or Powershell to remain open to see LDAP activity as you proceed with the tutorial below.

!!! Warning
    If you choose to modify the toolkit's default authentication, no keyboard, video and mouse (KVM) or serial over LAN (SOL) support will be available. 

##Edit the kong.yaml File

**Reconfigure the Kong* API Gateway to use a different user authentication service:**

1. Open the `kong.yaml` file and comment out the `plugins` and `consumer` sections of the code by adding a `#` character at the beginning of each line. This disables default authentication.

2. Paste the new `plugins` section into the file. 

    !!! Note
        The following code was adapted for the toolkit. For configuration details, see **Enable the plugin on a route**, on the tab **Declarative YAML**, in [Kong documentation](https://docs.konghq.com/hub/kong-inc/ldap-auth/#main)

    
    ``` yaml
    plugins:
    - name: cors
    - name: ldap-auth
    route: <mps-route>
    config: 
        hide_credentials: true
        ldap_host: ldap.example.com
        ldap_port: 389
        start_tls: false
        ldaps: false
        base_dn: dc-vprodemo, dc-com
        verify_ldap_host: false
        attribute: cn
        cache_ttl: 60
        header_type: ldap
    name: ldap-auth
    route: <rps-route>
    config: 
        hide_credentials: true
        ldap_host: ldap.example.com
        ldap_port: 389
        start_tls: false
        ldaps: false
        base_dn: dc-vprodemo, dc-com
        verify_ldap_host: false
        attribute: cn
        cache_ttl: 60
        header_type: ldap
    ```

3. Modify the `ldap_host` and `ldap_port` number to that of your development system. 

##Restart the Gateway

1. Open a Terminal or Powershell/Command Prompt and run the command to list the containers:

    === "Linux"
        ```
        sudo docker ps
        ```
    === "Windows (Powershell)"
        ```
        docker ps
        ```

2. Restart the Kong container:

    === "Linux"
        ```
        sudo docker restart <container ID>
        ```
    === "Windows (Powershell)"
        ```
        docker restart <container ID>
        ```


##Test the Configuration

Authenticate a user to test the configuration. You will need to set the authorization header. For details about the authorization header, see the **Usage** section of the [Kong documentation](https://docs.konghq.com/hub/kong-inc/ldap-auth/#main).

!!! Note
    This example uses the MPS API method, `devices`, which lists all devices known to the MPS. For more information about MPS methods, see [MPS API Docs](./../APIs/indexMPS.md).

**Test the configuration with curl:**

1. Obtain a token for LDAP:

    === "Linux"
        ```
        curl placeholder
        ```
    === "Windows"
        ```
        curl placeholder
        ```
    !!! example "Example - Response of Authorize Method"
        placeholder 

2. Use the token to verify user credentials. Fill in the authorization header with the base-64 token obtained from the previous step: 

    === "Linux"
        ```
        curl placeholder
        ```
    === "Windows"
        ```
        curl placeholder
        ```

    !!! example "Example - Response of Devices Method"
        placeholder 

