import sys
import json
from os import getcwd

data = sys.argv[1]
decdata = json.loads(data)
filecontent = ''
for ele in decdata['include']:
    filecontent += '    - path: ' + ele['path'][:-1] + '\n'
yaml = '''
version: 0.1

projects:
'''
yaml += filecontent
print('JSON: {}'.format(data))
print(getcwd())
print(yaml)
with open('infracost.yml', 'w') as file:
    file.write(yaml)
