Actions are specified by number. Use the [PowerCapabilities](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/1.2.0#/AMT/post_amt) method to return the actions available for a specific device. Use the [PowerState](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/1.2.0#/AMT/post_amt) method to obtain the current power state.

Possible actions are listed in the following table:

   | Action #       |  Resulting Action |
   | :----------- | :------------------------ |   
   | **2** | Power up/on |
   | **4** | Sleep | 
   | **5** | Power cycle |
   | **7** | Hibernate |
   | **8** | Power down/off |
   | **10** | Reset |
   | **12** | Soft power down/off |
   | **14** | Soft reset |
   | **100** | Power up to BIOS settings |
   | **101** | Reset to BIOS settings |
   | **104** | Reset to secure erase |
   | **200** | Reset to IDE-R floppy disc |
   | **201** | Power on to IDE-R floppy disc |
   | **202** | Reset to IDE-R CD-ROM |
   | **203** | Power on to IDE-R CD-ROM |
   | **400** | Reset to PXE |
   | **401** | Power on to PXE |

Consider the current state of the system when implementing a possible action. For example: 

* Reset to BIOS implies that the current system state is on or powered up.
* Power up to BIOS implies that current system state is off or powered down.
* Hibernate implies that the current system state is powered up. 

If the system is already powered up, choosing to Power Up to BIOS will not have any effect on the system. A better choice is Reset to BIOS.