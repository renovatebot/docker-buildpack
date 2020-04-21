#!/bin/bash

set -e

if ! [ -z ${NPM_VERSION+x} ]; then echo "No NPM_VERSION defined - skipping" && exit; fi

if ! [ -x "$(command -v node)" ]; then
  echo "No node found - abborting"
  exit 1
fi

echo "Installing npm $NPM_VERSION"

npm install -g npm@${NPM_VERSION}

npm --version
