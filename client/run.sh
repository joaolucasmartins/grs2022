#!/bin/bash

docker pull sitespeedio/browsertime
docker run --name client -d --net client_net --ip 10.0.1.100 --cap-add=NET_ADMIN --shm-size=1g --rm -v "$(pwd)":/browsertime sitespeedio/browsertime -n 1 http://10.0.2.100
docker exec client /bin/bash -c 'ip r del default via 10.0.1.1'
docker exec client /bin/bash -c 'ip r a default via 10.0.1.254'
