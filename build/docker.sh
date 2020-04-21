#!/bin/bash

set -e

curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz -o docker.tgz
tar xzvf docker.tgz --strip 1 -C /usr/local/bin docker/docker
rm docker.tgz

docker --version
