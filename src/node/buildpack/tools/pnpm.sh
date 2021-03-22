#!/bin/bash

set -e

check_command node

if [[ $EUID -eq 0 ]]; then
  unset NPM_CONFIG_PREFIX
fi

npm install -g pnpm@${TOOL_VERSION}

pnpm --version

shell_wrapper pnpm
