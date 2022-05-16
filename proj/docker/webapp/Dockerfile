FROM ubuntu:20.04

RUN apt update
RUN apt-get -y install nginx curl

#RUN rm /etc/nginx/sites-enabled/default
#COPY loadbalance.conf /etc/nginx/conf.d/loadbalance.conf
COPY loadbalance.conf /etc/nginx/nginx.conf

ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
