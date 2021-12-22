#!/usr/bin/env python3

import os
import sys

file_dir = sys.argv[1]
git_dir = ".git"
list_dir = os.listdir(file_dir)

if git_dir not in list_dir:
    print("Is it not git directory")
    sys.exit()

cmd_1 = "cd " + file_dir
bash_command = [cmd_1, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(f"{file_dir}/{prepare_result}")
        
