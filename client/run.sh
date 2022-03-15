docker pull sitespeedio/browsertime
docker run --name client --shm-size=1g --rm -v "$(pwd)":/browsertime sitespeedio/browsertime -n 1 https://www.sitespeed.io/
