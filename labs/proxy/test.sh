#!/bin/bash

echo "Test (HTTP)"
docker exec -it client-proxy-test /usr/bin/curl http://10.0.2.100
echo "Test (HTTPS)"
docker exec -it client-proxy-test /usr/bin/curl https://10.0.2.100
echo "Test (HTTP | Proxy)"
docker exec -it client-proxy-test /usr/bin/curl -x 10.0.1.253:3128 http://10.0.2.100
echo "Test (HTTPS | Proxy)"
docker exec -it client-proxy-test /usr/bin/curl -x 10.0.1.253:3128 https://10.0.2.100

docker exec router /bin/bash -c 'iptables -t filter -A FORWARD -p tcp --dport 80 ! -s 10.0.1.253 -j DROP'

# Delete iptables rule (Router)
# iptables -t filter -D FORWARD 1

# It will block...
echo "Test (HTTP | With Blocking IPtables rule)"
docker exec -it client-proxy-test /usr/bin/curl http://10.0.2.100
# It will block...
echo "Test (HTTPS | With Blocking IPtables rule)"
docker exec -it client-proxy-test /usr/bin/curl https://10.0.2.100
# It will SUCCEED!
echo "Test (HTTP | Proxy | With Blocking IPtables rule)"
docker exec -it client-proxy-test /usr/bin/curl -x 10.0.1.253:3128 http://10.0.2.100
# It will FAIL!
echo "Test (HTTPS | Proxy | With Blocking IPtables rule)"
docker exec -it client-proxy-test /usr/bin/curl -x 10.0.1.253:3128 https://10.0.2.100