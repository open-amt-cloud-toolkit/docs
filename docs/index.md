--8<-- "References/abbreviations.md"

# Overview

**Open Active Management Technology Cloud Toolkit (Open AMT Cloud Toolkit)** offers open-source microservices and libraries to streamline Intel AMT integration, simplifying out-of-band management solutions for Intel vPro Platforms.

??? note "Long-Term Support (LTS) Version"
    Not looking for the current rapid release with the latest features? [See the documentation for our Long-Term Support release.](https://open-amt-cloud-toolkit.github.io/docs/{{ docsSite.ltsVersion }})

<div class="home-nav-row">
  <div class="home-nav-column">
    <div class="home-nav-card">
        <h4><img class="home-nav-icons" src="./assets/images/intel/blazing-performance.png"><b>Get Started</b></h4>
        <p>Jump in to the Open AMT Cloud Toolkit by deploying locally with Docker containers.</p>
        <a href="./GetStarted/prerequisites/">Get Started Now</a>
    </div>
  </div>
  <div class="home-nav-column">
    <div class="home-nav-card">
        <h4><img class="home-nav-icons" src="./assets/images/intel/solutions.png"><b>Tutorials</b></h4>
        <p>Get hands-on with tutorials for topics like the UI-Toolkit, APIs, and Scaling (Docker, Kubernetes, and more).</p>
        <a href="./Tutorials/uitoolkitReact/">Explore Tutorials</a>
    </div>
  </div>
  <div class="home-nav-column">
    <div class="home-nav-card">
        <h4><img class="home-nav-icons" src="./assets/images/intel/edge-compute.png"><b>APIs</b></h4>
        <p>Check out the supported APIs for both the Management Presence Server (MPS) and the Remote Provisioning Server (RPS).</p>
        <a href="./APIs/indexMPS/">See APIs</a>
    </div>
  </div>
  <div class="home-nav-column">
    <div class="home-nav-card">
        <h4><img class="home-nav-icons" src="./assets/images/intel/message.png"><b>Join Our Community</b></h4>
        <a target="_blank" href="https://discord.gg/yrcMp2kDWh"><img src="https://discordapp.com/api/guilds/1063200098680582154/widget.png?style=banner4" alt="Discord Banner 4"/></a>
    </div>
  </div>
</div>

<p class="divider"></p>

<div style="text-align:center;">
  <iframe width="800" height="450" src="https://www.youtube.com/embed/ovpvPQi7UGo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

The Intel vPro® Platform, featuring Intel® AMT, enables Out-of-Band (OOB) Management for remote devices. No matter if the device is powered off or the operating system has crashed, issue power actions and take over keyboard, video, mouse (KVM) control.

Reduce the need for costly on-site IT, minimize the downtime of key, business-critical devices, and more. [Read more about the Intel vPro® Platform](https://www.intel.com/content/www/us/en/developer/topic-technology/edge-5g/hardware/vpro-platform-retail.html).

<figure class="figure-image">
  <img src="assets\images\OOBManagement.png" alt="Figure 1: Open AMT Cloud Toolkit features OOB Management">
  <figcaption>Figure 1: Open AMT Cloud Toolkit features OOB Management</figcaption>
</figure>
 
 Intel® AMT supports remote manageability with: 

 **OOB Management:** This hardware-based remote management solution operates below the operating system.

**Call Home:** This capability enables administrators to control, update, and modify remote clients with OOB Management.

 
## Goals
The toolkit guide provides instructions to:

- Deploy the Management Presence Server (MPS) and Remote Provisioning Server (RPS) on the development system.
- Build and run Remote Provisioning Client (RPC) on the managed device.
- Connect the managed device (edge device).

Additional sections provide guidance on the reference implementation UI Toolkit, REST API usage, asset security, and more. 

<figure class="figure-image">
  <img src="assets\images\HiLevelArchitecture.png" alt="Figure 2: High-level architecture consists of four major software components">
  <figcaption>Figure 2: High-level architecture: major software components</figcaption>
</figure>

As shown in Figure 2, Open AMT Cloud Toolkit high-level architecture consists of five components:

1. **MPS** - A microservice that uses an Intel vPro® Platform feature, Client Initiated Remote Access (CIRA), for enabling edge, cloud devices to maintain a persistent connection for out-of-band manageability features, such as power control or Keyboard, Video, Mouse (KVM) control.
2. **RPS** - A microservice that activates Intel® AMT platforms using predefined profiles and connects them to the MPS for manageability use cases.
3. **RPC** - A lightweight client application that communicates with the RPS server to activate Intel® AMT.
4. **UI Toolkit** - A toolkit that includes prebuilt React components and a reference implementation web console. The React-based snippets simplify the task of adding complex manageability-related UI controls, such as the KVM, to a console. 
5. **Sample Web UI** - A web based UI that demonstrates how to use the UI-Toolkit. It also provides a way to interact with the microservices and to help provide context as to how each microservice is used.
   
Integrate the Open AMT Cloud Toolkit into new and existing management consoles, software solutions, and more.

## Toolkit Setup

### Microservices as Containers

Set up microservices quickly as Docker containers with this recommended method.

[Get Started Now](GetStarted/prerequisites.md){: .md-button .md-button--primary }

Estimated completion time: **Approximately 30 minutes**

 
-------
## Additional Intel® AMT Resources

For additional information about Intel® AMT, see the following links:

- [Intel vPro® Platform Overview](https://www.intel.com/content/www/us/en/developer/topic-technology/edge-5g/hardware/vpro-platform-retail.html)
- [Video Link](https://www.intel.com/content/www/us/en/support/articles/000026592/technologies.html)
- [Detailed Setup document](https://software.intel.com/en-us/articles/getting-started-with-intel-active-management-technology-amt)
