FROM ubuntu:20.04

RUN apt update
RUN apt-get -y install nginx curl

COPY loadbalance.conf /etc/nginx/nginx.conf
COPY entry.sh /entry.sh

ENTRYPOINT ["/bin/sh", "/entry.sh"]
