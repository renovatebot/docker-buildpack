#!/bin/bash

if [ -z ${COMPOSER_VERSION+x} ]; then echo "No COMPOSER_VERSION defined - skipping" && exit; else echo "Installing Composer $COMPOSER_VERSION"; fi

echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu bionic main" > /etc/apt/sources.list.d/ondrej-php.list 
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C 
apt-get update 
apt-get -y install php7.4-cli php7.4-mbstring php7.4-curl 
rm -rf /var/lib/apt/lists/*

curl https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer | php -- --version=$COMPOSER_VERSION --install-dir=/usr/local/bin --filename=composer

composer --version
