In addition to using GitHub Actions to obtain a binary, the RPC binary can also be manually built. The steps below walk through how to build RPC on Windows 10, Ubuntu (18.04 or 20.04), and CentOS7/8.

<!-- The Remote Provisioning Client (RPC) communicates with the Manageability Engine Interface (MEI) and RPS interfaces. The MEI uses the ME Driver to talk to Intel AMT. By running RPC, we will activate Intel AMT into Client Control Mode (CCM), or ACM based on the created profile, as well as configure the CIRA connection of the AMT device to the MPS. After successfully running, the AMT device will be ready to be managed remotely using the web interface! -->


The steps below assume the following directory structure where rpc is the clone of the [rpc repository](https://github.com/open-amt-cloud-toolkit/rpc), vcpkg is a clone of the VCPKG tool source and build is the RPC build directory. Both vcpkg and build directories will be created in later steps.

```
\rpc
  |__vcpkg
  |__build
```


### Clone the Repository

1. On your development system, navigate to a directory of your choice to clone and build RPC.

2. Clone the RPC repository.

    ``` bash
    git clone https://github.com/open-amt-cloud-toolkit/rpc.git && cd rpc
    ```

### Install Prerequisites and Build RPC

=== "Windows"
    Open 'x64 Native Tools Command Prompt for VS 20XX' as Administrator on your development system.  **This is NOT a regular Windows Command Prompt.**  This specific tool is used for compiling the RPC executable.
    
    ![NTCP](../../assets/images/x64NativeToolsCP.png)

    **Build VCPKG and C++ REST SDK**


    1. In the `rpc` directory, clone the VCPKG repository. Vcpkg is a C/C++ Library Manager for Windows that was created by Microsoft.  Find out more about it [here](https://github.com/microsoft/vcpkg).
    ``` bash
    git clone --branch 2020.11-1 https://github.com/microsoft/vcpkg.git && cd vcpkg
    ```

    2. Build vcpkg.exe using the following command.
    ``` bash
    bootstrap-vcpkg.bat
    ```
        
    3. Install C++ REST SDK.
    ``` bash
    vcpkg install cpprestsdk[websockets]:x64-windows-static
    ```

    **Build RPC**

    1. Return to the `rpc` directory and create a new `build` directory.
    ``` bash
    cd .. && mkdir build && cd build
    ```
    
    2. Generate the CMake config.
    ``` bash
    cmake -DVCPKG_TARGET_TRIPLET=x64-windows-static -DCMAKE_TOOLCHAIN_FILE=/rpc/vcpkg/scripts/buildsystems/vcpkg.cmake ..
    ```

    3. Build the RPC executable.
    ```bash
    cmake --build . --config Release
    ```
    
        !!! note
            RPC can also be built in a non-production debug mode rather than release using the following command. The debug mode includes debug symbols.
            ```
            cmake --build . --config Debug
            ```

    4. Change to `Release` directory.
    ``` bash
    cd Release
    ```


=== "Ubuntu/CentOS8"
    The following steps are for Ubuntu 18.04, Ubuntu 20.04, or CentOS8.

    **Build VCPKG and C++ REST SDK**

    1. To install the required dependencies; enter the following command.

        === "Ubuntu"
        ``` bash
        sudo apt install git cmake build-essential curl zip unzip tar pkg-config
        ```
    
        === "CentOS8"
        ``` bash
        sudo yum install cmake
        ```

    2. In the `rpc` directory, clone the Vcpkg repository. Vcpkg is a C/C++ Library Manager for Windows that was created by Microsoft.  Find out more about it [here](https://github.com/microsoft/vcpkg).
    ``` bash
    git clone --branch 2020.11-1 https://github.com/microsoft/vcpkg.git && cd vcpkg
    ```

    3. Build vcpkg.exe using the following command.
    ``` bash
    ./bootstrap-vcpkg.sh
    ```
        
    4. Install C++ REST SDK.
    ``` bash
    ./vcpkg install cpprestsdk[websockets]
    ```

    **Build RPC**

    1. Return to the `rpc` directory and create a new 'build' directory.
    ``` bash
    cd .. && mkdir build && cd build
    ```
    
    2. Generate the CMake config.
    ``` bash
    cmake -DCMAKE_TOOLCHAIN_FILE=/rpc/vcpkg/scripts/buildsystems/vcpkg.cmake -DCMAKE_BUILD_TYPE=Release ..
    ```

        !!! note
            RPC can also be built in a non-production debug mode rather than release using the following command. The debug mode includes debug symbols.
            ```
            cmake -DCMAKE_TOOLCHAIN_FILE=/rpc/vcpkg/scripts/buildsystems/vcpkg.cmake -DCMAKE_BUILD_TYPE=Debug ..
            ```

    3. Build the RPC executable.
    ```bash
    cmake --build .
    ```

    4. Change to `build` directory.
    ``` bash
    cd build
    ```

=== "CentOS7"
    !!! important
        **The "export PATH=..." (for CMake and Git), and "scl enable devtoolset-7 bash" (for GCC) must be executed in in the Terminal you are building from; i.e. these are temporary changes which only affect the current Terminal session.**

    **Install Dependencies**

    1. Download CMake.
    ``` bash
    ./cmake-3.10.2-Linux-x86_64.sh
    export PATH=/home/user/Downloads/cmake-3.10.2-Linux-x86_64/bin:$PATH
    ```

    2. Update GCC toolchain.
    ```
    sudo yum install centos-release-scl
    sudo yum install devtoolset-7
    scl enable devtoolset-7 bash
    ```

    3. Build Git source control system.
    ``` bash
    sudo yum install curl-devel expat-devel gettext-devel openssl-devel zlib-develperl-CPAN perl-devel
    git clone https://github.com/git/git.git
    make configure
    make
    export PATH=/home/user/Downloads/git:$PATH
    ```

    **Build VCPKG and C++ REST SDK**
        
    1. In the `rpc` directory, clone the VCPKG repository. Vcpkg is a C/C++ Library Manager for Windows that was created by Microsoft.  Find out more about it [here](https://github.com/microsoft/vcpkg).
    ``` bash
    git clone --branch 2020.11-1 https://github.com/microsoft/vcpkg.git && cd vcpkg
    ```

    3. Build vcpkg.exe using the following command.
    ``` bash
    ./bootstrap-vcpkg.sh
    ```
        
    4. Install C++ REST SDK.
    ``` bash
    ./vcpkg install cpprestsdk[websockets]
    ```

    **Build RPC**

    1. Return to the `rpc` directory and create a new 'build' directory.
    ``` bash
    cd .. && mkdir build && cd build
    ```
    
    2. Generate the CMake config
    ``` bash
    cmake -DCMAKE_TOOLCHAIN_FILE=/rpc/vcpkg/scripts/buildsystems/vcpkg.cmake -DCMAKE_BUILD_TYPE=Release -DNO_SELECT=ON ..
    ```

        !!! note
            RPC can also be built in a non-production debug mode rather than release using the following command. The debug mode includes debug symbols.
            ```
            cmake -DCMAKE_TOOLCHAIN_FILE=/rpc/vcpkg/scripts/buildsystems/vcpkg.cmake -DCMAKE_BUILD_TYPE=Debug -DNO_SELECT=ON ..
            ```

    3. Build the RPC executable
    ```bash
    cmake --build .
    ```

    4. Change to `build` directory
    ``` bash
    cd build
    ```

### Run RPC to Activate and Connect an AMT Device

For additional information on possible arguments when invoking RPC, see [Command Examples](../commandsRPC.md).

The following example command shows how to activate and configure an Intel AMT device using a pre-defined profile on your local network.

=== "Windows"
    ```
    rpc.exe --url wss://localhost:8080 --cmd "-t activate --profile profile1"
    ```
=== "Linux"
    ``` bash
    sudo ./rpc --url wss://localhost:8080 --cmd "-t activate --profile profile1"
    ```


Example Success Output:

[![RPC Success](../../assets/images/RPC_Success.png)](../assets/images/RPC_Success.png)