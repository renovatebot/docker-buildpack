#!/bin/bash

set -e

check_version NPM_VERSION
check_command node

echo "Installing npm $NPM_VERSION"

npm install -g npm@${NPM_VERSION}

npm --version
