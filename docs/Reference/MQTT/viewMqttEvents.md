--8<-- "References/abbreviations.md"

# Event Monitoring with MQTT (MQTT Eventing) 

Open AMT Cloud Toolkit supports Eventing using Message Queuing Telemetry Transport (MQTT), an IoT publish-and-subscribe network protocol. With MQTT Eventing, administrators can subscribe to specific topics, categories of events, for server event monitoring. This eliminates the need to query or poll MPS to determine network events, such as a device's activation or deactivation. Administrators can subscribe to events and respond proactively. 

!!! important
    Currently, the implementation publishes all MPS and RPS REST API call events to the MQTT Broker. 

![../../assets/images/MQTT.png](../../assets/images/MQTT.png)
**Figure 1: MQTT Eventing Examples**

MPS and RPS send JSON events to a Mosquitto* broker deployed as a Docker container. Administrators subscribe to the broker. As shown in Figure 1, proactive notifications are published in the MQTT Broker container.  


## Set Up MQTT Support

**To enable support:**

1. In a text editor or IDE of choice, open the `.env` file to edit.

2. Update the following fields. The `mqtt:` prefix indicates an MQTT broker is being used. Kong* will now route event messages to port 8883.

    | Field Name            | Set to:               | 
    | -------------         | ------------------    |
    | RPS_MQTT_ADDRESS      | mqtt://mosquitto:8883 | 
    | MPS_MQTT_ADDRESS      | mqtt://mosquitto:8883 |
   
3. Save and close the file.

4. Rebuild the MPS and RPS images and start their containers.

    If your stack was deployed locally using Docker:

    ```
    docker-compose up -d --build mps rps
    ```

**View in the Sample Web UI:**

1. Select MQTT Events from the left-hand menu.

2. Change the **Hostname**  to your IP Address from Localhost.
   
3. Do not set a port.

4. Verify the **Path** is `/mosquitto`.

    ![../../assets/images/MQTTEvents_View.png](../../assets/images/MQTTEvents_View.png)
    **Figure 2: MQTT Events Connection**

    !!! troubleshooting
        If successful, the Connect circle should update to blue. If it is red, verify your Hostname and `.env` file is correct.

5. In the Sample Web UI, click on a different menu option, issue a command to a managed device from the **Devices** list, or make an API call to see an event appear in MQTT Events.

    MQTT Events can be customized to add, edit, or remove events. Read more in [Customizing MQTT Events](./customMqttEvents.md).

    !!! example "Example MQTT Events"
        ![../../assets/images/MQTTEvents_View_Example.png](../../assets/images/MQTTEvents_View_Example.png)

<br><br>