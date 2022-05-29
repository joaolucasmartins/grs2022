FROM ubuntu:20.04

# So, installing resolvconf throws an error, which we don't care about. This error doesn't mean
# the installation was a failure, it is just dumb. As such, we use echo to make the command always
# succede (return 0). :D
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y vim iproute2 iputils-ping tcpdump dnsutils curl \
  w3m dhcpcd5 wireguard resolvconf || echo

COPY ./dhcpcd.conf /etc/dhcpcd.conf
COPY ./entry.sh /entry.sh

ENTRYPOINT ["/bin/sh", "/entry.sh"]
