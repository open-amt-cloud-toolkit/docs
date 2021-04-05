## Hello Everyone! 

We are rapidly continuing down the path of improvement and are excited to announce the v1.2.0 release of the Open AMT Cloud Toolkit. We've got a few breaking changes in this release, so please read the release notes carefully to note what is breaking. We've greatly simplified the restful APIs on RPS. You'll now see that all error responses are properly structured JSON, the property names are consistent across request/response and the correct status codes are now being returned. This constitutes one of our biggest breaking changes, but felt it is the right direction and greatly simplifies integration. This release also brings an entirely revamped sample web ui based on Angular with a much more friendly User Experience to help guide you through the steps required to activate an AMT device (not to mention much easier on the eyes!). Additionally, the protocol version between RPC and RPS has been bumped to 4.0.0 to account for a delay that has been added in between provisioning and activation to help avoid a previous issue where a device would not connect to MPS without a power cycle. Lastly, we've added a Dockerfile for RPC to help enable better integration with edge management solutions such as Portainer, Azure IoT Edge, AWS Greengrass etc... (Linux Only though :( ) Be sure and check the documentation for how to use RPC in Docker.

For scaling out MPS, we've released a preview with K8S. We know it's got some issues with KVM and SOL, and is currently locked to Azure (AKS) and can only be deployed from Windows. We will be addressing this in the future to be a bit more OS deployment agnostic as well as cloud agnostic. But for now, it is what we have and we ask you provide feedback to help us improve.

While we are excited for 1.2, we know we still have some things we can improve on. For 1.3 we will be adding a proxy in front of the microservices to help alleviate dealing with accepting multiple self-signed certificates and knowing which port is which. The configuration will become simplified by leveraging .env files consistently across both a containerized deployment as well as a local deployment. MPS will begin to undergo the same restructuring as RPS -- having some APIs that make a bit more sense then just `/admin` and become easier to integrate. Lastly, we will be removing the "dev mode" concept. This will require you to have both a PostgreSQL and Vault instance running, but Docker will help make this easy!

As always, if any issues are found -- please file them on our github issues and we'll be sure to take a look and address them as we can. Thanks again for your continued patience as we continue to improve the Open AMT Cloud toolkit. 

\- Mike




