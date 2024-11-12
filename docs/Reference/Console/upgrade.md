# Upgrading Console

## Overview
We plan to provide a seamless upgrade path from the MVP or v1.0 release, ensuring that no database deletion is required.

## Upgrading from Alpha to Beta

Starting from Beta release, all sensitive data in the SQLite database will be encrypted using an encryption key. Due to this security enhancement, you'll need to delete the existing database file before upgrading.

### Steps to Delete Database

1. Navigate to the directory where the `console` database file is stored:

    === "Windows"
        ```
        %APPDATA%\device-management-toolkit
        ```

    === "Ubuntu"
        ```
        ~/.config/device-management-toolkit
        ```
    
    === "MAC"
        ```
        ~/LIbrary/Application Support/device-management-toolkit
        ```

2. Delete the `console` database file.


### Add all the devices
After deleting the database and running the Console executable, you'll need to reconfigure or add all your devices again, as the previous data cannot be migrated due to the encryption changes.
