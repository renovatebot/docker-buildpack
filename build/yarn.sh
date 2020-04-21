#!/bin/bash

set -e

if ! [ -z ${1+x} ]; then export YARN_VERSION=${1}; fi

if [ -z ${YARN_VERSION+x} ]; then echo "No YARN_VERSION defined - skipping" && exit; fi

if ! [ -x "$(command -v node)" ]; then
  echo "No node found - abborting"
  exit 1
fi

echo "Installing yarn $YARN_VERSION"

npm install -g yarn@${YARN_VERSION}
echo PATH="/home/ubuntu/.yarn/bin:\$PATH" >> /usr/local/docker/env

link_wrapper yarn

yarn --version
