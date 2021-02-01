#!/bin/bash

set -e

check_semver $NODE_VERSION

if [[ ! "${MAJOR}" || ! "${MINOR}" ]]; then
  echo Invalid version: ${NODE_VERSION}
  exit 1
fi


NODE_DISTRO=linux-x64
NODE_INSTALL_DIR=/usr/local/node/${NODE_VERSION}

if [[ -d "${NODE_INSTALL_DIR}" ]]; then
  echo "Skipping, already installed"
  exit 0
fi


mkdir -p $NODE_INSTALL_DIR

curl -sLo node.tar.xz https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-${NODE_DISTRO}.tar.xz
tar -C ${NODE_INSTALL_DIR} --strip 1 -xf node.tar.xz
rm node.tar.xz

export_path "${NODE_INSTALL_DIR}/bin"

if [[ ${MAJOR} < 15 ]]; then
  # update to latest node-gyp to fully support python3
  npm explore npm -g -- npm install --cache /tmp/empty-cache node-gyp@latest
fi

echo node: $(node --version) $(command -v node)
echo npm: $(npm --version)  $(command -v npm)

if [[ ${MAJOR} < 15 ]]; then
  # backward compatibillity
  shell_wrapper node
fi

NPM_CONFIG_PREFIX="/home/${USER_NAME}/.npm-global"

# npm 7 bug
mkdir -p $NPM_CONFIG_PREFIX/{bin,lib}
chown -R $NPM_CONFIG_PREFIX
chmod -R g+w $NPM_CONFIG_PREFIX

# redirect user install
export_env NPM_CONFIG_PREFIX $NPM_CONFIG_PREFIX
export_path "\$NPM_CONFIG_PREFIX/bin"
