#!/bin/bash

set -e

check_command python

curl --silent https://bootstrap.pypa.io/get-pip.py | python - -U pip==$PIP_VERSION

pip --version
