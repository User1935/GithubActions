#!/bin/bash

function main {
  cd $GITHUB_WORKSPACE
  if [${INPUT_IS_PUSH} = 'true'}
  then
  echo '    - id: terraform_validate' >> .pre-commit-config.yaml
  fi
  #  sed 's/\x1b\[[0-9;]*m//g'
  pre-commit run -a | sed 's/\x1b\[[0-9;]*m//g' | tee comment_pre-commit.md
  base64 comment_pre-commit.md > b64encfile.md
  echo ::set-output name=filecontent::$(cat b64encfile.md)
  #echo ::set-output name=filecontent::$(cat comment_pre-commit.md)

  ## Set git users to the commit we are building from
  git config user.name "$(git --no-pager log --format=format:'%an' -n 1)"
  git config user.email "$(git --no-pager log --format=format:'%ae' -n 1)"
  git add .
  git commit -m "$INPUT_COMMIT"
  git push
}

main "${*}"
