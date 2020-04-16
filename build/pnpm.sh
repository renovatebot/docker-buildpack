#!/bin/bash

set -e

if [ -z ${PNPM_VERSION+x} ]; then echo "No PNPM_VERSION defined - skipping" && exit; fi

if [ -z ${NODE_VERSION+x} ]; then
  export NODE_VERSION=12
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  . $DIR/node.sh
fi

echo "Installing pnpm $PNPM_VERSION"

npm install -g pnpm@${PNPM_VERSION}

pnpm --version
