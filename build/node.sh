#!/bin/bash

set -e

echo "Installing node $NODE_VERSION";

NODE_DISTRO=linux-x64

curl -sLo node.tar.xz https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-${NODE_DISTRO}.tar.xz
tar -C /usr/local -xf node.tar.xz
rm node.tar.xz

echo PATH="/usr/local/node-v${NODE_VERSION}-${NODE_DISTRO}/bin:\$PATH" >> /usr/local/docker/env

refreshenv

link_wrapper node
link_wrapper npm
link_wrapper npx

# update to latest node-gyp to fully support python3
npm explore npm -g -- npm install node-gyp@latest

echo node: $(node --version)
echo npm: $(npm --version)
