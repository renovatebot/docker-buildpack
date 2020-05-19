#!/bin/bash

set -e

check_command node

unset NPM_CONFIG_PREFIX
npm install -g yarn@${YARN_VERSION}

# do we really need this?
export_path "/home/ubuntu/.yarn/bin"

yarn --version
