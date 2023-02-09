--8<-- "References/abbreviations.md"

On the managed device, a Remote Provisioning Client (RPC) communicates with the Remote Provision Server (RPS) in the process of activating or deactivating the device. In addition to activation and deactivation, the RPC provides informational and maintenance commands. 

Find all RPC commands [here](./commandsRPC.md).

## Prerequisites

A GCC toolchain is required to compile RPC as a library.

=== "Linux"
    Run the following command to install:
    ``` bash
    sudo apt install build-essential
    ```
=== "Windows"
    Download and Install [tdm-gcc](https://jmeubank.github.io/tdm-gcc/download/).


## Build Library

=== "Linux Lib (.so file)"
    ``` bash
    go build -buildmode=c-shared -o librpc.so ./cmd 
    ```
=== "Windows Lib (.dll file)"
    ``` bash
    go build -buildmode=c-shared -o rpc.dll ./cmd
    ```

## Library Functions

The library contains two functions:

| Function        | Description                                                                                | Usage                                                                                                                      |
|-----------------|--------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| **checkAccess** | Determines if RPC is being run as admin, the ME driver is installed, and AMT is available. | Use this function to check for basic AMT availability conditions.                                                          |
| **rpcExec**     | Executes RPC commands.                                                                     | Use this function as you would the RPC executable, passing in arguments to activate, deactivate, perform maintenance, etc. |

## Sample Client in `C#`

Find a simple sample client in the RPC-go's [dotnet folder](https://github.com/open-amt-cloud-toolkit/rpc-go/tree/main/samples/dotnet). 

### Include in `C#`

This sample code demonstrates how to import the DLL's functions:

``` c#
    //Linux-style example (.so extenstion)
    [DllImport("rpc")]
    static extern int rpcCheckAccess();
```

### Call a Function

This sample provides an example of calling the `rpcExec` function to activate a device:

``` c#
    //Import
    [DllImport("rpc")]
    static extern int rpcExec([In] byte[] rpccmd, ref IntPtr output);

    int returnCode;

    Console.WriteLine("... CALLING rpcCheckAccess ...");
    returnCode = rpcCheckAccess();
    Console.WriteLine("... rpcCheckAccess completed: return code[" + returnCode + "] ");
    Console.WriteLine();

    var res = "";
    foreach (var arg in args)
    {
        res += $"{arg} ";
    }

    // Example commands to be passed in
    // string res = "activate -u wss://192.168.1.96/activate -n -profile Test_Profile";
    // string res = "amtinfo";

    IntPtr output = IntPtr.Zero;
    Console.WriteLine("... CALLING rpcExec with argument string: " + res);
    returnCode = rpcExec(Encoding.ASCII.GetBytes(res), ref output);
    Console.WriteLine("... rpcExec completed: return code[" + returnCode + "] " + Marshal.PtrToStringAnsi(output));

```
## RPC Error Code Charts 
**(1-19) Basic Errors Outside of Open AMT Cloud Toolkit**

|Error Code| Message                                 |
| -------- | --------------------------------------- |
|1         |Incorrect permissions (not admin or sudo)|
|2         |HECI driver not detected                 |
|3         |AMT not detected                         |
|4         |AMT not ready                            |

**(20-69) Input errors to RPC**

|Error Code| Message                                 |
| -------- | --------------------------------------- |
|20        |Missing or incorrect URL                 |
|21        |Missing or incorrect profile             |
|22        |Server certificate verification failed   |
|23        |Missing or incorrect password            |
|24        |Missing DNS Suffix                       |
|25        |Missing hostname                         |
|26        |Missing proxy address and port           |
|27        |Missing static IP information            |

**(70-99) Connection Errors**

|Error Code| Message                                 |
| -------- | --------------------------------------- |
|70        |RPS authentication failed                |

**(100-149) Activation and Configuration Errors**

|Error Code| Message                                 |
|----------|-----------------------------------------|
|100       |AMT authentication failed                |
|101       |WSMAN message error                      |
|102       |Activation failed                        |
|103       |Network configuration failed             |
|104       |CIRA configuration failed                |
|105       |TLS configuration failed                 |
|106       |WiFi configuration failed                |
|107       |AMT features configuration failed        |
|108       |802.1x configuration failed              |

**(150-199) Maintenance Errors**

|Error Code| Message                                 |
|----------|-----------------------------------------|
|150       |Clock sync failed                        |
|151       |Hostname sync failed                     |
|152       |Network sync failed                      |

