from cProfile import run
import html2text
import sys
import os
import base64

# This script will format arg[1] text to a valid markdown language
# [INPUT] : arg1 -- html file
# [OUTPUT] : will be written to the same file

h = html2text.HTML2Text()

runtype = os.environ['INPUT_TYPE']
relpath = os.environ['INPUT_FILEPATH']
path2file = os.environ['GITHUB_WORKSPACE'] + '/' + relpath + 'output-planfile'
print(path2file)
with open (path2file, 'r') as myfile:
    data = myfile.readlines()
if (runtype == 'pre-commit'):
    #📈
    finalstring = '# Pre-Commit Log \n'

    for s in data:
        # Filter info
        if not ('[INFO]' in s):
            if('Failed' in s or 'Passed' in s or 'Skipped' in s ):
                finalstring += '</pre></details><details><summary>' + s + '</summary><pre>'
            else:
                finalstring += s
    finalstring += '</pre></details>'

elif(runtype == 'terragrunt'):

    finalstring = '# TerraGrunt Log\n ### [{}]\n<pre>'.format(os.environ['INPUT_FILEPATH'])
    flag = False
    for s in data:
        # Filter info
        if( 'Terraform will perform the following actions:' in s) or ('────────────────' in s):
            flag = not flag
        if (flag):
            finalstring += s
    finalstring += '</pre>'


# OUTPUT ENCODING
message_bytes = finalstring.encode('utf-8')
base64_bytes = str(base64.b64encode(message_bytes))[2:-1] # remove b' '

with open (path2file, 'w') as myfile:
    myfile.write(base64_bytes)
