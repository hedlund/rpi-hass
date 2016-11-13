# Home Assistant Docker image for Raspberry Pi

TBD

## How to run

    docker run -d --name hass -v /path/to/config:/config --net=host -v /etc/localtime:/etc/localtime:ro hedlund/rpi-hass
