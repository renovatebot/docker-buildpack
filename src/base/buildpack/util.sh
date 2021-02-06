#!/bin/bash

function refreshenv () {
  if [[ -f $BASH_ENV ]]; then
    . $BASH_ENV
  fi
}

if [[ -z "${BUILDPACK+x}" ]]; then
  refreshenv
fi

function export_env () {
  export "${1}=${2}"
  echo export "${1}=\${${1}-${2}}" >> $BASH_ENV
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

if [[ -f "\$BASH_ENV" && -z "${BUILDPACK+x}" ]]; then
  . \$BASH_ENV
fi

if [[ "\$(command -v ${1})" == "$FILE" ]]; then
  echo Could not forward ${1}, probably wrong PATH variable. >2
  echo PATH=\$PATH
  exit 1
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
  echo "Function 'check_version' is deprecated, use 'require_tool' instead." >2
  local VERSION_PREFIX="^v?(.+)"
  if [[ -z ${!1+x} ]]; then
    echo "No ${1} defined - aborting: ${!1}"
    exit 1
  elif [[ "${!1}" =~ ${VERSION_PREFIX} ]]; then
    # trim leading v
    export "$1=${BASH_REMATCH[1]}"
  fi
}

function check_command () {
  if [[ ! -x "$(command -v ${1})" ]]; then
    echo "No ${1} defined - aborting" >2
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


function require_root () {
  if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" >2
    exit 1
  fi
}

function require_user () {
  if [[ -z "${USER_NAME+x}" ]]; then
    echo "No USER_NAME defined - skipping: ${USER_NAME}" >2
    exit 1;
  fi
}

function require_tool () {
  local tool=$1
  local tool_env=$(t=${tool//-/_} echo ${t^^}_VERSION)
  local version=${2-$tool_env}

  if [[ -z "${1+x}" ]]; then
    echo "No tool defined - skipping: ${tool}" >2
    exit 1;
  fi

  if [[ -z ${version+x} ]]; then
    echo "No version defined - aborting: ${version}" >2
    exit 1
  fi

  local VERSION_PREFIX="^v?(.+)"
  if [[ "${version}" =~ ${VERSION_PREFIX} ]]; then
    # trim leading v
    version=${BASH_REMATCH[1]}
  fi

  export "TOOL_NAME=${1}" "TOOL_VERSION=${version}"

  # compability fallback
  export "${tool_env}=${version}"
}
