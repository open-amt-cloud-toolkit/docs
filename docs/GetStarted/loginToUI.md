--8<-- "References/abbreviations.md"

The web portal is available for login after the deployment of the MPS, RPS, and Sample Web UI. Make sure all three are successfully running before attempting to login.

!!! example
    **Passwords**

    Open AMT Cloud Toolkit increases security with multiple passwords. Find an explanation of toolkit passwords in [Reference -> Architecture Overview](../Reference/architectureOverview.md#Passwords).

## Log In

1. Open any modern web browser and navigate to the following link.

    ```
    https://<Development-IP-Address>
    ```

    !!! important "Important - URL of Sample Web UI"
        You **must use** the development system's IP address in the URL. **Localhost or 127.0.0.1 will NOT work**. [Read more about Kong API Gateway to find out why](https://konghq.com/kong/){target=_blank}. The development system's IP address is where the Docker containers are running.


2.  A warning screen will prompt because the MPS Server is using self-signed certificates for testing. Click **Advanced** and then **Proceed** to continue to connect to the Sample Web UI.

    !!! example "Example - Chrome* Browser Warning Screen"
        [![MPS Warning](../assets/images/selfSignedConnect.png)](../assets/images/selfSignedConnect.png)


3. Log in to the web portal with the login credentials set for the environment variables `MPS_WEB_ADMIN_USER` and `MPS_WEB_ADMIN_PASSWORD` in the `.env` file.


4. The home page is shown below in Figure 1.

    !!! example "Example - Sample Web UI Home Page"
        [![WebUI](../assets/images/WebUI_Home.png)](../assets/images/WebUI_Home.png)
    

## Next up
**[Create a CIRA Config](createCIRAConfig.md)**
