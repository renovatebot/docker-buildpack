#!/bin/bash

set -e

if ! [ -z ${1+x} ]; then export NODE_VERSION=${1}; fi

if [ -z ${NODE_VERSION+x} ]; then echo "No NODE_VERSION defined - skipping" && exit; fi

SEMVER_REGEX="^(0|[1-9][0-9]*)(\.(0|[1-9][0-9]*))?(\.(0|[1-9][0-9]*))?$"

if ! [[ "$NODE_VERSION" =~ $SEMVER_REGEX ]]; then
  echo Not a semver tag - skipping: ${NODE_VERSION}
  exit
fi

echo "Installing node $NODE_VERSION";

NODE_DISTRO=linux-x64

curl -sLo node.tar.xz https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-${NODE_DISTRO}.tar.xz
tar -C /usr/local -xf node.tar.xz
rm node.tar.xz

echo PATH="/usr/local/node-v${NODE_VERSION}-${NODE_DISTRO}/bin:\$PATH" >> /usr/local/docker/env
export PATH="/usr/local/node-v${NODE_VERSION}-${NODE_DISTRO}/bin:$PATH"

# update to latest node-gyp to fully support python3
npm explore npm -g -- npm install node-gyp@latest

echo node: $(node --version)
echo npm: $(npm --version)
