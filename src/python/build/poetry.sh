#!/bin/bash

set -e

install-pip poetry ${POETRY_VERSION}

poetry --version
