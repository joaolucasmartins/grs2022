FROM ubuntu:20.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y nginx curl nagios-nrpe-server nagios-plugins

# CONFIUGARION FILE IPS ARE HARD-CODED
COPY nrpe.cfg /etc/nagios/nrpe.cfg
COPY loadbalance.conf /etc/nginx/nginx.conf
COPY entry.sh /entry.sh

ENTRYPOINT ["/bin/sh", "/entry.sh"]
