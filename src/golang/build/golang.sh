#!/bin/bash

set -e

# go suggests: git svn bzr mercurial
apt_install bzr mercurial

curl -sSL https://dl.google.com/go/go${GOLANG_VERSION}.linux-amd64.tar.gz --output go.tgz
tar -C /usr/local -xzf go.tgz
rm go.tgz

export_env GOPATH "/go"
export_env CGO_ENABLED 0
export_env GOPROXY direct
export_env GOSUMDB off
export_path "/usr/local/go/bin:\$GOPATH/bin"

mkdir -p "$GOPATH/src" "$GOPATH/bin" "$GOPATH/pkg"

chown -R ubuntu $GOPATH
chmod -R g+w $GOPATH

go version
go env
