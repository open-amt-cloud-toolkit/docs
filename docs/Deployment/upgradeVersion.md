


## Upgrade a Minor Version (i.e. 2.X to 2.Y)

Upgrading from a previous minor version to a new minor version release is simple using Helm. By updating your image tags and upgrading through Helm, a seamless transition can be made. Stored profiles and secrets will be unaffected and any connected devices will transition over to the new MPS pod.

1. In the values.yaml file, update the images to the new version wanted. In this scenario, we've only updated the MPS, RPS, and WebUI to the newer versions.

    !!! example "Example - values.yaml File"
        ```
        images:
          mps: "intel/oact-mps:v2.2.0"
          rps: "intel/oact-rps:v2.2.0"
          webui: "intel/oact-webui:v2.2.0"
          mpsrouter: "intel/oact-mpsrouter:v2.0.0"
        mps:
          ...
        ```

2. In Terminal or Command Prompt, go to the deployed open-amt-cloud-toolkit repository directory.

    ```
    cd ./YOUR-DIRECTORY-PATH/open-amt-cloud-toolkit
    ```


3. Use Helm to upgrade and deploy the new images.

    !!! warning "Warning - Upgrading when Using `latest` Image Tags"    
        It is recommended to use versioned tags for deployment for easier tracking and troubleshooting. 
        
        If your instance is using `latest` image tags, for example `intel/oact-mps:latest` rather than `intel/oact-mps:v2.2.0`, some extra configuration is required. Helm will not check for new `latest` images by default since it doesn't detect a change in.

        1. To force Helm to always attempt to pull new images, set the `imagePullPolicy` for each image in their respective template files.

            Files to update:
            ```
            ./kubernetes/charts/templates/mps.yaml
            ./kubernetes/charts/templates/mpsrouter.yaml
            ./kubernetes/charts/templates/rps.yaml
            ./kubernetes/charts/templates/webui.yaml
            ```

            ??? example "Example - Setting `imagePullPolicy` in `mps.yaml`"

                ```yaml hl_lines="15"
                {% raw %}
                spec:
                  replicas: {{ .Values.mps.replicaCount }}
                  selector:
                    matchLabels:
                      app: mps
                  template:
                    metadata:
                      labels:
                        app: mps
                    spec:
                      imagePullSecrets:
                        - name: registrycredentials
                      containers:
                        - name: mps
                          imagePullPolicy: Always
                          image: {{ .Values.images.mps }}
                          env:
                            ...
                {% endraw %}            
                ```

    ```
    helm upgrade openamtstack ./kubernetes/charts
    ```

    !!! example "Example - Successful Helm Upgrade"
        ```
        Release "openamtstack" has been upgraded. Happy Helming!
        NAME: openamtstack
        LAST DEPLOYED: Wed Mar 23 09:36:10 2022
        NAMESPACE: default
        STATUS: deployed
        REVISION: 2
        ```

4. Verify the new pods are running. Notice the only restarted and recreated pods are MPS, RPS, and the WebUI.

    ```
    kubectl get pods
    ```

    !!! example "Example - Upgraded Running Pods"
        ```
        NAME                                                 READY   STATUS    RESTARTS   AGE
        mps-55f558666b-5m9bq                                 1/1     Running   0          2m47s
        mpsrouter-6975577696-wn8wm                           1/1     Running   0          27d
        openamtstack-kong-5999cc6b97-wbmdw                   2/2     Running   0          27d
        openamtstack-vault-0                                 1/1     Running   0          27d
        openamtstack-vault-agent-injector-6d6c75f7d5-sh5nm   1/1     Running   0          27d
        rps-597d7894b5-mbdz5                                 1/1     Running   0          2m47s
        webui-6d9b96c989-29r9z                               1/1     Running   0          2m47s
        ```

<!-- ## Upgrade LTS or Major Versions (i.e. 2.X to 3.Y) -->