
The web portal is available for login after the deployment of the [Management Presence Server (MPS)](../Glossary.md#m), [Remote Provisioning Server (RPS)](../Glossary.md#r), and [Sample Web UI](../Glossary.md#s). Make sure all three are successfully running before attempting to login.

**To login:**

1. Open a Chrome* browser and navigate to the web server using your development system's IP address on the port of the Sample Web UI. Typically, port 3001.

    ```
    http://[Development-IP-Address]:3001
    ```

    !!! important
        Use your development system's IP Address to connect to the web server.
        **Using `localhost` will not work.** Google Chrome is currently the **only** supported browser for the Sample Web UI.

2. Using a self-signed certificate will prompt a warning screen. Click **Advanced** and then **Proceed** to continue to connect to the webserver.

3. Log in to the web portal with the credentials below.

    **Default credentials:**

    | Field       |  Value    |
    | :-----------| :-------------- |
    | **Username**| standalone |
    | **Password**| G@ppm0ym |

4. Select **Remote Provisioning Server** on the web portal.

[![WebUI](../assets/images/WebUI_HomeRPS.png)](../assets/images/WebUI_HomeRPS.png)

**Figure 1: Choose Remote Provisioning Server.**

## Next up
**[Create a CIRA Config](createCIRAConfig.md)**