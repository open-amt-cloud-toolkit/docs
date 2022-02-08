--8<-- "References/abbreviations.md"

Actions are specified by number. Use the [PowerCapabilities](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/{{ repoVersion.mpsAPI }}#/AMT/get_api_v1_amt_power_capabilities__guid_) method to return the actions available for a specific device. Use the [PowerState](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/{{ repoVersion.mpsAPI }}#/AMT/get_api_v1_amt_power_state__guid_) method to obtain the current power state.

Possible power actions are listed in the following table:

   | Action #       | Power Action | [Start State^1^](#start-state) | Transition Description | ACPI State(s) | [In-band Agent Required^2^](#in-band-agent-required) | 
   | :----------- | :------------------------ |   :------------------------ | :------------------------ | :------------------------ | :------------------------ |
   | **2** | Power up/on | Powered down/off, Asleep, Hibernating | Power up/on fully | G0/S0 | No |
   | **4** | Sleep (deep) | Powered up/on | Transition to a standby state of low-power usage and store system context (e.g., open applications) in memory | G1/S3 | Yes |
   | **5** | Power cycle | Powered up/on | Transition to minimal power state and then power up/on fully | G2/S5 > G0/S0 |  No |
   | **7** | Hibernate | Powered up/on | Transition to zero power usage and store system context in non-volatile storage | G1/S4 | Yes |
   | **8** | Power down/off (hard) | Powered up/on | Transition to a fully powered down state | G2/S5 | No |
   | **10** | Reset | Powered up/on | Perform hardware reset on the bus | N/A | No |
   | **12** | Power down/off (soft) | Powered up/on | Transition to a very minimal power state | G2/S5 | Yes |
   | **14** | Soft reset | Powered up/on | Perform a shutdown and then a hardware reset | N/A | Yes |
   | **100** | Power up to BIOS settings | Powered down/off | Power to BIOS to verify or modify system configuration | G2/S5 | Yes  |
   | **101** | Reset to BIOS settings | Powered up/on | Perform hardware reset on the bus to BIOS to verify or modify system configuration | G2/S5 | Yes  |
   | **400** | Reset to PXE | Powered up/on | Reset to pre-boot execution environment (PXE)(i.e., a network boot | N/A | Yes |
   | **401** | Power on to PXE | Powered down/off | Power up/on fully to pre-boot execution environment (PXE) (i.e., a network boot) | N/A | Yes|
   

## Alternative Boot Options

Currently, the Toolkit doesn't natively support secure erase or 200-level calls.

| Action #       | Power Action | [Start State^1^](#start-state) | Transition Description | 
| :----------- | :------------------------ |   :------------------------ |:------------------------ |
| **104** | Reset to secure erase | Powered up/on | Perform hardware reset on the bus to secure erase, a process of completely erasing a solid state drive (SSD)|
| **200** | Reset to IDE-R floppy disc | Powered up/on | Perform hardware reset on the bus to a peripheral IDE-R drive, usually reserved for a remote ISO boot |
| **201** | Power on to IDE-R floppy disc| Powered down/off | Power up/on fully to a peripheral IDE-R drive, usually reserved for a remote ISO boot
| **202** | Reset to IDE-R CD-ROM | Powered up/on | Perform hardware reset on the bus to a peripheral IDE-R CD-ROM drive, usually reserved for a remote ISO boot | 
| **203** | Power on to IDE-R CD-ROM | Powered down/off | Power up/on to the bus to a peripheral IDE-R CD-ROM drive, usually reserved for a remote ISO boot |


## Start State
Consider the current state of the system when implementing a possible action, for example: 

* **Reset to BIOS** implies that the current system state is on or powered up.
* **Power up to BIOS** implies that current system state is off or powered down.
* **Hibernate** implies that the current system state is powered up. 

If the system is already powered up, choosing to **Power Up to BIOS** will not have any effect on the system. A better choice is **Reset to BIOS**.

## In-band Agent Required
Certain power actions require either an in-band agent or Intel® MSS. Commands 100 and above use a combination of HW level power controls (i.e., 2, 5, 8, 10) and some boot option, such as **Boot to BIOS**.
