#!/bin/bash

set -e

if [ -z ${PNPM_VERSION+x} ]; then echo "No PNPM_VERSION defined - skipping" && exit; fi

if ! [ -x "$(command -v node)" ]; then
  echo "No node found - abborting"
  exit 1
fi

echo "Installing pnpm $PNPM_VERSION"

npm install -g pnpm@${PNPM_VERSION}

pnpm --version
