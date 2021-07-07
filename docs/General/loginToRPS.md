--8<-- "References/abbreviations.md"

The web portal is available for login after the deployment of the MPS, RPS, and Sample Web UI. Make sure all three are successfully running before attempting to login.

!!! example
    **Passwords**

    Open AMT Cloud Toolkit increases security with multiple passwords. Find an explanation of toolkit passwords in [Components -> Overview](../Microservices/overview.md#Passwords).

## Log In

1. Open any modern web browser and navigate to the following link. Because the MPS Server is using self-signed certificates in developer mode, we must proceed past the warning screen for the Sample Web UI to connect.

    ```
    https://<Development-IP-Address>
    ```

2.  A warning screen will prompt. Click **Advanced** and then **Proceed** to continue to connect to the MPS webserver.

    !!! example
        [![MPS Warning](../assets/images/selfSignedConnect.png)](../assets/images/selfSignedConnect.png)


3. Log in to the web portal with the login credentials set for the environment variables `MPS_WEB_ADMIN_USER` and `MPS_WEB_ADMIN_PASSWORD` in the `.env` file.


4. The home page is shown below in Figure 1.

    !!! example
        [![WebUI](../assets/images/WebUI_Home.png)](../assets/images/WebUI_Home.png)

        **Figure 1: Sample Web UI Home Page**
    

## Next up
**[Create a CIRA Config](createCIRAConfig.md)**
