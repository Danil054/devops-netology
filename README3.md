## Задача 1: Работа с картами конфигураций через утилиту kubectl  

### Создать карту конфигураций:  
```
root@vagrant:~/kub14-3# kubectl create configmap nginx-config --from-file=nginx.conf
configmap/nginx-config created
```
```
root@vagrant:~/kub14-3# kubectl create configmap domain --from-literal=name=netology.ru
configmap/domain created
```

### Просмотреть список карт конфигураций:  
```
root@vagrant:~/kub14-3# kubectl get configmaps
NAME               DATA   AGE
domain             1      45s
kube-root-ca.crt   1      70d
nginx-config       1      3m11s
root@vagrant:~/kub14-3#
```

### Просмотреть карту конфигурации:  
```
root@vagrant:~/kub14-3# kubectl get configmap nginx-config
NAME           DATA   AGE
nginx-config   1      5m25s
root@vagrant:~/kub14-3#
```
```
root@vagrant:~/kub14-3# kubectl describe configmap domain
Name:         domain
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
name:
----
netology.ru

BinaryData
====

Events:  <none>
root@vagrant:~/kub14-3#
```

### Получить информацию в формате YAML и/или JSON:  
```
root@vagrant:~/kub14-3# kubectl get configmap nginx-config -o yaml
apiVersion: v1
data:
  nginx.conf: |
    server {
        listen 80;
        server_name  netology.ru www.netology.ru;
        access_log  /var/log/nginx/domains/netology.ru-access.log  main;
        error_log   /var/log/nginx/domains/netology.ru-error.log info;
        location / {
            include proxy_params;
            proxy_pass http://10.10.10.10:8080/;
        }
    }
kind: ConfigMap
metadata:
  creationTimestamp: "2022-11-20T14:47:36Z"
  name: nginx-config
  namespace: default
  resourceVersion: "297827"
  uid: 833633de-4645-43b2-bb07-991d357c5b94
root@vagrant:~/kub14-3#
```
```
root@vagrant:~/kub14-3# kubectl get configmap domain -o json
{
    "apiVersion": "v1",
    "data": {
        "name": "netology.ru"
    },
    "kind": "ConfigMap",
    "metadata": {
        "creationTimestamp": "2022-11-20T14:50:02Z",
        "name": "domain",
        "namespace": "default",
        "resourceVersion": "298209",
        "uid": "7b1b381b-5e38-4160-a7ec-23214c3caf7a"
    }
}
root@vagrant:~/kub14-3#
```

### Выгрузить карту конфигурации и сохранить его в файл:  
```
root@vagrant:~/kub14-3# kubectl get configmaps -o json > configmaps.json
root@vagrant:~/kub14-3#
root@vagrant:~/kub14-3# kubectl get configmap nginx-config -o yaml > nginx-config.yml
root@vagrant:~/kub14-3#
```

### Удалить карту конфигурации:  
```
root@vagrant:~/kub14-3# kubectl delete configmap nginx-config
configmap "nginx-config" deleted
root@vagrant:~/kub14-3#
```

### Загрузить карту конфигурации из файла:  
```
root@vagrant:~/kub14-3# kubectl apply -f nginx-config.yml
configmap/nginx-config created
root@vagrant:~/kub14-3#
```
