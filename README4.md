## Задача 1: Работа с секретами через утилиту kubectl  

Генерируем пару ключей, и создаём секрет в кластере кубернетес:  
```
root@vagrant:~/kub14-1#
root@vagrant:~/kub14-1# openssl genrsa -out cert.key 4096
Generating RSA private key, 4096 bit long modulus (2 primes)
............................................++++
....................................................................................................................................++++
e is 65537 (0x010001)
root@vagrant:~/kub14-1#
root@vagrant:~/kub14-1# openssl req -x509 -new -key cert.key -days 3650 -out cert.crt \
> -subj '/C=RU/ST=Moscow/L=Moscow/CN=server.local'
root@vagrant:~/kub14-1#
```
```
root@vagrant:~/kub14-1#
root@vagrant:~/kub14-1# kubectl create secret tls domain-cert --cert=./cert.crt --key=./cert.key
secret/domain-cert created
root@vagrant:~/kub14-1#
```

Смотрим список секретов:  
```
root@vagrant:~/kub14-1# kubectl get secrets
NAME                               TYPE                 DATA   AGE
domain-cert                        kubernetes.io/tls    2      73s
sh.helm.release.v1.mynginx1.v1     helm.sh/release.v1   1      20h
sh.helm.release.v1.nfs-server.v1   helm.sh/release.v1   1      23h
root@vagrant:~/kub14-1#
```

Смотрим наш секрет domain-cert:  
```
root@vagrant:~/kub14-1#
root@vagrant:~/kub14-1# kubectl get secret domain-cert
NAME          TYPE                DATA   AGE
domain-cert   kubernetes.io/tls   2      3m27s
root@vagrant:~/kub14-1#
root@vagrant:~/kub14-1# kubectl describe secret domain-cert
Name:         domain-cert
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  kubernetes.io/tls

Data
====
tls.key:  3243 bytes
tls.crt:  1944 bytes
root@vagrant:~/kub14-1#
```

