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
