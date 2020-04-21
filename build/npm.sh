#!/bin/bash

set -e

check_command node

echo "Installing npm $NPM_VERSION"

npm install -g npm@${NPM_VERSION}

npm --version
