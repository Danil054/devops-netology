#!/usr/bin/env python3

import socket
import json
import yaml

service_list = ["drive.google.com", "mail.google.com", "google.com"]
tmp_dict = dict()
tmp_list = list()
for service in service_list:
    ip_service = socket.gethostbyname(service)
    tmp_dict[service] = ip_service
    tmp_list.append(tmp_dict)
    tmp_dict = {}

print(tmp_list)
with open("tst.yml","w") as file_yml:
    file_yml.write(yaml.dump(tmp_list))
with open("tst.json","w") as file_json:
    file_json.write(json.dumps(tmp_list))


