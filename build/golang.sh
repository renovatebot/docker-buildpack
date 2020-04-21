#!/bin/bash

set -e

apt_install bzr mercurial

curl -sSL https://dl.google.com/go/go${GOLANG_VERSION}.linux-amd64.tar.gz --output go.tgz
tar -C /usr/local -xzf go.tgz
rm go.tgz

export_env GOPATH /go
export_env CGO_ENABLED 0
export_env GOPROXY direct
export_env GOSUMDB off
export_path "/usr/local/go/bin:$GOPATH/bin"

mkdir -p "$GOPATH/src" "$GOPATH/bin"
chmod -R 777 "$GOPATH"

go version
go env
