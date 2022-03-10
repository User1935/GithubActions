#!/bin/bash

function main {
  cd $GITHUB_WORKSPACE
  if [${INPUT_IS_PUSH} = 'true'}
  then
  echo '    - id: terraform_validate' >> .pre-commit-config.yaml
  fi
  # ansi2html
  pre-commit run -a | sed 's/\x1b\[[0-9;]*m//g' | tee comment_pre-commit.md
  #echo Character Type $LC_CTYPE Language $LANG
  #base64 comment_pre-commit.md > b64encfile.md
  #echo ::set-output name=filecontent::$(cat b64encfile.md)
  echo ::set-output name=filecontent::$(cat comment_pre-commit.md)
}

main "${*}"
