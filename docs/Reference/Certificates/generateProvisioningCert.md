--8<-- "References/abbreviations.md"

For production deployments, we highly recommend purchasing a 3rd party provisioning certificate. [See all available vendors here.](./remoteProvisioning.md#purchase) 

However, some developers opt to use a custom provisioning certificate for testing and validation purposes.

!!! warning "Warning - Custom Provisioning Certificates in Production Deployments"
    The hash of custom provisioning certificates must be manually added to all devices that will be configured into ACM. This can be done through MEBx or USB Configuration. Both options require manual, hands-on configuration of each AMT device. **Adding the hash to AMT's trusted list is a mandatory requirement for the device to successfully activate.**
    
The steps below outline how to generate a custom certificate based on the requirements within the [Intel® AMT SDK](https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/WordDocuments/acquiringanintelvprocertificate.htm).

## Generate Custom Provisioning Certificate 

### What You'll Need

**Software** 

- [OpenSSL](https://www.openssl.org/)

### Configuration Files

First, we need to prepare two files:

- **cert.conf** - Certificate configuration file. It is used to define the specific settings for the certificate.
- **csr.conf** - Certificate signing request configuration file. 

#### Create `cert.conf`

1. Create a new file named `cert.conf`.

2. Copy and paste the below example into the file.

    - Do not remove the OID 2.16.840.1.113741.1.2.3 from the **extendedKeyUsage**. 

3. Save and close.

!!! example "Example - `cert.conf`"
    ```
    basicConstraints = CA:FALSE
    subjectKeyIdentifier = hash
    authorityKeyIdentifier = keyid,issuer:always
    keyUsage = digitalSignature, keyEncipherment
    extendedKeyUsage = serverAuth, 2.16.840.1.113741.1.2.3 
    subjectAltName = @alt_names
    
    [alt_names]
    DNS.1 = example.domain
    DNS.2 = test.domain
    IP.1 = 192.168.1.1
    ```

#### Create `csr.conf`

1. Create a new file named `csr.conf`.

2. Copy and paste the below example into the file.

    - For the **CN** field, make sure to change it to your server's FQDN. For example: 
    
    ```
    CN = intel.vprodemo.com
    ```

3. Save and close.

!!! example "Example - `csr.conf`"
    ```
    [ req ]
    default_bits = 2048
    prompt = no
    default_md = sha256
    distinguished_name = dn

    [ dn ]
    C = US
    ST = Arizona
    L = Chandler 
    O = Example Organization
    OU = Department
    CN = www.example.com 
    ```
### Create the Certificate and Hash 

1. Open a terminal and verify OpenSSL is installed.

    ``` bash
    openssl version
    ```

2. Create a self-signed CA root certificate file named `rootCA.crt` with a key file named `rootCA.key`.

    ``` bash
    openssl req -x509 -sha256 -days 3560 -nodes -newkey rsa:2048 -subj "//SKIP=skip/CN=CA Custom Root Certificate/C=US/ST=Arizona/L=Chandler" -keyout rootCA.key -out rootCA.crt
    ```

3. Generate a RSA private key named **server.key**.

    ``` bash
    openssl genrsa -out server.key 2048
    ```

4. Generate a Certificate Signing Request using the private key and `cert.conf` file.

    ``` bash
    openssl req -new -key server.key -out server.csr -config csr.conf
    ```

5. Sign the Certificate Signing Request with the CA certificate and `cert.conf` file.

    ``` bash
    openssl x509 -req -in server.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out server.crt -days 3650 -sha256 -extfile cert.conf
    ```

6. Create a `.pfx` file using the private key, server certificate, and CA root certificate. It will prompt to create a password. This password will be used when creating a Domain profile.

    ``` bash
    openssl pkcs12 -export -out vprodemo_custom.pfx -inkey server.key -in server.crt -certfile rootCA.crt
    ```

7. Get the SHA1 hash of the root certificate. 

    ``` bash
    openssl x509 -noout -fingerprint -sha1 -inform pem -in rootCA.crt
    ```

    !!! success "Success - SHA1 Output"
        ```
        SHA1 Fingerprint=51:45:E3:A4:AE:66:88:E0:AF:85:EC:EB:06:74:6B:8D:C3:07:C1:9D
        ```
        

## Upload Provisioning Certificate

### Create Domain Profile

1. Open the Sample Web UI.

2. Create a domain profile. Upload the `.pfx` file and enter the password set for it. See [Create a Domain Profile](../../GetStarted/createProfileACM.md#create-a-domain-profile) for more details. 

### Insert the Hash using MEBx

!!! warning "Warning - Adding Hash for AMT 16"
    These steps may not be exact or available within MEBx on AMT 16 or newer devices. USB Configuration may be required. 

1. Switch to the AMT device.

2. Restart the device. While the device is booting up, press **Ctrl+P** to reach the MEBX login screen.

    ??? note "Note - Other Keybinds to Enter MEBx"
        The keystroke combination **Ctrl+P** typically invokes the BIOS to display the MEBX login screen. If this does not work, check the manufacturer's instructions or try function keys (e.g., F2, F12)

3. Enter the MEBx password.

    ??? note "Note - Default MEBx Password for First Time Use"
        If it is the first time entering MEBX and the device has not been provisioned previously, the default password is `admin`. Create a new password when prompted

4. Select **Intel(r) AMT Configuration**.

5. Verify that the device is in **pre-provisioning** mode. If not, perform a full unprovision under **Unconfigure Network Access**.

6. Select **Remote Setup and Configuration**.

7. Select **TLS PKI**.

8. Set the **PKI DNS suffix** if DHCP option 15 is not set in the DHCP server. See [DNS Suffix](../../GetStarted/createProfileACM.md#dns-suffix) for more details.

9. Select **Manage Hashes**.
    
    <figure class="figure-image">
    <img src="..\..\..\assets\images\Manage_Hashes.jpg" alt="Figure 2: Manage Hashes">
    <figcaption>Figure 2: Manage Hashes</figcaption>
    </figure>

10. Press the `Insert` key.

11. Provide a name for the new hash and press Enter.

12. Insert the new SHA1 hash using the fingerprint obtained from Step 7 in [Create the Certificate and Hash](#create-the-certificate-and-hash). **The hash must be formatted as shown in example.**

    <figure class="figure-image">
    <img src="..\..\..\assets\images\MEBXHASH.jpg" alt="Figure 3: Hash Input">
    <figcaption>Figure 3: Hash Input</figcaption>
    </figure>

13. Press the `Y` key to set the hash as active.

14. Press the `esc` key repeatedly to exit MEBx.

### Verify the Hash

1. After the device reboots, open Terminal or Command Prompt as Administrator.

2. Verify the certificate hash was inserted correctly.

    The new hash should be listed.

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

3. Activate the AMT device with an ACM Profile.

<br><br>