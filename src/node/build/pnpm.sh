#!/bin/bash

set -e

check_command node

unset NPM_CONFIG_PREFIX
npm install -g pnpm@${PNPM_VERSION}

pnpm --version
