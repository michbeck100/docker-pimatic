FROM arm32v7/node:10-buster

LABEL Description="Pimatic docker image for raspberry pi" Maintainer="michaelkotten@gmail.com" Version="1.0"

RUN apt update && apt-get -y upgrade
RUN apt-get install -y git build-essential \
    avahi-daemon avahi-discover libnss-mdns libavahi-compat-libdnssd-dev
RUN rm -rf /var/lib/apt/lists/*

####### Install pimatic #######
RUN mkdir /opt/pimatic
RUN npm install pimatic --prefix opt/pimatic --production
RUN cd /opt/pimatic/ && npm install sqlite3

RUN mkdir /data/
COPY ./config.json /data/config.json
RUN touch /data/pimatic-database.sqlite
RUN touch /opt/pimatic/pimatic-daemon.log
RUN mkdir /data/echo-database && mkdir /data/hap-database

####### volume #######
VOLUME ["/data"]
VOLUME ["/opt/pimatic"]

####### command #######
CMD ln -fs /data/config.json /opt/pimatic/config.json && \
   ln -fs /data/pimatic-database.sqlite /opt/pimatic/pimatic-database.sqlite && \
   ln -fs /data/echo-database /opt/pimatic/echo-database && \
   ln -fs /data/hap-database /opt/pimatic/hap-database && \
   /etc/init.d/dbus start &&  \
   /etc/init.d/avahi-daemon start && \
   /usr/local/bin/nodejs /opt/pimatic/node_modules/pimatic/pimatic.js start && \
   tail -f /opt/pimatic/pimatic-daemon.log
