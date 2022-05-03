--8<-- "References/abbreviations.md"

On the managed device, a Remote Provisioning Client (RPC) communicates with the Remote Provision Server (RPS) in the process of activating or deactivating the device. In addition to activation and deactivation, the RPC provides informational and maintenance commands. 

Find all RPC commands [here](./commandsRPC.md).


## Build Library

=== "Linux Lib (.so file)"
    ``` bash
    go build -buildmode=c-shared -o rpc.so ./cmd 
    ```
=== "Windows Lib (.dll file)"
    ``` bash
    go build -buildmode=c-shared -o rpc.dll ./cmd
    ```

## Library Functions

The library contains two functions:

| Function | Description | Usage |
| ------------- | ------------------ | ------------ |
| **checkAccess**  | Determines if RPC is being run as admin, the ME driver is installed, and AMT is available. | Use this function to check for basic AMT availability conditions.|
| **rpcExec**  | Executes RPC commands. | Use this function as you would the RPC executable, passing in arguments to activate, deactivate, perform maintenance, etc. |

## Sample Client in `C#`

Find a simple sample client in the RPC-go's [dotnet folder](https://github.com/open-amt-cloud-toolkit/rpc-go/tree/main/samples/dotnet). 

### Include in `C#`

This sample code demonstrates how to import the DLL's functions:

``` c#
    //Linux-style example (.so extenstion)
    [DllImport("rpclib.so", EntryPoint = "checkAccess")]
    static extern void checkAccess();
```

### Call a Function

This sample provides an example of calling the `rpcExec` function to activate a device:

``` c#
    //Import
    [DllImport("rpclib.so", EntryPoint = "rpcExec")]
    static extern string rpc([In] byte[] rpccmd, ref IntPtr output);

    //Activate the device. To use, substitute your IP Address and Profile Name below.
    string res = "activate -u wss://192.168.1.96/activate -n -profile Test_Profile";
    //string res = "amtinfo";

    IntPtr output = IntPtr.Zero;
    rpc(Encoding.ASCII.GetBytes(res), ref output);
    Console.WriteLine("Output from RunRPC: " + Marshal.PtrToStringAnsi(output));

```
