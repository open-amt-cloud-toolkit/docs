# Logging

# Introduction
 Logging for the MPS and RPS services are using the winston logging framework. Log levels for both the MPS and RPS services are controlled by the environmental variables MPS_LOG_LEVEL and RPS_LOG_LEVEL respectfully. Supported log levels are as follows: `error`, `warn`, `info`, `verbose`, `debug`, and `silly` (in order with increasing detail).

# Log levels

| Log level     | Description |
| :------------------------- | :-- |
| error            | only critical errors such as exceptions; includes 500 level responses |
| warn             | unexpected issue that does not affect service operation|
| info             | service messages such as messages for startup and shutdown |
| verbose          | database query messages; includes 200 level responses |
| debug            | level useful for diagnosing issues with the services; includes 400 level responses|
| silly            | all logs|