#!/bin/bash

set -e

check_command python3

export POETRY_HOME=/usr/local/poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 - --version ${POETRY_VERSION}

export_path "/usr/local/poetry/bin"

# fix executable flag
chmod +x /usr/local/poetry/bin/poetry

# fix python version
sed -i 's/^#!\/usr\/bin\/env python$/#!\/usr\/bin\/env python3/' /usr/local/poetry/bin/poetry

poetry config virtualenvs.in-project false
poetry --version
