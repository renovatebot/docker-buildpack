#!/bin/bash

set -e

if [ -z ${YARN_VERSION+x} ]; then echo "No YARN_VERSION defined - skipping" && exit; fi

if [ -z ${NODE_VERSION+x} ]; then
  export NODE_VERSION=12
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  . $DIR/node.sh
fi

echo "Installing yarn $YARN_VERSION"

npm install -g yarn@${YARN_VERSION}
echo PATH="/home/ubuntu/.yarn/bin:\$PATH" >> /usr/local/docker/env

yarn --version
