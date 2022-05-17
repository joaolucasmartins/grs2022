FROM ubuntu:20.04

RUN apt update && apt install -y vim iproute2 iputils-ping tcpdump iptables dnsutils curl

COPY entry.sh /entry.sh
CMD /entry.sh
