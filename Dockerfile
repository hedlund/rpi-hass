FROM resin/rpi-raspbian
MAINTAINER Henrik Hedlund <henrik@hedlund.im>

ARG HASS_VERSION

ENV ARCH=arm
ENV CROSS_COMPILE=/usr/bin/

# Update and install python
RUN apt-get update && \
    apt-get install -y build-essential python3-dev python3-pip ssh cython3 libudev-dev python3-sphinx python3-setuptools git && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /build && \
	git clone --recursive --depth 1 https://github.com/OpenZWave/python-openzwave.git /build/python-openzwave && \
	cd /build/python-openzwave && \
	pip3 install --upgrade cython==0.24.1 && \
	PYTHON_EXEC=`which python3` make build && \
	PYTHON_EXEC=`which python3` make install

# Install Home Assistant
RUN pip3 install homeassistant==$HASS_VERSION

# Mouting point for the configuration
VOLUME /config

# Expose the default port of Home Assistant
EXPOSE 8123

# Entrypoint is Home Assistant with deafult parameters
CMD [ "python3", "-m", "homeassistant", "--config", "/config" ]
