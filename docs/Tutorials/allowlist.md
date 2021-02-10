## Add/Modify data.json

If `use_allowlist` is set to `true` in the `.mpsrc` file within the `mps` directory, edit the `data.json` file in the `private` directory to allowlist Intel&reg; AMT GUIDs to connect to MPS. 

For information on how to obtain GUIDs, see [GUIDs in Intel&reg; AMT](../Topics/guids.md).

1. Navigate to the `/mps/private` directory.

2. Open the `data.json` file in a text editor of choice.

3. Append the **allowlist_guids** section to include the GUIDs of your allowed AMT devices.

!!! example
    Example `data.json` file:

    ``` json
    {
      "credentials": {
        "12345678-9abc-def1-2345-123456789000": {
          "name": "Sample-Device",
          "mpsuser": "standalone",
          "mpspass": "G@ppm0ym",
          "amtuser": "admin",
          "amtpass": "P@ssw0rd"
        },
        "d92b3be1-b04f-49de-b806-54b203054e9d": {
          "name": "d92b3be1-b04f-49de-b806-54b203054e9d",
          "mpsuser": "standalone",
          "mpspass": "G@ppm0ym",
          "amtuser": "admin",
          "amtpass": "P@ssw0rd",
          "mebxpass": "P@ssw0rd"
        },
        "3beae094-34f8-11ea-b6f5-ffed08129200": {
          "name": "3beae094-34f8-11ea-b6f5-ffed08129200",
          "mpsuser": "standalone",
          "mpspass": "G@ppm0ym",
          "amtuser": "admin",
          "amtpass": "P@ssw0rd",
          "mebxpass": "P@ssw0rd"
        }
      },
      "allowlist_guids": [
        "12345678-9abc-def1-2345-123456789000",
        "d92b3be1-b04f-49de-b806-54b203054e9d",
        "3beae094-34f8-11ea-b6f5-ffed08129200"
      ],
      "allowlist_orgs": [
        "12345678901234567890123456789012"
      ]
    }
    ```