## Задача 1: Установить Minikube  
Установили на Windows c Virtualbox  
Запустили командой:  
```
minikube start --vm-driver=virtualbox
```

Видим запущенные системные поды:  
```
C:\Windows\system32>kubectl get pods --namespace=kube-system
NAME                               READY   STATUS    RESTARTS      AGE
coredns-6d4b75cb6d-54d87           1/1     Running   0             31m
etcd-minikube                      1/1     Running   0             31m
kube-apiserver-minikube            1/1     Running   0             31m
kube-controller-manager-minikube   1/1     Running   0             31m
kube-proxy-24qtg                   1/1     Running   0             31m
kube-scheduler-minikube            1/1     Running   0             31m
storage-provisioner                1/1     Running   1 (30m ago)   31m
```

## Задача 2: Запуск Hello World  
Создали деплоймент для приложения командой:  
```
kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4
```
Сделали под доступным по сети командой:  
```
kubectl expose deployment hello-node --type=LoadBalancer --port=8080
```
Просмотр сервиса команой:  
```
C:\Windows\system32>kubectl get services
NAME         TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
hello-node   LoadBalancer   10.108.45.71   <pending>     8080:32557/TCP   29m
kubernetes   ClusterIP      10.96.0.1      <none>        443/TCP          35m
```
Установили аддоны командами:  
```
minikube addons enable dashboard
minikube addons enable ingress
```

## Задача 3: Установить kubectl  
kubectl установили, можно подключаться к кластеру mimikube:  
```
C:\Windows\system32>kubectl get nodes
NAME       STATUS   ROLES           AGE   VERSION
minikube   Ready    control-plane   39m   v1.24.3
```

