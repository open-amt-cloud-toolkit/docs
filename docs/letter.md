--8<-- "References/abbreviations.md"
## Hello Everyone! 

It is time for another release of the Open AMT Cloud Toolkit, v.1.3.0 is out now! This release will be the last before our targeted LTS release. As such, we've got a few more breaking changes in this release, so please read the release notes carefully if you haven't already.

In the last release, we greatly simplified the restful APIs on RPS. This time, we've simplified the restful APIs on MPS.  You can checkout the latest swagger docs here: [Swagger Docs](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/1.3.0). Previously, all the AMT calls were `POST` calls. We've now aligned them to be more semantic and in-line with the particular action being invoked. For example, retrieving(*getting*) the power state is now a `GET` call. While sending a power action remains a `POST` call. We feel organizing the APIs in this way makes it a bit easier to understand and also aligns our APIs to be more consistent with RPS.

We released a preview for AKS in the v1.2.0 release. Not much to update here for v1.3.0, we are still working on being a bit more cloud agnostic for the K8s deployment and updating the deployment for v1.3.0 is also in progress. So, with that said, stick with v1.2.0 if you wish to continue working with k8s. 

As mentioned in the release notes, stateless auth is one of our biggest changes for this release. Our primary reason for switching is to continue towards making our services as stateless as possible. The less state we have to manage the more easily we can scale up/down our services. Additionally, stateless auth helps us to avoid some pesky CORS issues related to cross domain cookies that were a well known burden for the last couple releases while we transitioned. Our implementation of stateless auth uses JWT is only a reference, and with the addition of KONG as our API gateway, the host of [plug-in support](https://docs.konghq.com/hub/) makes it flexible to suit a variety of needs for authentication, routing, and traffic control. We leverage KONG using the declarative method (no DB), and everything is configured in this [yaml file](`https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/blob/v1.3.0/kong.yaml`). Be sure to take a glance to understand how routes are routed to each service.

We know "dev mode" being removed is a big change. Specifically that means, file-based storage for secrets and related data is removed. This is primarily done to ensure that as we build new features with the toolkit, that they are developed and tested with security and production scenarios in mind using a secret manager and a database. Development locally is just as easy as it was before, simply run `docker-compose up -d db vault` from the `open-amt-cloud-toolkit` repo to have these services available before running the services outside of docker if you are doing development. The default configuration should already be set up and ready to go.


We are excited for V1.3.0, but we know we have more work to do. v1.4.0 is our next release, and everything is looking on track to be our LTS Release. We will be focusing on stability, scaling, and trying to ensure our codebase is in a position for maintainability. As always, if any issues are found -- please file them on our github issues and we'll be sure to take a look and address them as we can. Thanks again for your continued patience as we continue to improve the Open AMT Cloud toolkit. 

\- Mike




