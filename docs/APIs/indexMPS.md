Steps on how to create your own Rest API call can be found in the [Construct a REST API Call](../Tutorials/apiTutorial.md) tutorial.


## API Calls
We've documented the MPS REST API with Swagger*.

[Get Started with MPS REST API](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/1.2.0){: .md-button .md-button--primary target="_blank"}

If unfamiliar with Swagger, see [Swagger Documentation](https://swagger.io/docs/){: target="_blank"}.


The sections below list methods for MPS and a quick summary of each. 

### Admin Methods

  Admin methods allow you to send calls for info for all devices or for MPS configuration information. Utilize these methods by setting the path to **admin** in your API call.

   | Method       |  Description/Usage |
   | :----------- | :------------------------ |
   | **AllDevices** | Lists all devices known to MPS, regardless of connected status |
   | **ConnectedDevices** | Lists all devices currently connected to MPS |
   | **Disconnect** | Disconnects the CIRA connection for a specified guid |
   | **MEScript** | Downloads the cira_setup.mescript from MPS |
   | **RootCertificate** | Download the MPS Root Certificate |

### AMT Methods

!!! note
    These methods are 1:1 device-specific.

AMT methods allow you to send device-specific calls for things such as power actions or audit logs. Utilize these methods by setting the path to **amt** in your API call.

   | Method       |  Description/Usage |
   | :----------- | :------------------------ |   
   | **EventLog** | Return sensor and hardware event data |
   | **GeneralSettings** | View general network settings |
   | **GetAMTFeatures** | View what AMT out-of-band features are enabled/disabled |
   | **HardwareInfo** | Retrieve hardware information such as processor or storage  |
   | **PowerAction** | Perform an OOB power action |
   | **PowerCapabilities** | View what OOB power actions are available for that device |
   | **PowerState** | Retrieve current state of AMT device, returns a number that maps to an [AMT Power State](../Topics/powerstates.md) |
   | **SetAMTFeatures** | Enable/Disable AMT features such as KVM, SOL, and IDE-R |
   | **Version** | Retrieve AMT version of device |
 

