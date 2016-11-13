FROM resin/rpi-raspbian
MAINTAINER Henrik Hedlund <henrik@hedlund.im>

ARG HASS_VERSION

ENV ARCH=arm
ENV CROSS_COMPILE=/usr/bin/

# Update and install python
RUN apt-get update && \
    apt-get install build-essential python3-dev python3-pip ssh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Home Assistant
RUN pip3 install homeassistant==$HASS_VERSION

# Mouting point for the configuration
VOLUME /config

# Expose the default port of Home Assistant
EXPOSE 8123

# Entrypoint is Home Assistant with deafult parameters
CMD [ "python3", "-m", "homeassistant", "--config", "/config" ]
