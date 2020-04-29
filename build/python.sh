#!/bin/bash

set -e

check_semver ${PYTHON_VERSION}


if [[ ! "${MAJOR}" || ! "${MINOR}" || ! "${PATCH}" ]]; then
  echo Invalid version: ${PYTHON_VERSION}
  exit 1
fi


apt_install build-essential libssl-dev libreadline-dev zlib1g-dev libffi-dev

if [[ ! -x "$(command -v pyenv)" ]]; then
  su -c "git clone https://github.com/pyenv/pyenv.git /home/ubuntu/.pyenv" ubuntu
  export_env PYENV_ROOT /home/ubuntu/.pyenv
  export_path "$PYENV_ROOT/bin:$PYENV_ROOT/shims"
fi

export_path "/home/ubuntu/.local/bin"

PYENV=$PYENV_ROOT/bin/pyenv

su -c "$PYENV --version" ubuntu

su -c "$PYENV install $PYTHON_VERSION" ubuntu
su -c "$PYENV global $PYTHON_VERSION" ubuntu

su -c "$PYENV_ROOT/shims/python --version" ubuntu
