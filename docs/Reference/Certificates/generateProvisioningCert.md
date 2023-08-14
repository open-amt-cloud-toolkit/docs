--8<-- "References/abbreviations.md"
	
We recommend obtaining a provisioning certificate as we have outline how to do [here](https://open-amt-cloud-toolkit.github.io/docs/2.13/GetStarted/createProfileACM/#what-youll-need). However if you are in need of a custom provisioning certificate for some reason, we outline how to generate one below. 

Why would I do it:
-
-
-

Drawbacks:
-
-
-

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

1. Update these fields with your information:

    ... give them what fields

2. Save and close.

!!! example "Example - `cert.conf`"
    ```
    basicConstraints = CA:TRUE
    subjectKeyIdentifier = random
    authorityKeyIdentifier = keyid,issuer:always
    keyUsage = nonRepudiation, cRLSign
    extendedKeyUsage = clientAuth, 2.16.840.1.113741.1.2.3 # Don't change this category 
    subjectAltName = @alt_names
    
    [alt_names]
    DNS.1 = example.domain
    DNS.2 = test.domain
    IP.1 = 192.168.1.1
    IP.2 = 10.0.0.1
    ```

#### Update `csr.conf`

1. Update these fields with your information:

    ... give them what fields

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
    CN=www.example.com # Make sure to change the CN to their server's FQDN
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

2. What does this do

    ``` bash
    openssl req -x509 -sha256 -days 3560 -nodes -newkey rsa:2048 -subj "//SKIP=skip/CN=CA Custom Root Certificate/C=US/ST=Arizona/L=Chandler" -keyout rootCA.key -out rootCA.crt
    ```

3. What does this do

    ``` bash
    openssl genrsa -out server.key 2048
    ```

4. What does this do

    ``` bash
    openssl req -new -key server.key -out server.csr -config csr.conf
    ```

5. What does this do

    ``` bash
    openssl x509 -req -in server.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out server.crt -days 3650 -sha256 -extfile cert.conf
    ```

6. What does this do  You will be prompted to make a password, and you will use that same one when creating a domain

    ``` bash
    winpty openssl pkcs12 -export -out vprodemo_custom.pfx -inkey server.key -in server.crt -certfile rootCA.crt
    ```

7. This will give you the SHA1 hash of your certificate. 

    ``` bash
    openssl x509 -noout -fingerprint -sha1 -inform pem -in rootCA.crt
    ```

    !!! success "Success - Hash Output"
        ```
        my cmd line hash output
        ```

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

5. Under **Remote Setup and Configuration**, choose **FIELDNAME**.

    **NEW PICTURE**

6. Provide a name for the new hash.

7. Press **Insert** key.

    Insert the new SHA1 hash using the fingerprint obtained from Step 6 in [Create the Certificate and Hash](#create-the-certificate-and-hash). 

    <figure class="figure-image">
    <img src="..\..\..\assets\images\MEBXHASH.jpg" alt="Figure 1: Hash Input">
    <figcaption>Figure 1: Hash Input</figcaption>
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
        <img src="..\..\..\assets\images\HASH_OUTPUT.png" alt="Figure 2: Hash Output">
        <figcaption>Figure 2: Hash Output</figcaption>
        </figure>

11. Activate the AMT device with an ACM Profile.

<br><br>