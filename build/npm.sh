#!/bin/bash

set -e

if [ -z ${NPM_VERSION+x} ]; then echo "No NPM_VERSION defined - skipping" && exit; fi

if [ -z ${NODE_VERSION+x} ]; then
  export NODE_VERSION=12
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  . $DIR/node.sh
fi

echo "Installing npm $NPM_VERSION"

npm install -g npm@${NPM_VERSION}

npm --version
