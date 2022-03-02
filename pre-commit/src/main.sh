#!/bin/bash

function main {
  cd $GITHUB_WORKSPACE
  #IFS=';' read -ra ADDR <<< $INPUT_HOOKS
  #for i in "${ADDR[@]}"; do
  #  echo     - id: $i>> .pre-commit-config.yaml
  #done
  pre-commit run -a
}

main "${*}"
