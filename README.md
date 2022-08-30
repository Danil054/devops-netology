## Задание 1: Запуск пода из образа в деплойменте  
Создаём деплоймент с двумя репликами:  
```
kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4 --replicas=2
```

Просмотр созданного деплоймента:  
```
C:\Windows\system32>kubectl get deployment
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
hello-node   2/2     2            2           6m53s
```

Просмотр подов:  
```
C:\Windows\system32> kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
hello-node-6d5f754cc9-4dr6h   1/1     Running   0          8m13s
hello-node-6d5f754cc9-wdtcw   1/1     Running   0          5m41s
```

## Задание 2: Просмотр логов для разработки  
Генерим ключ и сертификат для пользователя:  
```
openssl genrsa -out user1.key 2048
openssl req -new -key user1.key -out user1.csr -subj "/CN=user1/O=group1"
openssl x509 -req -in user1.csr -CA c:\Users\Family\.minikube\ca.crt -CAkey c:\Users\Family\.minikube\ca.key -CAcreateserial -out user1.crt -days 500
```

Создаём пользователя в конфигурации и связываем его с сертификатами:  
```
kubectl config set-credentials user1 --client-certificate=user1.crt --client-key=user1.key
```

Создаём контекст для пользователя:  
```
kubectl config set-context user1-context --cluster=minikube --user=user1
```

Создаём роль:  
role.yaml:  
```
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods", "pods/log"]
  verbs: ["get", "watch", "list"]
```

Создаём привязку роли:  
role-binding.yaml:  
```
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: read-pods
  namespace: default
subjects:
- kind: User
  name: user1 # Name is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role #this must be Role or ClusterRole
  name: pod-reader # must match the name of the Role
  apiGroup: rbac.authorization.k8s.io
```

Применяем роль и привязываем её:  
```
c:\Users\Family\.kube>kubectl apply -f role.yaml
role.rbac.authorization.k8s.io/pod-reader created

c:\Users\Family\.kube>kubectl apply -f role-binding.yaml
rolebinding.rbac.authorization.k8s.io/read-pods created
```

Переключиться в контекст нового пользователя можно командой:  
```
kubectl config use-context user1-context
```

## Задание 3: Изменение количества реплик  
Наращиваем реплики:  
```
kubectl scale --replicas=5 deployment/hello-node
```
Видно, что запустилось пять подов:  
```
c:\Users\Family\.kube>kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
hello-node-6d5f754cc9-4dr6h   1/1     Running   0          80m
hello-node-6d5f754cc9-8b7sh   1/1     Running   0          22s
hello-node-6d5f754cc9-p6dpm   1/1     Running   0          22s
hello-node-6d5f754cc9-vv5dl   1/1     Running   0          22s
hello-node-6d5f754cc9-wdtcw   1/1     Running   0          77m
```
