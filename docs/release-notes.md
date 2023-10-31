--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center;">
 <iframe width="800" height="450" src="https://www.youtube.com/embed/mSkvJuKCQPE?si=BU4n8IcL6-woFgzM" title="Open AMT October Release Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

!!! note "Note From the Team"
    
    Happy Halloween!

    No tricks in this release, just new treats coming to Open AMT Cloud Toolkit!  Make sure to checkout Bryan's video where he talks about the new changes in this release or you can get the details in the "What's New" section.  You can follow our day to day progress over at our new Sprint Planning project board (link at the bottom)! 

    We are genuinely excited about this release and are eager to hear your valuable feedback. Your input plays a crucial role in enhancing the Open AMT Cloud Toolkit further.

    *Best wishes,*  
    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-update: **DB Update Required**

Run the following SQL scripts to add the new required columns for both the `mpsdb` and `rpsdb`.

``` sql title="mpsdb"
ALTER TABLE devices
ADD COLUMN IF NOT EXISTS deviceInfo json;
```

The goal of this change is to allow us to cache some of the AMTINFO data that we gather while activating a device in the database and make that available to API callers when a device is not connected to the MPS. 

``` sql title="rpsdb"
ALTER TABLE domains
ADD COLUMN IF NOT EXISTS expiration_date timestamp;
```

[More information or detailed steps can be found in Upgrade Toolkit Version.](./Deployment/upgradeVersion.md)

:material-new-box: **New Feature: Offline AMT Data**

Along with the DB update this release, we are now storing some basic AMT data in the database.  When activating an AMT device, this data will automatically collected and stored.  We've also added a new maintenance command `syncdeviceinfo` to RPC-Go that will collect and update this information.  Read more about this feature in our [docs](https://open-amt-cloud-toolkit.github.io/docs/2.16/Reference/RPC/commandsRPC/#syncdeviceinfo)

:material-new-box: **New Feature: Certificate Expiration Checking**

When provisioning certificates are added to Open AMT Cloud Toolkit, the software will now get the expiration date of the certificate and store that in the database.  This data is then returned when a GET call to Domains is made.  This information makes it easy to determine if a certificate is about to expire or already expired.  The Sample Web UI has an implementation showing this capability in this release.

:material-new-box: **New Feature: Fetch Provisioning Certificates During -local Activation**

A new option has been provided for ACM `-local` activation flows.  Users can now store their provisioning certificate and credentials securely on a network share and point RPC-Go to fetch this information during activation.  

## Get the Details

### Additions, Modifications, and Removals

#### RPS

v2.18.0

- feat: add device info maintenance ([#1277](https://github.com/open-amt-cloud-toolkit/rps/issues/1277))

v2.17.1

- fix: store dnssuffix into db ([#1256](https://github.com/open-amt-cloud-toolkit/rps/issues/1256))

v2.17.0

- feat: save additional values to mps mongo db ([#1236](https://github.com/open-amt-cloud-toolkit/rps/issues/1236))


#### MPS

v1.12.4

- fix(redir): improve data checking for redirection ([7aa1510](https://github.com/open-amt-cloud-toolkit/mps/commit/7aa151099baf43a565dae003ac45d444ea7a2b4e))

v1.12.3

- fix: fixed mongo device deletion ([#1100](https://github.com/open-amt-cloud-toolkit/mps/issues/1100))

v1.12.2

- fix: Remove data from Mongo on deactivation ([#1118](https://github.com/open-amt-cloud-toolkit/mps/issues/1118))

v1.12.1

- fix: redirection token expiration and device UUID check ([#1098](https://github.com/open-amt-cloud-toolkit/mps/issues/1098))


#### RPC

v2.18.0

- feat: add device info maintenance ([e302f8a](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/e302f8aec00222651867b5977dafc419627ae778))

v2.17.0

- feat: add features field to message payload ([61s9829](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/61a9829a8a4303600816b6ce629b07d142d7a144))

#### Sample Web UI

v2.15.0

- feat: adds exp date to domain certs 


## Project Boards

Check out our new [Sprint Planning](https://github.com/orgs/open-amt-cloud-toolkit/projects/10/views/2) project board to see what stories the dev team is actively working on, what is in our backlog, and what is planned for the next sprint.
