#!/bin/bash

function main {
  cd $GITHUB_WORKSPACE
  if [${INPUT_IS_PUSH} = 'true'}
  then
  echo '    - id: terraform_validate' >> .pre-commit-config.yaml
  fi
  pre-commit run -a | tee comment_pre-commit.md
  echo ::set-output name=filecontent::$(cat comment_pre-commit.md)
}

main "${*}"
