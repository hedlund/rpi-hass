# rpi-hass

A Home Assistant Docker image for Raspberry Pi.

It has support for Z-wave and Telldus devices, although Telldus requires a separate image as well (`rpi-telldus`).
Configuration files should be mounted as a volume to `/config`, and if you're going to use Z-wave, you need to
mount your device as well:

    docker run -d --name hass \
        --net=host \
        -p 8123:8123 \
        -v $PWD:/config \
        -v /etc/localtime:/etc/localtime:ro \
        --device=/dev/ttyACM0:/dev/zwave:rwm \
        hedlund/rpi-hass

Check out my [rpi-hass-starter](https://github.com/hedlund/rpi-hass-starter) repository for a more in-depth example
of how to use this image.
