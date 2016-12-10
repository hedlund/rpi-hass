#!/bin/bash

HASS_VERSION=0.32.3

set -e

docker build -t hedlund/rpi-hass:$HASS_VERSION --build-arg HASS_VERSION=$HASS_VERSION .
docker push hedlund/rpi-hass:$HASS_VERSION

docker tag hedlund/rpi-hass:$HASS_VERSION hedlund/rpi-hass:latest
docker push hedlund/rpi-hass:latest
