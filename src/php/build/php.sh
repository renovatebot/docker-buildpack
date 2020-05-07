#!/bin/bash

set -e

echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu bionic main" > /etc/apt/sources.list.d/ondrej-php.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C

apt_install php${PHP_VERSION}-cli php${PHP_VERSION}-mbstring php${PHP_VERSION}-curl php${PHP_VERSION}-xml php${PHP_VERSION}-json
