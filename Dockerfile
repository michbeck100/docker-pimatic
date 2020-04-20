FROM arm32v7/node:10-buster

LABEL Description="Pimatic docker image for raspberry pi" Maintainer="michaelkotten@gmail.com" Version="1.0"

RUN apt update && apt-get -y upgrade
RUN apt-get install -y git build-essential \
    libnss-mdns libavahi-compat-libdnssd-dev
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir /opt/pimatic
RUN cd /opt && npm install pimatic --prefix pimatic --production

RUN mkdir /data/
COPY ./config.json /data/config.json
RUN touch /data/pimatic-database.sqlite

####### volume #######
VOLUME ["/data"]
VOLUME ["/opt/pimatic"]

ENV PIMATIC_DAEMONIZED=true

####### command #######
CMD ln -fs /data/config.json /opt/pimatic/config.json && \
   ln -fs /data/pimatic-database.sqlite /opt/pimatic/pimatic-database.sqlite && \
   /etc/init.d/dbus start &&  \
   /etc/init.d/avahi-daemon start && \
   /usr/bin/nodejs /opt/pimatic/node_modules/pimatic/pimatic.js
