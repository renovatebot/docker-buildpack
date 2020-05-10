#!/bin/bash

set -e

check_command node

npm install -g pnpm@${PNPM_VERSION}

pnpm --version
