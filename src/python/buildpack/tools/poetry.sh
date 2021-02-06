#!/bin/bash

set -e

install-pip poetry ${TOOL_VERSION}

poetry --version
