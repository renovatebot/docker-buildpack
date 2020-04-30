#!/bin/bash

set -e

NODE_DISTRO=linux-x64

curl -sLo node.tar.xz https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-${NODE_DISTRO}.tar.xz
tar -C /usr/local -xf node.tar.xz
rm node.tar.xz

export_path "/usr/local/node-v${NODE_VERSION}-${NODE_DISTRO}/bin"

# update to latest node-gyp to fully support python3
npm explore npm -g -- npm install node-gyp@latest

echo node: $(node --version)
echo npm: $(npm --version)

# backward compatibillity
shell_wrapper node
