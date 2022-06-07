FROM jasonrivers/nagios:latest
WORKDIR /
RUN apt update && apt install -y iproute2 iputils-ping w3m
COPY commands.cfg /opt/nagios/etc/objects/commands.cfg
COPY nagios.cfg /opt/nagios/etc/
COPY entry.sh /entry.sh

# Configuration file for the webapp
COPY app1.cfg /opt/nagios/etc/servers/

ENTRYPOINT ["/bin/sh", "entry.sh"]
