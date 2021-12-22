#!/usr/bin/env python3

import socket
import time

service_list = ["drive.google.com", "mail.google.com", "google.com"]
tmp_pair = dict()

for init_key in service_list:
    init_value = socket.gethostbyname(init_key)
    tmp_pair[init_key] = init_value


while (True):
    for service in service_list:
        ip_service = socket.gethostbyname(service)
        print(f"{service} - {ip_service}")
        if (ip_service != tmp_pair[service]):
            print(f" [ERROR] {service} IP mismatch: {tmp_pair[service]} {ip_service} ")
        tmp_pair[service] = ip_service
    time.sleep(3)
    