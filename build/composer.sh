#!/bin/bash

set -e

if ! [ -z ${1+x} ]; then export COMPOSER_VERSION=${1}; fi

if [ -z ${COMPOSER_VERSION+x} ]; then echo "No COMPOSER_VERSION defined - skipping" && exit; fi

if ! [ -x "$(command -v php)" ]; then
  echo "No php found - abborting"
  exit 1
fi

echo "Installing Composer $COMPOSER_VERSION";
curl https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer | php -- --version=$COMPOSER_VERSION --install-dir=/usr/local/bin --filename=composer

composer --version
