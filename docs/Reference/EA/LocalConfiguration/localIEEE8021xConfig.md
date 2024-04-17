--8<-- "References/abbreviations.md"

# Local IEEE 802.1x Configuration with RPC-Go

!!! warning "802.1x Configuration is a Preview Feature"
    802.1x Configuration feature is a Preview Feature and is subject to change. This means it has not been fully validated and cannot be guaranteed to work. There are still potential bugs and tweaks needed for a production-level feature standard. Interested in this feature and helping us test it? Reach out via GitHub.

## Overview

IEEE 802.1X is an IEEE Standard for port-based network access control (PNAC). It provides an authentication mechanism to devices wishing to attach to a LAN or WLAN.

It typically consists of three parts:

1. Supplicant (Client-end User, AMT Device)
2. Authenticator (Access Point or Switch)
3. Authentication Server (RADIUS Server)

<br>

The following steps highlight how to:

- Configure the connection of EA and RPC-Go
- Run 802.1x configuration using RPC-Go

## Prerequisites

The following are requirements to configure and connect an AMT device using TLS.

- [Enterprise Assistant configured for RPC-Go](rpcgoConfiguration.md)
- [RPC-Go](../../../GetStarted/buildRPC.md)

### Services

The following services are assumed to be configured and running in your enterprise environment.

- Microsoft* Certificate Authority (CA)
    - An AMT TLS Certificate template is required. See [TLS Certificate Template](tlsCertTemplate.md) for additional steps on creating a template.

- Microsoft* Active Directory (AD)

## Wired 802.1x Configuration


<br><br>

## Wireless 802.1x Configuration