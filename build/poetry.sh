#!/bin/bash

set -e

check_command python

export POETRY_HOME=/usr/local/poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python - --version ${POETRY_VERSION}

export_path "/usr/local/poetry/bin"

# fix executable flag
chmod +x /usr/local/poetry/bin/poetry

poetry config virtualenvs.in-project false
poetry --version
