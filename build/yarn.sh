#!/bin/bash

set -e

check_version YARN_VERSION
check_command node

echo "Installing yarn $YARN_VERSION"

npm install -g yarn@${YARN_VERSION}
echo PATH="/home/ubuntu/.yarn/bin:\$PATH" >> /usr/local/docker/env

link_wrapper yarn

yarn --version
