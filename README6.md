## Задача 1: Работа с сервис-аккаунтами через утилиту kubectl  

Создать сервис-аккаунт:
```
vagrant@vagrant:~/kub14-4$ kubectl create serviceaccount netology
serviceaccount/netology created
vagrant@vagrant:~/kub14-4$ 
```

Просмотреть список сервис-акаунтов:
```
vagrant@vagrant:~/kub14-4$ kubectl get serviceaccounts
NAME                                SECRETS   AGE
default                             0         77d
netology                            0         106s
nfs-server-nfs-server-provisioner   0         7d22h
vagrant@vagrant:~/kub14-4$ 
```

Получить информацию в формате YAML и/или JSON:
```
vagrant@vagrant:~/kub14-4$ kubectl get serviceaccount netology -o yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  creationTimestamp: "2022-11-27T10:00:16Z"
  name: netology
  namespace: default
  resourceVersion: "305885"
  uid: e0b642e4-2b39-4ccc-9eef-917a2570b0f8
vagrant@vagrant:~/kub14-4$ 
```
```
vagrant@vagrant:~/kub14-4$ kubectl get serviceaccount default -o json
{
    "apiVersion": "v1",
    "kind": "ServiceAccount",
    "metadata": {
        "creationTimestamp": "2022-09-10T14:51:31Z",
        "name": "default",
        "namespace": "default",
        "resourceVersion": "316",
        "uid": "842cae6a-8b98-49b7-a351-505c1861a27d"
    }
}
vagrant@vagrant:~/kub14-4$ 
```

Выгрузить сервис-акаунты и сохранить его в файл:
```
vagrant@vagrant:~/kub14-4$ kubectl get serviceaccounts -o json > serviceaccounts.json
vagrant@vagrant:~/kub14-4$ kubectl get serviceaccount netology -o yaml > netology.yml
vagrant@vagrant:~/kub14-4$ 
```

Удалить сервис-акаунт:
```
vagrant@vagrant:~/kub14-4$ kubectl delete serviceaccount netology
serviceaccount "netology" deleted
vagrant@vagrant:~/kub14-4$ 
```

Загрузить сервис-акаунт из файла:
```
vagrant@vagrant:~/kub14-4$ kubectl apply -f netology.yml
serviceaccount/netology created
vagrant@vagrant:~/kub14-4$ 
```
