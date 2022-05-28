FROM ubuntu:20.04

RUN apt update && apt install -y vim iproute2 iputils-ping tcpdump iptables dnsutils curl w3m

COPY ./entry.sh /entry.sh

ENTRYPOINT ["/bin/sh", "/entry.sh"]
