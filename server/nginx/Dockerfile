FROM nginx

# NGINX
RUN apt update && apt install -y \
iproute2 iputils-ping tcpdump \
iptables dnsutils curl
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# NAGIOS NRPE
WORKDIR /
RUN DEBIAN_FRONTEND=noninteractive apt install -y nagios-nrpe-server nagios-plugins
COPY run.sh .
COPY nrpe.cfg /etc/nagios/nrpe.cfg
RUN chmod +x run.sh
EXPOSE 80 5666
ENTRYPOINT ["./run.sh"]