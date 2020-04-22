#!/bin/bash

set -e

check_semver ${RUBY_VERSION}


if [[ ! "${MAJOR}" || ! "${MINOR}" ]]; then
  echo Invalid version: ${RUBY_VERSION}
  exit 1
fi

install-apt build-essential libssl-dev libreadline-dev zlib1g-dev


if [[ ! -x "$(command -v ruby-build)" ]]; then
  git clone https://github.com/rbenv/ruby-build.git
  PREFIX=/usr/local ./ruby-build/install.sh
  rm -rf ruby-build
fi

ruby-build $RUBY_VERSION /usr/local/ruby-${RUBY_VERSION}

export_path "\$HOME/.gem/ruby/${MAJOR}.${MINOR}.0/bin:/usr/local/ruby-${RUBY_VERSION}/bin"


# System settings
mkdir -p /usr/local/ruby-${RUBY_VERSION}/etc
cat > /usr/local/ruby-${RUBY_VERSION}/etc/gemrc <<- EOM
gem: --no-document
:benchmark: false
:verbose: true
:update_sources: true
:backtrace: false
EOM


# User settings
cat > /home/ubuntu/.gemrc <<- EOM
gem: --no-document --user-install
EOM

ruby --version
echo "gem $(gem --version)"
