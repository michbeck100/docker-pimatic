FROM arm32v7/node:10-buster

LABEL Description="Pimatic docker image for raspberry pi" Maintainer="michaelkotten@gmail.com" Version="1.0"

RUN apt update && apt-get -y upgrade
RUN apt-get install -y git build-essential \
    avahi-daemon avahi-discover libnss-mdns libavahi-compat-libdnssd-dev
RUN rm -rf /var/lib/apt/lists/*

####### Install pimatic #######
RUN mkdir /opt/pimatic
RUN npm install pimatic --prefix opt/pimatic --production

RUN mkdir /data/
COPY ./config.json /data/config.json
RUN touch /data/pimatic-database.sqlite
RUN mkdir /data/echo-database && mkdir /data/hap-database

####### Configure autostart #######
RUN cd /opt/pimatic/node_modules/pimatic && npm link
RUN wget https://raw.githubusercontent.com/pimatic/pimatic/master/install/pimatic.service && \
    cp pimatic.service /lib/systemd/system/ && \
    chown root:root /lib/systemd/system/pimatic.service && \
    systemctl daemon-reload && \
    systemctl enable pimatic

####### volume #######
VOLUME ["/data"]
VOLUME ["/opt/pimatic"]

ENV PIMATIC_DAEMONIZED=true

####### command #######
CMD ln -fs /data/config.json /opt/pimatic/config.json && \
   ln -fs /data/pimatic-database.sqlite /opt/pimatic/pimatic-database.sqlite && \
   ln -fs /data/echo-database /opt/pimatic/echo-database && \
   ln -fs /data/hap-database /opt/pimatic/hap-database && \
   service dbus start &&  \
   service avahi-daemon start && \
   service pimatic start && \
   bash
