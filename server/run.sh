docker-compose -f server/docker-compose.yml up -d --build
docker exec server /bin/bash -c 'ip r del default via 10.0.2.1'
docker exec server /bin/bash -c 'ip r a 10.0.1.0/24 via 10.0.2.254'
