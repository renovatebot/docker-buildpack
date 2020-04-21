#!/bin/bash

set -e

apt-get update && apt-get install -y bzr mercurial && rm -rf /var/lib/apt/lists/*

curl -s https://dl.google.com/go/go${GOLANG_VERSION}.linux-amd64.tar.gz --output go.tgz
tar -C /usr/local -xzf go.tgz
rm go.tgz

GOPATH=/go

mkdir -p "$GOPATH/src" "$GOPATH/bin"
chmod -R 777 "$GOPATH"

echo GOPATH=$GOPATH>> /usr/local/docker/env
echo CGO_ENABLED=0 >> /usr/local/docker/env
echo GOPROXY=direct >> /usr/local/docker/env
echo GOSUMDB=off >> /usr/local/docker/env
echo PATH="/usr/local/go/bin:$GOPATH/bin:\$PATH" >> /usr/local/docker/env

refreshenv
shell_wrapper go

go version
