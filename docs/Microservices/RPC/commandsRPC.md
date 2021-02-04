
RPC is primarily used for communicating with the Remote Provision Server (RPS) for activating and/or deactivating AMT devices. Additional optional arguments allow for things such as easier development testing or for use in network environments utilizing proxies.

All currently available arguments and their definitions are listed below along with example commands. 

### RPC Usage
On Windows:
``` bash
rpc <required> [optional]
rpc <informational>
```

On Linux:
``` bash
sudo ./rpc <required> [optional]
./rpc <informational>
```

### RPC Arguments

#### Required

| Argument&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | Name &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | Description |
| :------------------------- | :--------------------- | :---------- |
| -c, --cmd &lt;command&gt;  | Server Command         | Activate or Deactivate command for AMT device. See example commands below. |
| -u, --url &lt;url&gt;      | Websocket Server       | Address and Port of the RPS server, wss://localhost:8080. By default, RPS runs on port 8080. |

##### Examples
Activate a Device:
``` bash
rpc --url wss://localhost:8080 --cmd "-t activate --profile profile1"
```

Deactivate a Device:
``` bash
rpc -u wss://localhost:8080 -c "-t deactivate --password P@ssw0rd"
```

!!! note
	The --password nested argument uses the AMT password set at the time of provisioning of the device based on the RPS Profile. This password should be able to be retrieved from Vault, if unknown.


<br>

#### Optional

| Argument&emsp;&emsp;&emsp;&emsp; | Name&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;   | Description |
| :------------------------- | :----------------------- | :---------- |
| -d, --dns &lt;dns&gt;      | DNS Suffix Override      | |
| -n, --nocertcheck          | Certificate Verification | Disable certificate verification. Allows for the use of self-signed certificates during development testing. Not valid for production. Otherwise, a TLS Certificate from a trusted Certificate Authority provider is required. |
| -p, --proxy &lt;addr&gt;   | Proxy Address and Port   | Allow for connection through a network proxy, http://proxy.com:1000 |
| -v, --verbose              | Verbose Output           | Display WSMan communication with RPS when executing RPC |

##### Examples

Override DNS detection and Activate device:
```
rpc --url wss://localhost:8080 --cmd "-t activate --profile profile1" --dns corp.com
```

Connect through proxy and Deactivate device:
```
rpc -u wss://localhost:8080 -c "-t deactivate --password P@ssw0rd" -p http://proxy.com:1000
```


<br>

#### Informational

| Argument                   | Name                   | Description |
| :------------------------- | :--------------------- | :---------- |
| --help                     | Help text              | Display help menu in-line |
| --version                  | Version                | Current version of RPC |
| --amtinfo &lt;item&gt;     | AMT info               | View available information<br><br>**Possible Parameters:**<br>all - View all items<br>ver - BIOS version<br>bld - Build number<br>sku - Product SKU<br>uuid - [Device's Unique Identifier](../../Topics/guids.md)<br>mode - Current Control Mode, ACM or CCM<br>dns - Domain Name Suffix from AMT and from OS<br>fqdn - Fully aualified domain name and device hostname from OS<br>cert - Certificate hashes<br>ras - Remote access status<br>lan - LAN settings, i.e. DHCP Enabled, Link Status, and IP/MAC Addresses     |

##### Examples

View All Information Items:
``` bash
rpc --amtinfo all
```

Find Current Device's GUID:
``` bash
rpc --amtinfo uuid
```