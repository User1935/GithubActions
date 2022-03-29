# Pre-commit
This action will get the stdout of the `pre-commit` command.
This action will format data from stdout.

## Dependencies
./.github/actions/pre-commit-output/dist/script.py - Script for formatting.
./somehting.txt - Output of pre-commit

## Outputs
`output`: Output encoded in base64 of the formatted data.
