FROM nginx
RUN apt update && apt install -y \
iproute2 iputils-ping tcpdump \
iptables dnsutils curl
COPY index.html /usr/share/nginx/html
