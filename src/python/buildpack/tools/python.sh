#!/bin/bash

set -e

require_root
check_semver ${TOOL_VERSION}

PYTHON_URL="https://raw.githubusercontent.com/renovatebot/python/releases"


if [[ ! "${MAJOR}" || ! "${MINOR}" || ! "${PATCH}" ]]; then
  echo Invalid version: ${TOOL_VERSION}
  exit 1
fi

if [[ -d "/usr/local/python/${TOOL_VERSION}" ]]; then
  echo "Skipping, already installed"
  exit 0
fi

. /etc/lsb-release

mkdir -p /usr/local/python

curl -sSfLo python.tar.xz ${PYTHON_URL}/${DISTRIB_RELEASE}/python-${TOOL_VERSION}.tar.xz || echo 'Ignore download error'

if [[ -f python.tar.xz ]]; then
  echo 'Using prebuild python'
  tar -C /usr/local/python -xf python.tar.xz
  rm python.tar.xz
else
  echo 'No prebuild python found, building from source'
  apt_install \
    build-essential \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    zlib1g-dev \
    ;

  if [[ ! -x "$(command -v python-build)" ]]; then
    git clone https://github.com/pyenv/pyenv.git
    pushd pyenv/plugins/python-build
    ./install.sh
    popd
    rm -rf pyenv
  fi
  python-build $TOOL_VERSION /usr/local/python/$TOOL_VERSION
fi

export_path "\$HOME/.local/bin:/usr/local/python/$TOOL_VERSION/bin"

pip install --upgrade pip

# clean cache https://pip.pypa.io/en/stable/reference/pip_cache/#pip-cache
pip cache purge

python --version
