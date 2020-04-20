## docker-pimatic

Docker Image for pimatic on rasbperry pi 3 and other armv7 plattforms.

[![Build Status](https://travis-ci.org/michbeck100/docker-pimatic.svg?branch=master)](https://travis-ci.org/michbeck100/docker-pimatic)
[![This image on DockerHub](https://img.shields.io/docker/pulls/michbeck100/pimatic.svg)](https://hub.docker.com/r/michbeck100/pimatic/)

### Pull the image

docker pull michbeck100/pimatic

### Run the container

docker run \\ \
   -it \\ \
   --network=host \\ \
   -v /data-path:/data \\ \
   --device=/dev/ttyUSB0 \\ \
   michbeck100/pimatic

You can specify a device for homeduino or some other usb devices.

The container needs a mounted volume in /data.
In this folder must be placed the config.json and the sql database.
The image otherwise uses the default pimatic config and 
generates a inital sql database

- config.json
- pimatic-database.sqlite

The pimatic app folder inside the container is /opt/pimatic.
The default config exposes port 8282 and admin/admin as login credentials.