Сморим информацию в формате YAML:  
```
root@vagrant:~/kub14-1#
root@vagrant:~/kub14-1# kubectl get secret domain-cert -o yaml
apiVersion: v1
data:
  tls.crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUZiVENDQTFXZ0F3SUJBZ0lVQmkzVW8vNzVrekYzVXBzdmtsaURSWDhQc3FVd0RRWUpLb1pJaHZjTkFRRUwKQlFBd1JqRUxNQWtHQTFVRUJoTUNVbFV4RHpBTkJnTlZCQWdNQmsxdmMyTnZkekVQTUEwR0ExVUVCd3dHVFc5egpZMjkzTVJVd0V3WURWUVFEREF4elpYSjJaWEl1Ykc5allXd3dIaGNOTWpJeE1USXdNVEF6TmpVeFdoY05Nekl4Ck1URTNNVEF6TmpVeFdqQkdNUXN3Q1FZRFZRUUdFd0pTVlRFUE1BMEdBMVVFQ0F3R1RXOXpZMjkzTVE4d0RRWUQKVlFRSERBWk5iM05qYjNjeEZUQVRCZ05WQkFNTURITmxjblpsY2k1c2IyTmhiRENDQWlJd0RRWUpLb1pJaHZjTgpBUUVCQlFBRGdnSVBBRENDQWdvQ2dnSUJBS29SNmFNWlM5OEgwVzVjb1EzS0dQRHhoZHVYTTJQOVZOUUlVK0FuCk16Z0Vhakc5QlhaRHJyL3Y4bHovMy93SXZhN0hibnU0ZHFkeEx1bFVScHRhZVhqNHlROWNkbWk4WkhUWTFsc0MKa24rWnVDN1RJZmcwMU1qVHIvRStRbU9oWGNxRHQxMUNwU1QxVGtNZFBrYWNJR1QwUllQY3ZhQ2xsR3hYd3JpcwpMUnJwTnJDWGRUeW1nV041K0gyOVc1N2NQSnZ0VTFEbzVMTEE4cno2WnhvY0c5YjRQcXkxdFFxYlpMWmJjVng4CjdsdWYwSm5iUWh4cjdSRlM0aTM3bm1LVHlTVzlFUFJWU1RzVEIycGJZL2RQdFNnSjdwaU9YMHBjbW9KUFFvREoKTkpWUjdFcVFVNWw2ZzJoU0Vyc2pnNnordXRlbmRXWE9ZTzdZUmVPKzlCNGZDbG5QaWN0VHdkYzJBazh5MTdRZQpKZWZwSzZSY3ZsTFQxbW0rczkyZVBLdWdEWFgrWkZkRmVTUnJEMHBjNXV1aHI0dVM0WmxXYi9yQUVtQnJ5QllDCkdSRHVjak9pYm9RUW1YYndmdXVhY3R6SnRmbzJDNUJnUW4ySnhZd3ZLR3FET1U2WjZFQ250cUtqMFd3VHhDclMKcnN0c0U0bUZ3NXd6UWRkQ0NsVkZ1MlJTQWtaamo2eVFIWU1ROW9RWjdYNStSNGhxMGt3eU9yMStLVVdwVDNsNgpnaUxrbE1TUTY5My9pcDRUNkVIcTF4aHVmSCt4ZFRJR2U0LzA1T2p6S2dtSjJmRWl1N0htN2JMOWlSOGozb3Y3CnB6OFRlOGtiTzFoY3puMzZveW9ncnNwajRDdDlYRzFSU01MeGc4S2wwWFRoRkI3NDhteGhtNWN3R1R2dG1FQmYKdFd0M0FnTUJBQUdqVXpCUk1CMEdBMVVkRGdRV0JCU3loRC8yUkNuQm9aZ2tkWjlwRVFBc2Q0K2R2ekFmQmdOVgpIU01FR0RBV2dCU3loRC8yUkNuQm9aZ2tkWjlwRVFBc2Q0K2R2ekFQQmdOVkhSTUJBZjhFQlRBREFRSC9NQTBHCkNTcUdTSWIzRFFFQkN3VUFBNElDQVFDbnkxWWZ1d2JoVUlUaFkzcnZpRlBXU1c5YnJ6UExyRjVPbU0ycWhsR2sKdHBDZUpXbFFFbW9OY1pWcW5vT0gvdDVyYVhWOVgvYUhSUFZGWUpjd1Q0a3VGZDBFWkRpN251blJSZ1FHTGY4NwpjS0dyNU1wYXR6Mzg2Q2dGaVVRYkVwMFNVdlFXUjJHK3pwU2l6V2svdU4xK1g5UlVoSWJERXZrcEhnNjgzUk15CkhCUWZkYkJYcG9CZUw2dXkycllqN20vRExScVh2T3F5V0xjb3JKSHIvVW9KVlg4RjRTMWlqdWwyeDBsMVVUa2wKS0dNV3hwZk40N3kzUCtQeFNSaEs3M1pwem5xRDErcytEd0NiempZRkpvSDY2cVY3WU9tU2d6OXZ4bElzR25SUApZT1pEelJTOHRxaE5CZHEyRW0wK2NPYk56VlNaTW52azhvYXJ4cWlJdnZQQjRaRFczWFBJaE5TV212QmdvWllCCitHSjBxdk52RWJpSjlnRGxQSGN4U2ljRUN0WTBhZ2d3SVBQT21LRzhjTVRUcE9Mb0UxcUJESVNPMEYxckNJa2kKRXlqTzkrNTNhcFlZV1NYOGd2NjA1d3podHhxeXVJV1Y1VlB6UjVJN1BXYlp6cDJuUVNNczVnbTZQekhTbGV1dAp1Rm5qbUJtMFN0dWdGdVh6M0hwRDQvMGRXQzdnME42eEIzb2pCYURxUlNtZlQzVVFNUTVBVVltMkROR2NtU1FDCmovOG5FMWQyMXY4VDRWdnZCQm4zZ2F1cWdHTCtnRzNUNXprYVlYNDYrWEhDZHVyV093OFJJaTdwbjMxMlhXQUEKcUpmc1ZOUEZIMlpqc1U4Qk1YMlY1N3IrUWJKZHpPOWN4dkRKRUtPQXBUanZGbDBCNXhXa3lTRUpWUVNZL1FrZwpjZz09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
  tls.key: LS0tLS1***
kind: Secret
metadata:
  creationTimestamp: "2022-11-20T10:38:12Z"
  name: domain-cert
  namespace: default
  resourceVersion: "262229"
  uid: 2325af3b-a1da-423c-a44e-ec5c38e832c2
type: kubernetes.io/tls
root@vagrant:~/kub14-1#
```

Выгружаем секрет в файл:  
```
root@vagrant:~/kub14-1#
root@vagrant:~/kub14-1# kubectl get secret domain-cert -o yaml > domain-cert.yml
root@vagrant:~/kub14-1#
```

Удаляем секрет:  
```
root@vagrant:~/kub14-1#
root@vagrant:~/kub14-1# kubectl delete secret domain-cert
secret "domain-cert" deleted
root@vagrant:~/kub14-1#
```

Загружаем секрет из файла:  
```
root@vagrant:~/kub14-1#
root@vagrant:~/kub14-1# kubectl apply -f domain-cert.yml
secret/domain-cert created
root@vagrant:~/kub14-1#
```


