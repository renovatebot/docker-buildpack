#!/bin/bash

set -e

# System settings
echo 'install: --no-rdoc --no-ri' >> /etc/gemrc
echo 'update: --no-rdoc --no-ri' >> /etc/gemrc

# User settings
echo 'install: --no-rdoc --no-ri --user-install' >> /home/ubuntu/.gemrc
echo 'update: --no-rdoc --no-ri --user-install'  >> /home/ubuntu/.gemrc

install-apt ruby${RUBY_VERSION} ruby${RUBY_VERSION}-dev build-essential

ruby --version
gem --version
