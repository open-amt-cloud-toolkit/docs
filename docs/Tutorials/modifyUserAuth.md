--8<-- "References/abbreviations.md"


As part of the Open AMT Cloud Toolkit reference implementation, there is a Kong API Gateway service that issues a JSON Web Token (JWT) for user authentication. The default configuration offers authentication functionality, but it does not support many common configuration options, such as user groups. In a production environment, alternative authentication is available in 0Auth 2*, Lightweight Directory Access Protocol (LDAP), Kerberos*, etc.

!!! Warning
    In the current release, if you choose to modify the toolkit's default authentication, no keyboard, video and mouse (KVM) or serial over LAN (SOL) support will be available. 

The instructions below explain how to add an LDAP plugin to Kong.

## Prerequisites

Install and start a local LDAP server on the development system. For this tutorial, Go-lang LDAP Authentication* (GLAuth) is referenced. [Find more info in the GLAuth Readme.](https://github.com/glauth/glauth) 
    
1. To install, see steps 1 - 3 of the **Quickstart** section of the [GLAuth Readme](https://github.com/glauth/glauth#quickstart). We do not need to alter the sample-simple.cfg file.

2. Allow the Terminal or Powershell to remain open to see LDAP activity as you proceed with the tutorial below.

3. Optionally, [download curl](https://curl.se/) for testing the authentication with APIs at the end of this tutorial.


## Edit the kong.yaml File

**Reconfigure the Kong* API Gateway to use a different user authentication service:**

1. Open the `kong.yaml` file and comment out the `plugins` and `consumer` sections of the code by adding a `#` character at the beginning of each line. This disables the JWT authentication.

2. Paste the new `plugins` section into the file. 

3. Modify the `ldap_host` to that of your development system or cloud instance. 
    
    ``` yaml hl_lines="7 20"
    plugins:
    - name: cors
    - name: ldap-auth
      route: mps-route
      config: 
        hide_credentials: true
        ldap_host: <Server IP-Address or FQDN> # Replace
        ldap_port: 3893
        start_tls: false
        ldaps: false
        base_dn: dc=glauth,dc=com
        verify_ldap_host: false
        attribute: cn
        cache_ttl: 60
        header_type: ldap
    - name: ldap-auth
      route: rps-route
      config: 
        hide_credentials: true
        ldap_host: <Server IP-Address or FQDN> # Replace
        ldap_port: 3893
        start_tls: false
        ldaps: false
        base_dn: dc=glauth,dc=com
        verify_ldap_host: false
        attribute: cn
        cache_ttl: 60
        header_type: ldap
    ```

    !!! Note
        The following code was adapted for the toolkit. For the default configuration details, see **Enable the plugin on a route**, on the tab **Declarative YAML**, in [Kong documentation](https://docs.konghq.com/hub/kong-inc/ldap-auth/#main)

## Restart the Kong Gateway Container

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


## Test the Configuration

Authenticate a user to test the configuration by using an API of your choice. You will need to set the Authorization header to `ldap base64encode(user:pass)`.

**Test the configuration with curl:**

In the following examples, we use the base64 encoding of `johndoe:TestAppPw1` as our encoded `user:pass`. This value is `am9obmRvZTpUZXN0QXBwUHcx`. These credentials are one of the default credentials in the `sample-simple.cfg` file provided by GLAuth*.

=== "Get Devices (MPS Route)"     
    === "Linux"
        ``` bash
        curl --insecure https://[IP-Address or FQDN]/mps/api/v1/devices \
            -H "Authorization: ldap am9obmRvZTpUZXN0QXBwUHcx"
        ```
    === "Windows"
        ``` bash
        curl --insecure https://[IP-Address or FQDN]/mps/api/v1/devices ^
            -H "Authorization: ldap am9obmRvZTpUZXN0QXBwUHcx"
        ```
    See [Devices API Docs](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/{{ mpsAPI.version }}#/Devices/get_api_v1_devices) for more information and expected responses.
=== "Get Profiles (RPS Route)"
    === "Linux"
        ``` bash
        curl --insecure https://[IP-Address or FQDN]/rps/api/v1/admin/profiles \
            -H "Authorization: ldap am9obmRvZTpUZXN0QXBwUHcx"
        ```
    === "Windows"
        ``` bash
        curl --insecure https://[IP-Address or FQDN]/rps/api/v1/admin/profiles ^
            -H "Authorization: ldap am9obmRvZTpUZXN0QXBwUHcx"
        ```
    See [Get Profiles API Docs](https://app.swaggerhub.com/apis-docs/rbheopenamt/rps/{{ rpsAPI.version }}#/Profiles/GetAllProfiles) for more information and expected responses.

<br>
<br>