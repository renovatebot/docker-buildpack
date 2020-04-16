#!/bin/bash

set -e

if [ -z ${NODE_VERSION+x} ]; then echo "No NODE_VERSION defined - skipping" && exit; else echo "Installing node $NODE_VERSION"; fi

curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash

apt-get update
apt-get install -y nodejs
rm -rf /var/lib/apt/lists/*

node --version
