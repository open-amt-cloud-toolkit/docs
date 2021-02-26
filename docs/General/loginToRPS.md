
The web portal is available for login after the deployment of the [Management Presence Server (MPS)](../Glossary.md#m), [Remote Provisioning Server (RPS)](../Glossary.md#r), and [Sample Web UI](../Glossary.md#s). Make sure all three are successfully running before attempting to login.

## Before Logging In

1. Open a Chrome* browser and navigate to the following link. Because the MPS Server is using self-signed certificates in developer mode, we must proceed past the warning screen for the Sample Web UI to connect.

    ```
    https://[Development-IP-Address]:3000
    ```

2.  A warning screen will prompt. Click **Advanced** and then **Proceed** to continue to connect to the MPS webserver.

    !!! example
        [![MPS Warning](../assets/images/selfSignedConnect.png)](../assets/images/selfSignedConnect.png)

## Log In

1. Open a new tab on the Chrome* browser and navigate to the Sample Web UI using your development system's IP address on the port of the Sample Web UI. Typically, this is port 3001.

    ```
    http://[Development-IP-Address]:3001
    ```

    !!! important
        Use your development system's IP Address to connect to the web server.
        **Using `localhost` will not work.** Google Chrome is currently the **only** supported browser for the Sample Web UI.


2. Log in to the web portal with the credentials below.

    **Default credentials:**

    | Field       |  Value    |
    | :-----------| :-------------- |
    | **Username**| standalone |
    | **Password**| G@ppm0ym |

3. Select **Remote Provisioning Server** on the web portal.

    [![WebUI](../assets/images/WebUI_HomeRPS.png)](../assets/images/WebUI_HomeRPS.png)

    **Figure 1: Choose Remote Provisioning Server.**

## Next up
**[Create a CIRA Config](createCIRAConfig.md)**
