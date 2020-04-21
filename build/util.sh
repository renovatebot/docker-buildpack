#!/bin/bash


function  refreshenv () {
  while IFS="=" read -r key value; do
  case "$key" in
      '#'*) ;;
      'PATH')
      eval export "$key=\"$value\""
      ;;
      *)
      eval export "$key=\${$key:-$value}"
  esac
  done < /usr/local/docker/env
}

refreshenv

# use this if custom env is required, creates a shell wrapper to /usr/local/bin
function shell_wrapper () {
  local FILE="/usr/local/bin/${1}"
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
  ln -sf $SOURCE $TARGET
}
