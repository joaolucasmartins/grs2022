FROM nginx
RUN apt update && apt install -y \
iproute2 iputils-ping tcpdump \
iptables dnsutils curl
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
