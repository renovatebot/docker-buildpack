#!/bin/bash

set -e

check_command node

npm install -g npm@${NPM_VERSION}

npm --version
