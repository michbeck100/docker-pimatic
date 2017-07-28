## docker-pimatic

### Pull the image

docker pull treban/pimatic

### Run the container

docker run -i -t -P -v /path-to-data-on-host:/data treban/pimatic

The container needs a mounted volume in /data.
In this folder must be placed the config.json and the sql database
- config.json
- pimatic-database.sqlite

The image uses otherwise the default pimatic config and 
generates a inital sql database
 
The pimatic app folder is /opt/pimatic-docker.
The image exposes port 4242.

### Environment variable
The images has a predefined variable to activate the healthcheck mechanism:
* HEALTHCHECK off [on/off] 
