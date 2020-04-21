#!/bin/bash

set -e

check_command node

echo "Installing pnpm $PNPM_VERSION"

npm install -g pnpm@${PNPM_VERSION}

link_wrapper yarn

pnpm --version
