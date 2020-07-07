#!/bin/bash

set -e

check_semver ${GOLANG_VERSION}


if [[ ! "${MAJOR}" || ! "${MINOR}" || ! "${PATCH}" ]]; then
  echo Invalid version: ${GOLANG_VERSION}
  exit 1
fi

if [[ -d "/usr/local/go/${GOLANG_VERSION}" ]]; then
  echo "Skipping, already installed"
  exit 0
fi

# fix version
GOLANG_FILE_VERSION=${GOLANG_VERSION}
if [[ "${PATCH}" == "0" ]]; then
  GOLANG_FILE_VERSION="${MAJOR}.${MINOR}"
fi

# go suggests: git svn bzr mercurial
apt_install bzr mercurial

mkdir -p /usr/local/go/${GOLANG_VERSION}
curl -sSL https://dl.google.com/go/go${GOLANG_FILE_VERSION}.linux-amd64.tar.gz --output go.tgz
tar --strip 1 -C /usr/local/go/${GOLANG_VERSION} -xzf go.tgz
rm go.tgz

export_env GOPATH "/go"
export_env CGO_ENABLED 0
export_env GOPROXY direct
export_env GOSUMDB off
export_path "/usr/local/go/${GOLANG_VERSION}/bin:\$GOPATH/bin"

mkdir -p "$GOPATH/src" "$GOPATH/bin" "$GOPATH/pkg"

chown -R ubuntu $GOPATH
chmod -R g+w $GOPATH

go version
go env
