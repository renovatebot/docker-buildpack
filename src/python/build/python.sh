#!/bin/bash

set -e

check_semver ${PYTHON_VERSION}

PYTHON_URL="https://raw.githubusercontent.com/renovatebot/python/releases"


if [[ ! "${MAJOR}" || ! "${MINOR}" || ! "${PATCH}" ]]; then
  echo Invalid version: ${PYTHON_VERSION}
  exit 1
fi

if [[ -d "/usr/local/python/${PYTHON_VERSION}" ]]; then
  echo "Skipping, already installed"
  exit 0
fi

DISTRIB_RELEASE=$(. /etc/os-release && echo ${VERSION_ID})

mkdir -p /usr/local/python

if [[ ! -x "$(command -v pyenv)" ]]; then
  git clone --depth=1 https://github.com/pyenv/pyenv.git /usr/local/pyenv
  export_path "/usr/local/pyenv/bin:/usr/local/pyenv/plugins/python-build/bin"
fi

curl -sSfLo python.tar.xz ${PYTHON_URL}/${DISTRIB_RELEASE}/python-${PYTHON_VERSION}.tar.xz || echo 'Ignore download error'

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

  python-build $PYTHON_VERSION /usr/local/python/$PYTHON_VERSION
fi

export_path "\$HOME/.local/bin:/usr/local/python/$PYTHON_VERSION/bin"

pip install -U pip

export_env PIP_USER yes

python --version
