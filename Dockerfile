FROM hedlund/rpi-raspbian
MAINTAINER Henrik Hedlund <henrik@hedlund.im>

# The version of Home Assistant needs to be specified at build time
ARG HASS_VERSION

# Install python-openzwave & Home Assistant
RUN mkdir /build && \
	git clone --recursive --depth 1 https://github.com/OpenZWave/python-openzwave.git /build/python-openzwave && \
	cd /build/python-openzwave && \
	pip3 install --upgrade cython==0.24.1 && \
	PYTHON_EXEC=`which python3` make build && \
	PYTHON_EXEC=`which python3` make install && \
	pip3 install homeassistant==$HASS_VERSION

RUN echo "deb http://download.telldus.com/debian/ stable main" >> /etc/apt/sources.list.d/telldus.list && \
    wget -qO - http://download.telldus.se/debian/telldus-public.key | apt-key add - && \
    apt-get update && apt-get install -y libtelldus-core2 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -rf /build

# Mouting point for the configuration
VOLUME /config
WORKDIR /config

# Expose the default port of Home Assistant
EXPOSE 8123

# Entrypoint is Home Assistant with default parameters
CMD [ "python3", "-m", "homeassistant", "--config", "/config" ]
