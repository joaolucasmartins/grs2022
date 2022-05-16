FROM ubuntu:20.04

RUN apt update && apt install -y vim iproute2 iputils-ping tcpdump iptables dnsutils curl
ENTRYPOINT /bin/sh -c "tail -f /dev/null"