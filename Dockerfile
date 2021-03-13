FROM arm32v7/node:10-buster

LABEL Description="Pimatic docker image for raspberry pi" Maintainer="michaelkotten@gmail.com" Version="1.1"

ENV TZ Europe/Berlin

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y git build-essential \
    avahi-daemon avahi-discover libnss-mdns libavahi-compat-libdnssd-dev \
    libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev
RUN rm -rf /var/lib/apt/lists/*

####### Install pimatic #######
RUN mkdir /opt/pimatic
RUN npm install pimatic --prefix /opt/pimatic --production
RUN cd /opt/pimatic/ && npm install sqlite3

COPY ./config.json /opt/pimatic/config.json

VOLUME ["/opt/pimatic"]

EXPOSE 80

CMD /etc/init.d/dbus start &&  \
   /etc/init.d/avahi-daemon start && \
   /usr/local/bin/nodejs /opt/pimatic/node_modules/pimatic/pimatic.js run
