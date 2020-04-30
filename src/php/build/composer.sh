#!/bin/bash

set -e

check_command php

curl https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer | php -- --version=$COMPOSER_VERSION --install-dir=/usr/local/bin --filename=composer

composer --version
