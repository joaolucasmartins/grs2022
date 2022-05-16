FROM ubuntu:20.04

RUN apt update
RUN apt-get -y install nginx curl

ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]