FROM jasonrivers/nagios:latest
WORKDIR /
RUN apt update && apt install -y iproute2 iputils-ping
COPY app1.cfg /opt/nagios/etc/servers/
COPY commands.cfg /opt/nagios/etc/objects/commands.cfg
COPY nagios.cfg /opt/nagios/etc/