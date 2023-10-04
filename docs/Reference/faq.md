## Frequently Asked Questions

### How do releases work with Open AMT?

Open AMT carries two releases, the Rapid ("Monthly") Release and the Long-Term Support (LTS) Release. 

Rapid Releases occur every 4-6 weeks. Support for security and bug fixes is only for the duration of that rapid release. Customers will be encouraged to move to a latest rapid release for the most up to date security and bug fixes.

LTS Releases occur roughly every 1 to 1.5 years. Support for security and bug fixes exist until the next LTS version is available. At that point, we will provide migration documentation and support to help customers move over to the new LTS release.

<br>

### How does versioning work with Open AMT?

Open AMT follows [SemVer](https://semver.org/) practices for versioning. This means:

- Major Version Increment - Breaking Changes (ex: 2.0.0 -> 3.0.0)
- Minor Version Increment - New Features (ex: 2.0.0 -> 2.1.0)
- Patch Version Increment - Security and Bug Fixes (ex: 2.0.0 -> 2.0.1)

All microservices with the same minor version should be compatible.

The separate repos for microservices and libraries are versioned individually. These versions are separate from the `open-amt-cloud-toolkit` repo version.  The `open-amt-cloud-toolkit` repo is where we have the monthly release. This repo might carry a higher version than some of the individual repos but is tagged as `{Month} {Year}`. All sub-repos referenced within `open-amt-cloud-toolkit` for a specific release are guaranteed to be compatible.

<br>

### What versions of Intel&reg; AMT are supported?

Open AMT aligns to the Intel Network and Edge (NEX) Group support roadmap for Intel vPro&reg; Platform and Intel&reg; AMT devices. This is currently calculated as `Latest AMT Version - 7`.

<br>

### How do I migrate versions to a new release?

Resources and information for migrating releases for either a Kubernetes deployment or local Docker deployment can be found in the [Upgrade Toolkit Version documentation](../Deployment/upgradeVersion.md).

<br>

### What is a Pre-Release Feature?

Sometimes, newer features may be available as **pre-release**. These are features that are still in-development and subject to change. The team opts to make these available for early feedback. These may have limited functionality or potentially even bugs. When the feature is mature and fully validated, it will move from a **pre-release** state to a full release.

<br>

### How do I find more information about the MPS and RPS configuration files and security details?

Details and descriptions of configuration options can be found in [MPS Configuration](../MPS/configuration/) and [RPS Configuration](../RPS/configuration/).

Security information can be found in [MPS Security Information](../MPS/securityMPS/) and [RPS Security Information](../RPS/securityRPS/).

<br>