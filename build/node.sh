#!/bin/bash

set -e

if [ -z ${NODE_VERSION+x} ]; then echo "No NODE_VERSION defined - skipping" && exit; fi

SEMVER_REGEX="^(0|[1-9][0-9]*)(\.(0|[1-9][0-9]*))?(\.(0|[1-9][0-9]*))?$"

if ! [[ "$NODE_VERSION" =~ $SEMVER_REGEX ]]; then
  echo Not a semver tag - skipping: ${NODE_VERSION}
  exit
fi

echo "Installing node $NODE_VERSION";

curl -sL https://deb.nodesource.com/setup_${BASH_REMATCH[1]}.x | bash

apt-get update
apt-get install -y nodejs
rm -rf /var/lib/apt/lists/*

node --version
