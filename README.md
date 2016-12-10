# rpi-hass

This is a Home Assistant Docker image for Raspberry Pi.

TBD

## How to run

    docker run -d --name hass -v /path/to/config:/config --net=host -v /etc/localtime:/etc/localtime:ro --device=/dev/ttyACM0:/dev/zwave:rwm hedlund/rpi-hass
	docker run -d --name hass -v $PWD:/config --net=host -v /etc/localtime:/etc/localtime:ro --device=/dev/ttyACM0:/dev/zwave:rwm hedlund/rpi-hass

    docker run -d --name ozwcp -p 8008:8008 --device=/dev/ttyACM1:/dev/ttyACM1:rwm openzwave/openzwave-control-panel
	docker run -d --name ozwcp -p 8008:8008 --device=/dev/ttyACM1:/dev/ttyACM1:rwm openzwave/openzwave-control-panel

	docker run -d --name ozwcp --device=/dev/ttyACM0:/dev/zwave:rwm openzwave/openzwave-control-panel
