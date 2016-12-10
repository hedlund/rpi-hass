FROM hedlund/rpi-raspbian
MAINTAINER Henrik Hedlund <henrik@hedlund.im>

# The version of Home Assistant needs to be specified at build time
ARG HASS_VERSION
ARG CYTHON_VERSION=0.24.1

# Install python, libtelldus, python-openzwave & Home Assistant
RUN apt-get update && apt-get install -y python3-dev python3-pip cython3 python3-sphinx python3-setuptools libtelldus-core2 && \
    pip3 install --upgrade cython==${CYTHON_VERSION} && \
	mkdir /build && \
	git clone --recursive --depth 1 https://github.com/OpenZWave/python-openzwave.git /build/python-openzwave && \
	cd /build/python-openzwave && \
	PYTHON_EXEC=`which python3` make build && \
	PYTHON_EXEC=`which python3` make install && \
	pip3 install homeassistant==${HASS_VERSION} && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /build

# Mouting point for the configuration
VOLUME /config
WORKDIR /config

# Expose the default port of Home Assistant
EXPOSE 8123

# Entrypoint is Home Assistant with default parameters
ENTRYPOINT [ "python3", "-m", "homeassistant", "--config", "/config" ]
