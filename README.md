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
   -v /data-path:/opt/pimatic \\ \
   --device=/dev/ttyUSB0 \\ \
   michbeck100/pimatic

You can specify a device for homeduino or some other usb devices.

The container exposes a volume in /opt/pimatic.
Optionally place your config.json and your sqlite database into this folder.
The image otherwise uses the default pimatic config and 
generates an initial database.

- config.json
- pimatic-database.sqlite

The default config exposes port 80 and admin/admin as login credentials.
