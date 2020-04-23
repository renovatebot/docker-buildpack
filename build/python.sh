#!/bin/bash

set -e

check_semver ${PYTHON_VERSION}


if [[ ! "${MAJOR}" || ! "${MINOR}" || ! "${PATCH}" ]]; then
  echo Invalid version: ${PYTHON_VERSION}
  exit 1
fi


apt_install build-essential libssl-dev libreadline-dev zlib1g-dev libffi-dev

if [[ ! -x "$(command -v pyenv)" ]]; then
  git clone https://github.com/pyenv/pyenv.git /usr/local/pyenv
  export_env PYENV_ROOT /usr/local/pyenv
  export_path "$PYENV_ROOT/bin:$PYENV_ROOT/shims"
fi

pyenv --version

pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION

python --version
