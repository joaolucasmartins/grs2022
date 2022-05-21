FROM ubuntu:latest

RUN apt update && apt install -y isc-dhcp-server

RUN touch /var/lib/dhcp/dhcpd.leases

COPY dhcpd.conf /etc/dhcp/dhcpd.conf
COPY entry.sh /entry.sh
RUN chmod +x entry.sh

ENTRYPOINT ["/bin/sh", "/entry.sh"]
