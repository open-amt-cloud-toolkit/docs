
### RPC Usage
```
rpc <required> [optional]
rpc <informational>
```

### RPC Arguments

#### Required

| Argument                   | Name                   | Description |
| :------------------------- | :--------------------- | :-- |
| -c, --cmd &lt;command&gt;  | Server Command         | |
| -u, --url &lt;url&gt;      | Websocket Server       | |




#### Optional

| Argument       | Name                | Description |
| :------------------------- | :----------------------- | :-- |
| -d, --dns &lt;dns&gt;      | DNS Suffix Override      | |
| -n, --nocertcheck          | Certificate Verification | |
| -p, --proxy &lt;addr&gt;   | Proxy Address/Port       | |
| -v, --verbose              | Verbose Output           | |


#### Informatonal

| Argument       | Name                | Description |
| :------------------------- | :--------------------- | :-- |
| --help                     | Help text              | |
| --version                  | Version                | |
| --amtinfo &lt;item&gt;     | AMT info               | Items<br>all - all items<br>ver - version<br>bld - buildnumber    |<br>all items<br>BIOS version<br>buildnumber |
|                            | Items<br>all<br>ver<br>bld    |<br>all items<br>BIOS version<br>buildnumber |



  <!-- # Activate platform using profile1
  rpc --url wss://localhost:8080 --cmd "-t activate --profile profile1"

  # Activate platform using profile1 and override DNS detection
  rpc --url wss://localhost:8080 --cmd "-t activate --profile profile1" --dns corp.com

  # Deactivate platform and connect through a proxy
  rpc -u wss://localhost:8080 -c "-t deactivate --password P@ssw0rd" -p http://proxy.com:1000

  # Show all informational items
  rpc --amtinfo all -->