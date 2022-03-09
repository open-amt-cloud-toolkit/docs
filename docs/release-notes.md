--8<-- "References/abbreviations.md"
# Release Notes

## Feature Changes for 2.2
This section outlines key features changes between versions 2.1 and 2.2 for Open AMT Cloud Toolkit.

*Insert Release Video Here*

### Noteworthy Features and Changes
**Major Refactoring & WSMAN-MESSAGES Library:** Starting at the end of 2021, the team took on a major task of refactoring some of the deeper parts of our code.  This part of the code was fundamental in how the rest of the Open AMT Cloud Toolkit talked to Intel&reg; AMT devices. Much of this code was inherited from another open source project also developed at Intel.  While this inherited code is well validated and stable, it is also very difficult to use automated testing tools to validate when changes are required.  For those who care about code coverage indicators when assessing if they should use open source libraries, this made the Open AMT Cloud Toolkit an unattractive solution.  With these factors in mind, we created [WSMAN-MESSAGES](https://github.com/open-amt-cloud-toolkit/wsman-messages) a portable and testable library that handles the creation of wsman based messages for talking to Intel&reg; AMT devices.  Wsman-Messages is used by both MPS and RPS is available on NPM as [@open-amt-cloud-toolkit/wsman-message](https://www.npmjs.com/package/@open-amt-cloud-toolkit/wsman-messages).  Developers can independently make use of this library if they want to create and send messages to Intel&reg; AMT devices.  The net result from this refactoring effort is that code coverage in MPS went from 24% to 91% and RPS went from 29% to 70%.  This is a huge leap in reducing the overall technical debt of the project and should provide our customers with more confidence adopting the Open AMT Cloud Toolkit.  As we move forward, we'll continue to work towards our goal of 80% code coverage across all repositories and these additional improvements will happen through the course of our normal release cadence.

**Device Migration:** Through working with our customers, we've had several requests for a way to move an Intel&reg; AMT device from one management console to the the Open AMT Cloud Toolkit.  With 2.2, you can perform this migration with RPC by using the activate command and provide the profile you wish to use to activate the device.  By providing the AMT credential at the prompt, RPS will use this credential to add the device to Open AMT Cloud Toolkit and then apply the configuration profile, completing the migration without needing to deactivate the device.

**Healthcheck API:** This new API provides you the ability to check the status of MPS and RPS to know that they have a connection with both the database and secret provider.  This is particularly helpful when Open AMT Cloud Toolkit is deployed in Kubernetes or Docker Swarm so that you know they are up and ready to respond to requests.

**RPC -json flag:** We have added a new -json flag to the RPC application.  This will convert the output to json format making the output machine parsable.  Big thanks to [Portainer](https://www.portainer.io/) for this contribution!

### Additions, Modifications, and Removals
#### Breaking Changes
#### Changes to /AMT routes
- Method property is removed from wsman header in response and is now a property of the wsman body

    before:
    ``` json
    "responses": {
                "Header": {
                    "To": "http://schemas.xmlsoap.org/ws/2004/08/addressing/role/anonymous",
                    "RelatesTo": "1",
                    "Action": "http://schemas.xmlsoap.org/ws/2004/09/transfer/GetResponse",
                    "MessageID": "uuid:00000000-8086-8086-8086-0000000000FA",
                    "ResourceURI": "http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/CIM_ComputerSystemPackage",
                    "Method": "CIM_ComputerSystemPackage"
                },
                "Body": {
                    "Antecedent": {
    ```
    after:
    ``` json
    "responses": [
                {
                    "Header": {
                        "To": "http://schemas.xmlsoap.org/ws/2004/08/addressing/role/anonymous",
                        "RelatesTo": 0,
                        "Action": "http://schemas.xmlsoap.org/ws/2004/09/transfer/GetResponse",
                        "MessageID": "uuid:00000000-8086-8086-8086-000000000002",
                        "ResourceURI": "http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/CIM_ComputerSystemPackage"
                    },
                    "Body": {
                        "CIM_ComputerSystemPackage": {
                            "Antecedent": {
    ```
- SelectorSet values no longer includes @name and Value properties
- While these technically constitute a breaking change, ultimately we decided to NOT rev the major version of the toolkit as we felt these changes have minimal impact. We will be revamping the /AMT routes in a future version and will rev to 3.x at that time
#### Open AMT Cloud Toolkit
- deployment: update to use dockerhub imgs 
- dep: update k8s helm dependencies to support v1.22
- healthcheck: adds healthcheck to docker-compose
- see changelog for full list of changes
#### RPS
- **activation:** add already activated device to toolkit ([#476](https://github.com/open-amt-cloud-toolkit/rps/issues/476)) (#ae11da5) 
- **healthcheck:** provides API Route for status of vault and db (#9572d85) 
- verifies amt password if device is already activated and exists in toolkit ([#478](https://github.com/open-amt-cloud-toolkit/rps/issues/478)) (#ecbdb96) 
- **cira:** randomly generate environment detection ([#554](https://github.com/open-amt-cloud-toolkit/rps/issues/554)) (#484a927)
- **activator:** adds wmsan_messages and unit tests ([#541](https://github.com/open-amt-cloud-toolkit/rps/issues/541)) (#68f96a9) 
- **activator:** optimize code readability (#67e5950) 
- **cira:** adds wsman-messages and unit tests ([#567](https://github.com/open-amt-cloud-toolkit/rps/issues/567)) (#841bfb1) 
- **clientManager:** simplify client manager ([#563](https://github.com/open-amt-cloud-toolkit/rps/issues/563)) (#05b7180) 
- **deactivator:** adds wmsan_messages and unit tests ([#545](https://github.com/open-amt-cloud-toolkit/rps/issues/545)) (#36f97d5) 
- **dto:** convert AMTdeviceDTO from class to interface type in /models (#a517218) 
- **maintenance:** adds wmsan_messages and unit tests ([#559](https://github.com/open-amt-cloud-toolkit/rps/issues/559)) (#9907289) 
- **network:** adds wsman-messages and unittests (#0f147f4) 
- **node-forge:** migrate base64 encode/decode to use Buffer instead of node forge ([#555](https://github.com/open-amt-cloud-toolkit/rps/issues/555)) (#4873f89) 
- **randPass:** removes '&' from server side random password generation (#dfc813a) 
- **routes:** rename route filenames and add test skeletons (#8715943) 
- **rps:** remove node-vault This PR replaces node-vault with standard REST calls to vault using got. (#0385eab) 
- **test:** move tests to live alongside file (#7005c38) 
- **tls:** removes use of js amt-libraries (#4c1074a)
- see change log for full list of changes
#### MPS
- **healthcheck:** adds API endpoint for healthcheck (#5085569) 
- CIRA race condition and add 30 sec keepalive time (#f84f6a2) 
- **api:** connection status query parameter now matches API docs for devices (#3091294) 
- **api:** removed common tag envelope from AMT responses ([#481](https://github.com/open-amt-cloud-toolkit/mps/issues/481)) (#eb8603f) 
- **api:** updated return value code with value type (#5124aa1) 
- **api:** reverts auditlog field names back to being capitalized (#ff15aa8) 
- **cira:** close cira channel after request (#6738d7b) 
- **cira:** clears the wsman response messages once parsed ([#468](https://github.com/open-amt-cloud-toolkit/mps/issues/468)) (#2187eeb) 
- **cira:** handle chunked http message (#2c44300) 
- **test:** added unit test for secret manager ([#436](https://github.com/open-amt-cloud-toolkit/mps/issues/436)) (#bed8025) 
- **test:** added unit test for db(pg) ([#430](https://github.com/open-amt-cloud-toolkit/mps/issues/430)) (#ecc42f7) 
- **amt_models:** matching case ([#453](https://github.com/open-amt-cloud-toolkit/mps/issues/453)) (#3071866) 
- **api:** updates audit log to leverage refactored device connection (#52044e7) 
- **api:** get version uses new amt libraries ([#446](https://github.com/open-amt-cloud-toolkit/mps/issues/446)) (#977ba3d) 
- **api:** general settings uses new amt library ([#456](https://github.com/open-amt-cloud-toolkit/mps/issues/456)) (#722975c) 
- **api:** updates audit log and adds unit tests for it to connected devices (#9adf30f) 
- **api:** get amt features was missing userConsent property (#c29cee4) 
- **api:** set amt features uses new CIRA connection (#7087eb3) 
- **api:** user consent ([#458](https://github.com/open-amt-cloud-toolkit/mps/issues/458)) (#04d9923) 
- **api:** update getAMTFeatures to use new CIRA connections (#019895e) 
- **api:** power actions leverage new connection libraries (#6806237) 
- **api:** updated event log ([#463](https://github.com/open-amt-cloud-toolkit/mps/issues/463)) (#2438bbd) 
- **api:** hardware information ([#460](https://github.com/open-amt-cloud-toolkit/mps/issues/460)) (#48f4576) 
- **cira:** fix cira channel distruption across multiple API Calls (#ef4fdb8) 
- **cira:** remove javascript libraries and leverage new refactored AMT libraries (#fa68566) 
- **logging:** centralizes logging and mqtt messages into messages.ts (#de32b04) 
- **logging:** fixes spelling mistakes (#d0f9a4b) 
- **mps:** remove node-vault (#9d4963e) 
- **power:** use new device handling (#27c5c28) 
- **websockets:** KVM and SOL now use new CIRA connection (#e075539) 
- **wsman:** use new dependency wsman-message (#2f0c65c) 
- see change log for full list of changes
#### RPC-Go
- **activate:** prompts for password when device is activated
- **cli:** Remove ControlModeRaw from json
- **cli:** Add json flag to version command
- **log:** adds -json option to all rpc commands
- **output:** adds json output for amtinfo command
- update password with user input
- **pthi:** converts amt and pthi commands to go from C
- see change log for full list of changes
#### Sample Web UI
- see change log for full list of changes (no feat, fix, or refactor changes)
#### UI Toolkit
- upgrade ws from 8.4.2 to 8.5.0 (#228166b)
- **npm:** add job to publish to npm (#33bdf7e) 
- **semantic-release:** adds automated releases (#fde186b)
- see change log for full list of changes
#### WSMAN-MESSAGES
*Expect this set of libraries to version up very fast as we continue to enhance its capabilities to support the rest of the Open AMT Cloud Toolkit.  Since this is new, adding the full set of changes since 1.0.0.*
#### v2.0.1 - 2022-03-02
- **AMT:** update wifi_port naming convention ([#86](https://github.com/open-amt-cloud-toolkit/wsman-messages/issues/86)) (#4d2830d) 
#### v2.0.0 - 2022-03-02
- **tls-configuration:** add support for TLS Connection type (#0bcddb6) 
##### BREAKING CHANGE
- messageID is no longer passed in to functions and is tracked internally
#### v1.7.0 - 2022-02-24
- **general-settings:** adds PUT method for AMT_GeneralSettings (#f39c0df) 
#### v1.6.0 - 2022-02-23
- **amt:** adds WiFiPortConfigurationService to amt. (#d2a2f0e) 
#### v1.5.0 - 2022-02-15
- **amt:** adds delete method to ManagementPresenceRemoteSAP and PublicKeyCertificate (#919794e) 
#### v1.4.1 - 2022-02-08
- **exports:** align exports with expected types from breaking change in PR[#29](https://github.com/open-amt-cloud-toolkit/wsman-messages/issues/29) (#99e1ea7) 
#### v1.4.0 - 2022-02-07
- **amt:** adds AMT Authorization and Time Synchronization services (#747988d) 
#### v1.3.1 - 2022-02-03
- **ips:** updates methods and actions for HostBasedService ([#66](https://github.com/open-amt-cloud-toolkit/wsman-messages/issues/66)) (#f777de0) 
#### v1.3.0 - 2022-02-02
- **cim:** adds WiFiPort method ([#62](https://github.com/open-amt-cloud-toolkit/wsman-messages/issues/62)) (#faf4aac) 
#### v1.2.0 - 2022-01-31
- **ips:** adds methods to HostbasedSetupService (#1f196f1) 
#### v1.1.0 - 2022-01-25
- **amt:** adds Unprovision and SetMEBXPassword methods to setup and configuration service (#8cff7c0) 
- **codecov:** sets acceptable range to 99-100 (#a95ffa3) 
#### v1.0.0 - 2022-01-07
- initialize workflow (#ede3a3d) 
- add cp step for package.json (#7223e97) 
- **badge:** adds badges ([#20](https://github.com/open-amt-cloud-toolkit/wsman-messages/issues/20)) (#dd036ca) 
- **badge:** adds snyk and codecov ([#21](https://github.com/open-amt-cloud-toolkit/wsman-messages/issues/21)) (#747b9df) 
- **build:** remove dist folder (#7bb6840) 
- **release:** remove step (#94ce849) 
- **release:** update release to build (#6dec446) 
- **release:** add step (#b1ba3e3) 
- **semantic-release:** adds automation for releasing (#114517e) 
- **semantic-release:** fixes workflow name (#817c9dc) 
- **semantic-release:** change pkgRoot to dist (#579e722) 
- **semantic-release:** updates comment (#ed4b16e) 
- **workflow:** optimizes node CI (#ae84187) 
- renames AMT, CIM, IPS classes to Messages (#4470042) 
- models and exports now under respective calls AMT, IPS, CIM (#a89ab8d) 
- **wsman:** initial migration (#94e261e) 

## Resolved Issues
#### RPS
- **[AMT Wi-Fi Configuration not supported on non-Windows systems](https://github.com/open-amt-cloud-toolkit/rps/issues/349):** Known Issue
- **[Remove mpsRootCertificate parameter from createCiraConfig route](https://github.com/open-amt-cloud-toolkit/rps/issues/461):** Question
#### MPS
- **[req.query.$status should be req.query.status instead in src/routes/devices/getAll.ts](https://github.com/open-amt-cloud-toolkit/mps/issues/508):** Bug
- **[Audit Log calls never respond on specific versions of AMT](https://github.com/open-amt-cloud-toolkit/mps/issues/301):** Known Issue
#### RPC-Go
- **[json output](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/22):** Enhancement
- **[Invalid comment lines on Dockerfile](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/18):** Bug


## Open Issues and Requests
#### Open AMT Cloud Toolkit
- **[Kustomize Install](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/103):** Enhancement
- **[After proxy, where to config the proxy or change the npm repository before docker-compose?](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/110):** Documentation
- **[More explanation over documentation](https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues/112):** Documentation
#### RPS
- **[RPS should support wildcard domain suffix](https://github.com/open-amt-cloud-toolkit/rps/issues/97):** Enhancement
- **[Data shouldn't be added if vault calls fail](https://github.com/open-amt-cloud-toolkit/rps/issues/254):** Bug
- **[Use database abstraction/ORM layer to support multiple SQL-based database](https://github.com/open-amt-cloud-toolkit/rps/issues/414):** Enhancement
- **[Use database abstraction/ORM layer to support multiple SQL-based database](https://github.com/open-amt-cloud-toolkit/rps/issues/414):** Enhancement
- **[Support Intel AMT Alarm Clock feature](https://github.com/open-amt-cloud-toolkit/rps/issues/524):** Enhancement
#### MPS
- CIM_PhysicalPackage may not return all results compared to v2.1
- **[Direct Connection from MPS to AMT](https://github.com/open-amt-cloud-toolkit/mps/issues/10):** Enhancement
- **[Should return error on additional KVM connections for a single device](https://github.com/open-amt-cloud-toolkit/mps/issues/104):** Enhancement
- **[AMT does not connect to MPS after configuration](https://github.com/open-amt-cloud-toolkit/mps/issues/300):** Known Issue
- **[Use database abstraction/ORM layer to support multiple SQL-based database](https://github.com/open-amt-cloud-toolkit/mps/issues/360):** Enhancement
- **[Feature Request: Create configuration parameter to disable "Auth" Service from MPS](https://github.com/open-amt-cloud-toolkit/mps/issues/439):** Enhancement
- **[CIRA connection getting dropped randomly](https://github.com/open-amt-cloud-toolkit/mps/issues/441):** Bug
- **[Short Lived Bearer Token for KVM Session Support](https://github.com/open-amt-cloud-toolkit/mps/issues/527):** Enhancement
- **[Allow filtering devices by hostname](https://github.com/open-amt-cloud-toolkit/mps/issues/548):** Enhancement
#### Sample Web UI
- **[UI always shows "Certificate Not Yet Uploaded"](https://github.com/open-amt-cloud-toolkit/sample-web-ui/issues/483):** Question
#### UI Toolkit
- **[Command string generated from "Add a New Device" dialog does not activate a machine.](https://github.com/open-amt-cloud-toolkit/ui-toolkit/issues/451):** Bug


