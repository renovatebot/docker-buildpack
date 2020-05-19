#!/bin/bash

set -e

check_command node

unset NPM_CONFIG_PREFIX
npm install -g npm@${NPM_VERSION}

npm --version
