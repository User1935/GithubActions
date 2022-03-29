import html2text
import sys
import os
import base64

# This script will format arg[1] text to a valid markdown language
# [INPUT] : arg1 -- html file
# [OUTPUT] : will be written to the same file

h = html2text.HTML2Text()


path2file = os.environ['GITHUB_WORKSPACE'] + '/something.txt'
print(path2file)
with open (path2file, 'r') as myfile:
    data=myfile.readlines()

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
message_bytes = finalstring.encode('utf-8')
base64_bytes = str(base64.b64encode(message_bytes))[2:-1]

with open (path2file, 'w') as myfile:
    myfile.write(base64_bytes)
