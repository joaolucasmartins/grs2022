FROM ubuntu:latest

RUN apt update && apt install -y isc-dhcp-server iproute2 iputils-ping tcpdump dnsutils iptables

RUN touch /var/lib/dhcp/dhcpd.leases

COPY dhcpd.conf /etc/dhcp/dhcpd.conf
COPY entry.sh /entry.sh

ENTRYPOINT ["/bin/sh", "/entry.sh"]
