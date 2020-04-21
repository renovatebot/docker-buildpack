#!/bin/bash

function refreshenv () {
  . /usr/local/docker/env
}

function export_env () {
  export ${1}=${2}
  echo export ${1}=\${${1}-${2}} >> /usr/local/docker/env
}
function export_path () {
  export PATH="$1:$PATH"
  echo export PATH="$1:\$PATH" >> /usr/local/docker/env
}

refreshenv

# use this if custom env is required, creates a shell wrapper to /usr/local/bin
function shell_wrapper () {
  local FILE="/usr/local/bin/${1}"
  check_command $1
  cat > $FILE <<- EOM
#!/bin/bash

. /usr/local/build/util.sh

${1} \${@}
EOM
  chmod +x $FILE
}

# use this for simple symlink to /usr/local/bin
function link_wrapper () {
  local TARGET="/usr/local/bin/${1}"
  local SOURCE=$(command -v ${1})
  check_command $1
  ln -sf $SOURCE $TARGET
}


function check_version () {
  if [[ -z ${!1+x} ]]; then
    echo "No ${1} defined - aborting: ${!1}"
    exit 1
  fi
}

function check_command () {
  if [[ ! -x "$(command -v ${1})" ]]; then
    echo "No ${1} defined - aborting"
    exit 1
  fi
}


SEMVER_REGEX="^(0|[1-9][0-9]*)(\.(0|[1-9][0-9]*))?(\.(0|[1-9][0-9]*))?$"

function check_semver () {
  if [[ ! "${1}" =~ ${SEMVER_REGEX} ]]; then
    echo Not a semver like version - aborting: ${1}
    exit 1
  fi
  export MAJOR=${BASH_REMATCH[1]}
  export MINOR=${BASH_REMATCH[3]}
}


function apt_install () {
  echo "Installing apt packages: ${@}"
  apt-get update
  apt-get install -y $@
}
