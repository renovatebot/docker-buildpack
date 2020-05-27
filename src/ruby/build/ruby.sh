#!/bin/bash

set -e

check_semver ${RUBY_VERSION}


if [[ ! "${MAJOR}" || ! "${MINOR}" || ! "${PATCH}" ]]; then
  echo Invalid version: ${RUBY_VERSION}
  exit 1
fi

if [[ -d "/usr/local/ruby/${RUBY_VERSION}" ]]; then
  echo "Skipping, already installed"
  exit 0
fi

mkdir -p /usr/local/ruby

CODENAME=$(. /etc/os-release && echo ${VERSION_ID})
RUBY_URL="https://github.com/renovatebot/ruby/releases/download"

curl -sSfLo ruby.tar.xz ${RUBY_URL}/${RUBY_VERSION}/ruby-${RUBY_VERSION}-${CODENAME}.tar.xz || echo 'Ignore download error'

if [[ -f ruby.tar.xz ]]; then
  echo "Using prebuild ruby for ${CODENAME}"
  install-apt \
    build-essential \
    ;
  tar -C /usr/local/ruby -xf ruby.tar.xz
  rm ruby.tar.xz
else
  echo 'No prebuild ruby found, building from source'
  install-apt \
    build-essential \
    libreadline-dev \
    libssl-dev \
    zlib1g-dev \
    ;

  if [[ ! -x "$(command -v ruby-build)" ]]; then
    git clone https://github.com/rbenv/ruby-build.git
    PREFIX=/usr/local ./ruby-build/install.sh
    rm -rf ruby-build
  fi

  ruby-build $RUBY_VERSION /usr/local/ruby/${RUBY_VERSION}
fi

export_env GEM_HOME "/home/ubuntu/.gem-global"
export_path "\$GEM_HOME/bin:\$HOME/.gem/ruby/${MAJOR}.${MINOR}.0/bin:/usr/local/ruby/${RUBY_VERSION}/bin"

# System settings
mkdir -p /usr/local/ruby/${RUBY_VERSION}/etc
cat > /usr/local/ruby/${RUBY_VERSION}/etc/gemrc <<- EOM
gem: --no-document
:benchmark: false
:verbose: true
:update_sources: true
:backtrace: false
EOM



ruby --version
echo "gem $(gem --version)"

gem env
