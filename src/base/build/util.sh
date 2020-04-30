#!/bin/bash

function refreshenv () {
  if [[ -f $BASH_ENV ]]; then
    . $BASH_ENV
  fi
}

refreshenv

function export_env () {
  export ${1}=${2}
  echo export ${1}=\${${1}-${2}} >> $BASH_ENV
}

function export_path () {
  export PATH="$1:$PATH"
  echo export PATH="$1:\$PATH" >> $BASH_ENV
}


# use this if custom env is required, creates a shell wrapper to /usr/local/bin
function shell_wrapper () {
  local FILE="/usr/local/bin/${1}"
  check_command $1
  cat > $FILE <<- EOM
#!/bin/bash

if [[ -f \$BASH_ENV ]]; then
  . \$BASH_ENV
fi

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


SEMVER_REGEX="^(0|[1-9][0-9]*)(\.(0|[1-9][0-9]*))?(\.(0|[1-9][0-9]*))?([a-z-].*)?$"

function check_semver () {
  if [[ ! "${1}" =~ ${SEMVER_REGEX} ]]; then
    echo Not a semver like version - aborting: ${1}
    exit 1
  fi
  export MAJOR=${BASH_REMATCH[1]}
  export MINOR=${BASH_REMATCH[3]}
  export PATCH=${BASH_REMATCH[5]}
}


function apt_install () {
  echo "Installing apt packages: ${@}"
  apt-get update
  apt-get install -y $@
}
