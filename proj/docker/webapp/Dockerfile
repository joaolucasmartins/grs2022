FROM ubuntu:20.04

RUN apt update
RUN apt-get -y install nginx curl

RUN rm -rf /etc/nginx/sites-enabled/*
COPY loadbalance.conf /etc/nginx/conf.d/loadbalance.conf

ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]