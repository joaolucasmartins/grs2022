FROM ubuntu:20.04

RUN apt update && apt install -y vim nano iproute2 iputils-ping tcpdump iptables dnsutils curl
COPY ./netconfig.sh ./setDNS.sh ./
RUN chmod +x netconfig.sh setDNS.sh