#!/bin/bash

set -e

check_command node

npm install -g yarn@${YARN_VERSION}

# do we really need this?
export_path "/home/ubuntu/.yarn/bin"

yarn --version
