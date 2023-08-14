--8<-- "References/abbreviations.md"
	
We recommend obtaining a provisioning certificate as we have outline how to do [here](https://open-amt-cloud-toolkit.github.io/docs/2.13/GetStarted/createProfileACM/#what-youll-need). However if you are in need of a custom provisioning certificate for a specific use case, we outline how to generate one below. 

Why would I do it:
- If you have a specific Certificate Authority 
- If you don't want interact with certificate vendors 
- If you want to add hashes using a USB 

Drawbacks:
- Hash of the root certificate is not in the trusted list of the firmware 
- You will have to manually go into MEBx and type in the hash, meaning it is not automated

## Generate Custom Provisioning Certificate 

### What You'll Need

**Software** 

- [git](https://git-scm.com/)

    This guide uses Git Bash to run OpenSSL commands. If you choose to use an alternative, install OpenSSL below.

- [OpenSSL](https://www.openssl.org/)

### Prepare Configuration Files

We need to prepare two files:

- **cert.conf** - This is the certificate configuration file. It is used primarily for to define specific settings for the certificate.
- **csr.conf** - This is the certificate signing request configuration file. It is meant for information related to identification . 

#### Update `cert.conf`

1. Update the fields with your information

    - Do not alter the **extendedKeyUsage** field, use the value provided in the example. 

2. Save and close.

!!! example "Example - `cert.conf`"
    ```
    basicConstraints = CA:TRUE
    subjectKeyIdentifier = random
    authorityKeyIdentifier = keyid,issuer:always
    keyUsage = nonRepudiation, cRLSign
    extendedKeyUsage = clientAuth, 2.16.840.1.113741.1.2.3 
    subjectAltName = @alt_names
    
    [alt_names]
    DNS.1 = example.domain
    DNS.2 = test.domain
    IP.1 = 192.168.1.1
    IP.2 = 10.0.0.1
    ```

#### Update `csr.conf`

1. Update the fields with your information:

    - For the **CN** field, make sure to change it to your server's FQDN. For example: intel.vprodemo.com. 

2. Save and close.

!!! example "Example - `csr.conf`"
    ```
    [ req ]
    default_bits = 2048
    prompt = no
    default_md = sha256
    distinguished_name = dn

    [ dn ]
    C=US
    ST=California
    L=Example City
    O=Example Organization
    OU=IT Department
    CN=www.example.com 
    emailAddress=admin@example.com
    OU = Example Unit

    [ req_ext ]
    subjectAltName = @alt_names

    [ alt_names ]
    DNS.1 = example.com # Can add alternative names here 
    DNS.2 = test.example.com
    IP.1 = 10.0.0.1
    IP.2 = 192.168.1.1
    ```
### Create the Certificate and Hash 

1. Open a Git Bash terminal.

2. Generates a self signed X.509 cert and creates a root certificate and key pair.

    ``` bash
    openssl req -x509 -sha256 -days 3560 -nodes -newkey rsa:2048 -subj "//SKIP=skip/CN=CA Custom Root Certificate/C=US/ST=Arizona/L=Chandler" -keyout rootCA.key -out rootCA.crt
    ```

3. Generates RSA private key to file **server.key**

    ``` bash
    openssl genrsa -out server.key 2048
    ```

4. Generates Certificate Signing Request using private key and config file. 

    ``` bash
    openssl req -new -key server.key -out server.csr -config csr.conf
    ```

5. Signs Certificate Signing Request with Certificate Authority to make the certificate. 

    ``` bash
    openssl x509 -req -in server.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out server.crt -days 3650 -sha256 -extfile cert.conf
    ```

6. Creates a PFX file that connects the private key, server certificate, and root Certificate Authority.  You will be prompted to make a password, and you will use that same one when creating a domain

    ``` bash
    winpty openssl pkcs12 -export -out vprodemo_custom.pfx -inkey server.key -in server.crt -certfile rootCA.crt
    ```

7. This will give you the SHA1 hash of your certificate. 

    ``` bash
    openssl x509 -noout -fingerprint -sha1 -inform pem -in rootCA.crt
    ```

    !!! success "Success - SHA1 Output"
        <figure class="figure-image">
        <img src="..\..\..\assets\images\SHA1.png" alt="Figure 1: SHA1 Output">
        <figcaption>Figure 1: SHA1 Output</figcaption>
        </figure>
        

## Upload Provisioning Certificate

!!! warning "Warning - Adding Hash in AMT 16"
    These steps may not be exact within MEBx on AMT 16 or newer devices.

There should now be a new certificate in the form of .pfx file. Check file explorer to confirm this.

### Create Domain Profile

1. Open the Sample Web UI.

2. Create a domain profile. Upload the .pfx file and enter the password set for it. See [Create a Domain Profile](.././../GetStarted/createProfileACM.md#create-a-domain-profile) for more details. 

### Inject the Hash

1. Switch to the AMT device. It must be in **pre-provisioning** mode.

2. Enter MEBx. Restart or power on the device.

3. While the device is booting up, press **Ctrl+P** to reach the MEBX login screen. 

    ??? note "Note - Other Keybinds to Enter MEBx"
        The keystroke combination **Ctrl+P** typically invokes the BIOS to display the MEBX login screen. If this does not work, check the manufacturer's instructions or try function keys (e.g., F2, F12).

3. Enter the MEBx password.

    ??? note "Note - Default MEBx Password for First Time Use"
        If it is the first time entering MEBX and the device has not been provisioned previously, the default password is `admin`. Create a new password when prompted.

4. Set the DNS suffix. See [DNS Suffix](../MEBX/dnsSuffix.md) for more details. 

5. Under **Remote Setup and Configuration**, choose **Manage Hashes**.
    
    <figure class="figure-image">
    <img src="..\..\..\assets\images\Manage_Hashes.jpg" alt="Figure 2: Manage Hashes">
    <figcaption>Figure 2: Manage Hashes</figcaption>
    </figure>

6. Provide a name for the new hash.

7. Press **Insert** key.

    Insert the new SHA1 hash using the fingerprint obtained from Step 6 in [Create the Certificate and Hash](#create-the-certificate-and-hash). 

    <figure class="figure-image">
    <img src="..\..\..\assets\images\MEBXHASH.jpg" alt="Figure 3: Hash Input">
    <figcaption>Figure 3: Hash Input</figcaption>
    </figure>

8. Save and Exit MEBx. 

9. After rebooting, open Command Prompt as Administrator.

10. Verify the Hash was inserted correctly.

    === "Linux"
        ``` bash
        sudo ./rpc amtinfo -cert
        ```
    === "Windows"
        ```
        .\rpc amtinfo -cert
        ```

    !!! success "Success - Hash Inserted Correctly"
        <figure class="figure-image">
        <img src="..\..\..\assets\images\HASH_OUTPUT.png" alt="Figure 4: Hash Output">
        <figcaption>Figure 4: Hash Output</figcaption>
        </figure>

11. Activate the AMT device with an ACM Profile.

<br><br>