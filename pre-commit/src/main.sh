#!/bin/bash

function main {
  cd $GITHUB_WORKSPACE
  pwd
  echo $GITHUB_WORKSPACE
  git init
  cat <<EOF > .pre-commit-config.yaml
  repos:
  - repo: https://github.com/antonbabenko/pre-commit-terraform
  rev: ${INPUT_REPOVERSION} # Get the latest from: https://github.com/antonbabenko/pre-commit-terraform/releases
  hooks:
    - id: terraform_fmt
    - id: terraform_docs
#    - id: terraform_validate
    - id: terrascan
    - id: terraform_tflint
    - id: terraform_tfsec
    - id: checkov
#    - id: infracost_breakdown
  ]
EOF
#IFS=';' read -ra ADDR <<< $INPUT_HOOKS
#for i in "${ADDR[@]}"; do
#  echo     - id: $i>> .pre-commit-config.yaml
#done
pre-commit run -a
}

main "${*}"
