--8<-- "References/abbreviations.md"
	
## Generating a custom provisioning cert 

We recommend obtaining a provisioning certificate as we have outline how to do [here](https://open-amt-cloud-toolkit.github.io/docs/2.13/GetStarted/createProfileACM/#what-youll-need). However if you are in need of a custom provisioning certificate for some reason, we outline how to generate one below. 

## How to generate a custom provisioning certificate? 

To begin generating a provisioning certificate the open source command line tool, OpenSSL, is required. OpenSSL can be used in areas of cryptography, enctyption, and digital signatures. 

If you have already gone through and downloaded the necessary prequisites from the ["Getting Started Guide"](https://open-amt-cloud-toolkit.github.io/docs/2.13/GetStarted/prerequisites/), specifically "git*", then all you have to do is search for "git bash" on your machine and open the terminal and you will be able to access OpenSSL from there. 

You will also need to prepare two files, cert.conf and csr.conf file.  

**cert.conf**: This is the certificate configuration file. It is used primarily for to define specific settings for the certificate. 

!!! example file
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
**csr.conf**: This is the certificate signing request configuration file. It is meant for information related to identification . 

!!! example file
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
### Steps 

There are 6 key commands to run when trying to generate your certificate. 

1. openssl req -x509 -sha256 -days 3560 -nodes -newkey rsa:2048 -subj "//SKIP=skip/CN=CA Custom Root Certificate/C=US/ST=Arizona/L=Chandler" -keyout rootCA.key -out rootCA.crt

2. openssl genrsa -out server.key 2048

3. openssl req -new -key server.key -out server.csr -config csr.conf

4. openssl x509 -req -in server.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out server.crt -days 3650 -sha256 -extfile cert.conf

5. winpty openssl pkcs12 -export -out vprodemo_custom.pfx -inkey server.key -in server.crt -certfile rootCA.crt  **You will be prompted to make a password, and you will use that same one when creating a domain**

6. openssl x509 -noout -fingerprint -sha1 -inform pem -in rootCA.crt. **This will give you the SHA1 hash of your certificate** 

## How to use the generated custom provisioning certificate? 

You should now have your new certifcate in the form of .pfx file. You can check your file explorer to confirm this. 

1. Now following the steps to activcate a profile in ACM listed out in the ["Getting Started Guide"](https://open-amt-cloud-toolkit.github.io/docs/2.13/GetStarted/loginToUI/) to login to the Sample Web UI, create a CIRA config, create a profile, and create a domain. 

2. When creating the domain, upload the .pfx file you have created and enter the password you set for it. 

3. Now moving to your dev maching, make sure your device is deactivated and is in pre-proivisioning mode. You will then want to go back to the [MEBX login screen](https://open-amt-cloud-toolkit.github.io/docs/2.13/Reference/MEBX/dnsSuffix/?h=dns+suffix) and back to Remote Setup and Configuration -> TLS PKI, and in there should be an option to configure hash values.  

4. Insert a new SHA1 hash using the fingerprint you obtained from command 6. The hash can be named anything you like, just make sure the entering of the actual numbers follows the format shown below **(Figure 1)**

5. Once this is done go ahead and boot up your dev machine and open a administrator command prompt window. There you can run **.\rpc.exe amtinfo -cert** and you should see your cert somewhere in the list **(Figure 2)**

6. Then go ahead and activate your machine in admin control mode with the profile, CIRA config, and domain you've set up and it should sucessful configure. 

<figure class="figure-image">
<img src="..\..\..\assets\images\MEBXHASH.jpg" alt="Figure 1: Hash Input">
<figcaption>Figure 1: Hash Input</figcaption>
</figure>

<figure class="figure-image">
<img src="..\..\..\assets\images\HASH_OUTPUT.png" alt="Figure 2: Hash Output">
<figcaption>Figure 2: Hash Output</figcaption>
</figure>






