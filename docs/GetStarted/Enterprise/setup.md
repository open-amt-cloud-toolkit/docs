--8<-- "References/abbreviations.md"

!!! warning "Warning - Console in Beta Development"
    Console is currently under development. The current available tags for download are Beta version code. This could mean that certain features may not function yet, visual look and feel may change, or bugs/errors may occur. It is not recommended for use in Production deployments. Follow along our [Feature Backlog for future releases and feature updates](https://github.com/orgs/open-amt-cloud-toolkit/projects/10)

## What You'll Need

**Configure a network that includes:**

-  A development system (to run Console)
-  A provisioned or unprovisoned Intel AMT device

## What You'll Do

<figure class="figure-image">
  <img src="..\..\..\assets\images\Console_GetStarted.png" alt="Figure 1: Get Started with Console">
  <figcaption>Figure 1: Get Started with Console</figcaption>
</figure>

**To complete a deployment:**

1. [Download and run Console](#get-console)
2. [Create a CCM](createProfileCCM.md) or [ACM Profile](createProfileACM.md)
3. [Activate and configure an Intel AMT device](activateDevice.md)
4. [Add a device to Console](addDevice.md)
5. [Manage a device using Console](manageDevice.md)

!!! note "Note - For devices that are already activated in ACM or CCM"
    If your Intel AMT device is already activated in CCM or ACM, you can skip steps 2 and 3 after completing step 1 and proceed directly to [Add a device to Console](addDevice.md).


## Get Console

### Download

1. Find the latest release of Console under [Github Releases](https://github.com/open-amt-cloud-toolkit/console/releases/latest).

    !!! warning "Warning - Upgrading from Alpha to **BETA**"
        Starting from the Beta release, all sensitive data in the SQLite database will be encrypted using an encryption key. Due to this security enhancement, you'll need to delete the existing database file before upgrading. Instructions on how to delete the database can be found [here](../../Reference/Console/upgrade.md/#upgrading-from-alpha-to-beta)

2. Download the appropriate binary assets for your OS and Architecture under the *Assets* dropdown section.

    !!! note "Note - Warnings when Downloading from Github"
        If downloading Console on Windows, a warning may appear and require approval to continue the download. The Beta executable of Console is not currently signed. This will no longer be the case when the full release of Console is available. 

### Configure Console

1. Create a `config` directory and a new file named `config.yml` in the same directory as *Console executable*. Alternatively, Console can automatically generate a `config.yml` file, see [here](../../Reference/Console/configuration.md/#using-configyml) for more details.

2. Copy and paste the following example text into the `config.yml` file.

    ```yml hl_lines="6 8 9"
    app:
      name: console
      repo: open-amt-cloud-toolkit/console
      version: DEVELOPMENT
      encryption_key: "" # A key will be generated at runtime for you if not provided
      jwtKey: your_secret_jwt_key
      authDisabled: false
      adminUsername: standalone
      adminPassword: G@ppm0ym
      jwtExpiration: 24h0m0s
      redirectionJWTExpiration: 5m0s
    http:
      host: localhost
      port: "8181"
      allowed_origins:
      - '*'
      allowed_headers:
      - '*'
    logger:
      log_level: info
    postgres:
      pool_max: 2
      url: ""
    ea:
      url: http://localhost:8000
      username: ""
      password: ""
    ```

3. Update the following fields.

    | Field Name     | Required                              | Usage                    |
    | -------------- | ------------------------------------- | ------------------------ |
    | jwtKey         | A strong secret of your choice (Example: A unique, random 32-character string, e.g. `Yq3t6w9z6CbE3HRMcQfTjWnZr4u7x6AJ`). | Used when generating a JSON Web Token (JWT) for authentication. This example implementation uses a symmetrical key and HS256 to create the signature. [Learn more about JWT](https://jwt.io/introduction){target=_blank}.|
    | adminUsername  | Username of your choice               | For logging into Console |
    | adminPassword  | **Strong** password of your choice    | For logging into Console |

    !!! important "Important - Using Strong Passwords"
        The adminPassword must meet standard, **strong** password requirements:

        - 8 to 32 characters

        - One uppercase, one lowercase, one numerical digit, one special character

4. Save and close the file.

### Run

1. Run the executable, and a terminal will open containing the Console process. The Console process will read the configuration from `config/config.yml`. 

    !!! note "Note - Alternate Methods to Run Console"
        You can also open a terminal session and run Console by providing a custom path to config.yml with the following command:
        ```console.exe -config /path/to/config.yml```

2. If an `encryption_key` was not set, Console will prompt to generate a new key for encryption. Type `Y` and press **Enter**.

    !!! note "Note - Encryption Key Information"
        Console automatically stores this 32-character key in Operating System's credential manager, such as Windows Credential Manager, under the name *device-management-toolkit*. This key is used to encrypt sensitive data before it is stored in the database.

3. Console is now successfully running! A browser window will open running `http://localhost:8181` where you can access the Console UI and start adding devices.

    !!! success
        <figure class="figure-image">
          <img src="..\..\..\assets\images\Console_Start.png" alt="Figure 2: Console Process Startup">
          <figcaption>Figure 2: Console Process Startup</figcaption>
        </figure>

### Login

1. Log in to Console using the set credentials, `adminUsername` and `adminPassword`.

    !!! example
        <figure class="figure-image">
          <img src="..\..\..\assets\images\Console_UIStart.png" alt="Figure 3: Console UI Startup">
          <figcaption>Figure 3: Console UI Startup</figcaption>
        </figure>


## Next up

Profiles provide configuration information to the AMT Firmware during the activation process with the Remote Provisioning Client (RPC). Profiles also distinguish between activating in: 

**[Client Control Mode (CCM):](createProfileCCM.md)** This mode offers all manageability features including, but not limited to, power control, audit logs, and hardware info. Redirection features, such as KVM or SOL, **require user consent**. The managed device will display a 6-digit code that **must** be entered by the remote admin to access the remote device via redirection.

[Create a CCM Profile](createProfileCCM.md){: .md-button .md-button--primary }

**[Admin Control Mode (ACM):](createProfileACM.md)** ACM mode supports all manageability features **without requiring user consent**. This means it is **not necessary** to have a person on-site to remote in and manage an edge device. In most IoT use cases, edge devices such as digital signage or kiosks may not be easily accessible or have available employees nearby. ACM mode proves immensely helpful in these scenarios.

[Create an ACM Profile](createProfileACM.md){: .md-button .md-button--primary }