FROM ubuntu:20.04

RUN apt update && apt install -y vim iproute2 iputils-ping tcpdump iptables dnsutils curl

COPY entry.sh /entry.sh
COPY forwardWebapp.sh /forwardWebapp.sh
COPY nat.sh /nat.sh

ENTRYPOINT ["/bin/sh", "entry.sh"]
