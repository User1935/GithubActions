import sys
import json

data = sys.argv[1]
decdata = json.loads(data)
filecontent = ""
for ele in decdata['include']:
    filecontent += "\t- path: " + ele['path'][-1] + "\n"

yaml = '''
version: 0.1

projects:
'''
yaml += filecontent

with open('infracost.yml', 'r') as file:
    file.write(yaml)