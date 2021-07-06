# Logging

# Introduction
 Logging for the MPS and RPS services are using the winston logging framework. Log levels for both the MPS and RPS services are controlled by the environmental variables MPS_LOG_LEVEL and RPS_LOG_LEVEL respectfully. Supported levels are as follows: `error`, `warn`, `info`, `verbose`, `debug`, and `silly` (in order with increasing detail).

# Log levels

| Log level     | Description |
| :------------------------- | :-- |
| error            | only critical errors such as exceptions; 500 level api responses |
| warn             | unexpected issue which don't affect service operation |
| info             | service startup and shutdown messages (default level for MPS and RPS services) |
| verbose          | database query messages; device heartbeat; 200 level api responses |
| debug            | level useful for diagnosing issues with the services; 400 level api responses|
| silly            | all logs|