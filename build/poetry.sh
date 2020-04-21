#!/bin/bash

set -e

check_command python

# required by poetry, this will also install python3.6 on ubuntu 18.04
apt_install python3-distutils

export POETRY_HOME=/usr/local/poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python - --version ${POETRY_VERSION}

export_path "/usr/local/poetry/bin"

poetry config virtualenvs.in-project false
poetry --version
