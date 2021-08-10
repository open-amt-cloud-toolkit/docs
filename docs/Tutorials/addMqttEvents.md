--8<-- "References/abbreviations.md"

RPS and MPS both have the ability to publish event messages through an MQTT Broker. The following will demonstrate how to add, remove or edit the events published by the server. For information on the process of subscribing to these events, see [MQTT Eventing Support](../Topics/mqtt.md).

There are three main components that can be manipulated within the MQTT event flow: individual events throughout MPS/RPS, the MqttProvider class and the MQTT Broker.

### Individual Events

#### Adding Events

Events can be added anywhere with RPS and MPS using the `publishEvent` method as long as the MqttProvider class is imported. Here is an example of how an implementation might look.

``` ts
import { MqttProvider } from '../../utils/mqttProvider'

MqttProvider.publishEvent('success', ['Example'], 'Hello World', guid)
```

The `publishEvent` method takes the parameters (message type, array of methods associated with the message, message to be sent, and **optionally** the guid of the device) and creates a message to be published by the event broker.

!!! Note
    See MqttProvider Class section for how to change the parameters and behavior of the `publishEvent` method.

#### Editing / Deleting Events

A number of default events have been added to RPS and MPS, such as API calls and action events. If any of these events are deemed to be lacking or unnecessary they can simply be edited or deleted. Event pubishing works independently from the inner workings of RPS and MPS and thus will function normally with the addition, adaptation or deletion of any individual events.

### MqttProvider Class

#### Connecting

This class handles the interactions with the MQTT Broker.

A connection is established in the respective `index.ts` files of RPS and MPS with the following code.

``` ts
  const mqtt: MqttProvider = new MqttProvider(config)
  mqtt.connectBroker()
```
The `connectBroker` method creates the connection between a client (stored in the class) and the `mosquitto` docker container which acts as the MQTT Broker. Then the instance of the class that was just created and connected is stored as a static object within the class, allowing for the methods in this class to be accessed easily with a simple import rather than passing the instance around MPS or RPS.

The config parameter contains the respective config types of MPS and RPS but MqttProvider is really only looking for the `MQTT_ADDRESS` environment variable so it knows where to connect to. 

!!! Important
    The `MQTT_ADDRESS` environment variables for MPS and RPS are left blank in the .env.template file. This corresponds to the **OFF** state. To turn event logging with mosquitto **ON** give the address of the MQTT Broker `mqtt://mosquitto:8883` to the `MPS_MQTT_ADDRESS` and `RPS_MQTT_ADDRESS` environment variables.

#### Usage

Currently the core functionality of this system is focused around the `publishEvent` method. This is the developers way of creating server events that will be sent to the MQTT Broker and then published to subscribers.

The function simply takes information about an event the developer wants to publish, organizes it, adds a timestamp and sends it to the MQTT Broker. This setup can be expanded upon by changing the parameters and the elements within `OpenAMTEvent` (the interface used to organize the message) or by adding new methods altogether. 

One common change might be to the handling of topics. Topics are how subscribers choose what information they would like to receive and are organized in a directory-like structure. For instance, if a message has the topic `cars/ford` then subscribers of `#`, `cars` or `cars/ford` will receive the message while subscribers of `trucks` or `cars/ferrari` will not. The method used to send a message to the MQTT Broker is `publish`, and the first argument of this method is the topic. Currently, this is hardcoded with a default value but a developer could add a parameter, tie the topic to existing parameters or create different publishEvent methods that correspond to different topics.

### MQTT Broker

The Broker for MQTT messages is the docker container named `mosquitto` and it runs the eclipse-mosquitto:latest image. Changes to the functionality of the Broker can be made through `mosquitto.conf`. Most of the Broker setup has been left in its default state but more information about customizing the broker can be found [here](https://mosquitto.org/man/mosquitto-conf-5.html).