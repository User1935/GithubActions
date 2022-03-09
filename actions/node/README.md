# Node File Converter

The Node File Converter will convert any string encoded in base64 to a text file encoded in ucl-8

## Dependencies

node16

## Usage



```yaml
name: 'Terragrunt GitHub Actions'
on:
  - pull_request

jobs:
  terragrunt:
      - name: 'Make File with Content'
        run: 'node ./node/writeFile.js'
        env:
          FILE_OUTPUT: '<base64 enc content>'
```

FILE_OUTPUT is an environment variable that contains the base64 encrypted data.
