--8<-- "References/abbreviations.md"
## Release Highlights

<div style="text-align:center;">
 <iframe width="800" height="450" src="https://www.youtube.com/embed/U8D-WCgVD_4?si=23o5nqBL5X2nb1ly" title="Open AMT September Release Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

!!! note "Note From the Team"
    
    Greetings everyone,

    Fall is here and just like the changing of the seasons, this release contains the most recent changes to Open AMT Cloud Toolkit!  Make sure to checkout Bryan's video where he talks about the new changes in this release or you can get the details in the "What's New" section.  The team has some exciting new features we're working on in the month of October that we can't wait for you to see.  You can follow our day to day progress over at our new Sprint Planning project board (link at the bottom)! 

    We are genuinely excited about this release and are eager to hear your valuable feedback. Your input plays a crucial role in enhancing the Open AMT Cloud Toolkit further.

    *Best wishes,*  
    *The Open AMT Cloud Toolkit Team*


## What's New?

:material-update: **DB Update Required**

Run the following SQL script to alter constraints before upgrading the services.
``` SQL
ALTER TABLE domains
DROP CONSTRAINT IF EXISTS domains_pkey;
DROP INDEX CONCURRENTLY IF EXISTS lower_name_suffix_idx;
ALTER TABLE domains
ADD CONSTRAINT domainname UNIQUE (name, tenant_id);
ALTER TABLE domains
ADD PRIMARY KEY (name, domain_suffix, tenant_id);
```

:material-new-box: **New Feature: NoSQL Supported in MPS**

We've added NoSQL (not only SQL) DB support to MPS to aid with future unstructured device data that we'll be storing in the MPS DB.  To aid with this, we have implemented a new database interface using the MongoAPI in the src/data/mongo folder.  This has been tested against multiple MongoAPI compatible databases and works well without changes to our implementation.  We look forward to any feedback you have on this new capability

:material-new-box: **New Feature: Enhanced 'amtinfo' command**

We have updated RPC-Go's amtinfo command to allow users to better understand what certificates are currently in AMT.

- amtinfo -userCert flag allows you to retrieve certificates associated with specific AMT configuration options.  For example, the CIRA certificate, TLS certificates, or 802.1x certificates.

- amtinfo -cert flag now provides information about both system and user certificates.

:material-new-box: **New Feature: Sample UI Improvements**

We have made two improvements to the Sample UI in this release.

- **Edit Tags** You can now efficiently manage tags for individual systems and perform bulk tag changes across multiple systems via the Sample Web UI.

- **User Consent** The Sample Web UI now respects user consent settings in AMT, ensuring that it prompts for a user consent code even when the device is configured under Active Configuration Management (ACM)

## Get the Details

### Additions, Modifications, and Removals

#### RPS

v2.16.4

- fix: allow same domain suffix across tenants ([#1214](https://github.com/open-amt-cloud-toolkit/rps/issues/1214)) (#ef9cd45) 

v2.16.3

- fix state-machine: unconfigure continues on error for TLS deletions ([#1215](https://github.com/open-amt-cloud-toolkit/rps/issues/1215)) (#b68f168)

v2.16.2

- fix: - adds shouldRetry guards ([#1207](https://github.com/open-amt-cloud-toolkit/rps/issues/1207)) (#f17d28a)


#### MPS

v2.12.0

- feat: enable tenant check on AMT operations (#a4010b1)
- feat: add support for mongo compatible nosql databases ([#1066](https://github.com/open-amt-cloud-toolkit/mps/issues/1066)) (#18096bc) 


#### RPC

v2.16.0

- feat: adds uuid flag to activate command ([bae75fe](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/bae75fea35b4faa0258447ac1b10c7e078ce1f9b)), closes [#163](https://github.com/open-amt-cloud-toolkit/rpc-go/issues/163)

v2.15.2

- fix: trigger ci build for release with docker ([0bbbf78](https://github.com/open-amt-cloud-toolkit/rpc-go/commit/0bbbf78bc40abf72d7c0a2a8a98f1fd2b4b42306))

v2.15.1

- fix: add prompt for password acm local deactivation
- fix: addwifisettings validate unique priorities

v2.15.0

- feat: amtinfo display user certificates

#### Sample Web UI

v2.14.0

- feat: edit device tags

v2.13.2

- fix: version call now occurs after login (#a80ffb0)


#### go-wsman-messages

v1.8.4

- fix: handle qop="auth-int, auth" header ([2b5a4e6](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/2b5a4e6e4d1e7412bc9f0140925701d47a56245c))

v1.8.3

- fix wsman: authorize uri is always /wsman ([f2414f3](https://github.com/open-amt-cloud-toolkit/go-wsman-messages/commit/f2414f32eab5db593ceaaad8410a1a2a9e4815bb))

## Project Boards

Check out our new [Sprint Planning](https://github.com/orgs/open-amt-cloud-toolkit/projects/10/views/2) project board to see what stories the dev team is actively working on, what is in our backlog, and what is planned for the next sprint.

Check out our [Feature Backlog](https://github.com/orgs/open-amt-cloud-toolkit/projects/5) project board to see issues and prioritized items we're working on across all of our repositories.  You'll also see what is coming in our next release!
