# Canary Platform Homework

## Getting Started
This service requires Python3.

A docker-compose and Dockerfile has been created to run this application in a container.

In order to run the webserver, use `docker-compose up` with a running docker environment.

## API Endpoints

### Create a reading

**[POST]** [`http://localhost:5000/devices/<device-uuid>/readings/`]

Create a reading for a device. The sensor type can be temperature or humidity and the value can be in the range 0-100

**Request**

    {
        "type": "temperature",
        "value": 12
    }

**Response**

- ``201 success``: The reading is successfully created
- ``400 Bad Request``: Malformed request.


### Fetch readings based on device uuid

**[GET]** [`http://localhost:5000/devices/<device-uuid>/readings/?type=<sensor-type>?start=<start-date>?end=<end-date>`]

**Query Parameters**

- Sensor Type (Optional)
- Start Date (Optional)
- End Date (Optional)

Fetches data from the provided device uuid. The sensor type, start and end date can be provided as additional optional filters and can be used individually or combined.

**Response**

- ``200 OK``: JSON response:

        [
            {
                "date_created": 1635339970,
                "device_uuid": "123",
                "type": "temperature",
                "value": 1
            },
            {
                "date_created": 1635340526,
                "device_uuid": "123",
                "type": "temperature",
                "value": 12
            },
            {
                "date_created": 1635340527,
                "device_uuid": "123",
                "type": "temperature",
                "value": 12
            }
        ]

- ``400 Bad Request``: Malformed request.

### Calculates max reading value based on device uuid

**[GET]** [`http://localhost:5000/devices/<device-uuid>/readings/max/?type=<sensor-type>?start=<start-date>?end=<end-date>`]

**Query Parameters**

- Sensor Type (Mandatory)
- Start Date (Optional)
- End Date (Optional)

Calculates the maximum value from the provided device uuid. The start and end date can be provided as additional optional filters and can be used individually or combined.

**Response**

- ``200 OK``: JSON response:

        [
            {
                "date_created": 1635340526,
                "device_uuid": "123",
                "type": "temperature",
                "value": 12
            }
        ]

- ``400 Bad Request``: Malformed request.

### Calculates min reading value based on device uuid

**[GET]** [`http://localhost:5000/devices/<device-uuid>/readings/min/?type=<sensor-type>?start=<start-date>?end=<end-date>`]

**Query Parameters**

- Sensor Type (Mandatory)
- Start Date (Optional)
- End Date (Optional)

Calculates the minimum value from the provided device uuid. The start and end date can be provided as additional optional filters and can be used individually or combined.

**Response**

- ``200 OK``: JSON response:

        [
            {
                "date_created": 1635340526,
                "device_uuid": "123",
                "type": "temperature",
                "value": 1
            }
        ]

- ``400 Bad Request``: Malformed request.

### Calculates median reading value based on device uuid

**[GET]** [`http://localhost:5000/devices/<device-uuid>/readings/median/?type=<sensor-type>?start=<start-date>?end=<end-date>`]

**Query Parameters**

- Sensor Type (Mandatory)
- Start Date (Optional)
- End Date (Optional)

Calculates the median value from the provided device uuid. The start and end date can be provided as additional optional filters and can be used individually or combined.

**Response**

- ``200 OK``: JSON response:

        [
            {
                "date_created": 1635340526,
                "device_uuid": "123",
                "type": "temperature",
                "value": 5
            }
        ]

- ``400 Bad Request``: Malformed request.

### Calculates mean reading value based on device uuid

**[GET]** [`http://localhost:5000/devices/<device-uuid>/readings/mean/?type=<sensor-type>?start=<start-date>?end=<end-date>`]

**Query Parameters**

- Sensor Type (Mandatory)
- Start Date (Optional)
- End Date (Optional)

Calculates the mean value from the provided device uuid. The start and end date can be provided as additional optional filters and can be used individually or combined.

**Response**

- ``200 OK``: JSON response:

        {
            "value": 8.333333333333334
        }

- ``400 Bad Request``: Malformed request.

### Calculates mode reading value based on device uuid

**[GET]** [`http://localhost:5000/devices/<device-uuid>/readings/mode/?type=<sensor-type>?start=<start-date>?end=<end-date>`]

**Query Parameters**

- Sensor Type (Mandatory)
- Start Date (Optional)
- End Date (Optional)

Calculates the mode value from the provided device uuid. The start and end date can be provided as additional optional filters and can be used individually or combined.

**Response**

- ``200 OK``: JSON response:

        {
            "value": 12
        }

- ``400 Bad Request``: Malformed request.

### Calculates first and third quartile values based on device uuid

**[GET]** [`http://localhost:5000/devices/<device-uuid>/readings/mode/?type=<sensor-type>?start=<start-date>?end=<end-date>`]

**Query Parameters**

- Sensor Type (Mandatory)
- Start Date (Mandatory)
- End Date (Mandatory)

Calculates the first and third quartile value from the provided device uuid.

**Response**

- ``200 OK``: JSON response:

        {
            "quartile_1": 6.5,
            "quartile_3": 12
        }

- ``400 Bad Request``: Malformed request.

### Generate Summary for devices

**[GET]** [`http://localhost:5000/devices/summary/?type=<sensor-type>?start=<start-date>?end=<end-date>`]

**Query Parameters**

- Sensor Type (Optional)
- Start Date (Optional)
- End Date (Optional)

Generates a summary of statistical information for each device uuid. The query parameters can be used to filter data additionally.

**Response**

- ``200 OK``: JSON response:

        [
            {
                "device_uuid": "123",
                "max_reading_value": 12,
                "mean_reading_value": 8.333333333333334,
                "median_reading_value": 12,
                "number_of_readings": 3,
                "quartile_1_value": 6.5,
                "quartile_3_value": 12
            },
            {
                "device_uuid": "456",
                "max_reading_value": 66,
                "mean_reading_value": 44.5,
                "median_reading_value": 44.5,
                "number_of_readings": 2,
                "quartile_1_value": 33.75,
                "quartile_3_value": 55.25
            }
        ]

- ``400 Bad Request``: Malformed request.

## Testing

12 unit tests have been added to cover each API indiviually and can be run via `pytest -v`. Error cases are handled within each test case as well.

## Design Decisions Taken

-   APIs for min and mode metrics have been implemented as an addition.
-   The application has been dockerized in order to remove dependencies so that it can easily be run in a containerized environment.

## Roadmap for Next Quarter

Essentially the following two problems should be prioritized in the next quarter:

-   Add API authentication to ensure secure REST API calls
-   Use a production level WSGI server such as waitress instead of Flask development server
-   Based on the load, the application can be scaled horizontally and a load balancer can be used.
