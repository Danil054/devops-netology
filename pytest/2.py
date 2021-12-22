#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks","pwd", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
file_dir = result_os.split('\n')[0]
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(f"{file_dir}/{prepare_result}")
        
