## Задание 1: подготовить тестовый конфиг для запуска приложения  

Создадим два неймспэйса stage и production  
Применив файлы:  
```
kubectl apply -f ns-production.yaml,ns-stage.yaml
```
Содержание файлов:  
```
root@vagrant:~/kub13-1/13-kubernetes-config# cat ns-stage.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: stage

root@vagrant:~/kub13-1/13-kubernetes-config# cat ns-production.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: production
```

Подготовили yaml файл для запуска в stage окружении: [deploystage.yaml](https://github.com/Danil054/devops-netology/blob/main/kub/deploystage.yaml)  

После его применения:  
```
 kubectl apply -f deploystage.yaml
```
Запустились поды и сервисы в stage наймспэйсе:  
```
root@vagrant:~/kub13-1/13-kubernetes-config# kubectl get pods -n stage -o wide
NAME                         READY   STATUS    RESTARTS   AGE   IP             NODE    NOMINATED NODE   READINESS GATES
db-0                         1/1     Running   0          49m   10.233.74.77   node4   <none>           <none>
front-back-fb58c9457-xx8pv   2/2     Running   0          50m   10.233.71.18   node3   <none>           <none>
root@vagrant:~/kub13-1/13-kubernetes-config#
root@vagrant:~/kub13-1/13-kubernetes-config#
root@vagrant:~/kub13-1/13-kubernetes-config# kubectl get services -n stage -o wide
NAME         TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE   SELECTOR
db           NodePort   10.233.0.106    <none>        5432:30725/TCP   52m   dbs=db
front-back   NodePort   10.233.30.159   <none>        8000:30772/TCP   52m   apps=front-back
root@vagrant:~/kub13-1/13-kubernetes-config#
```

## Задание 2: подготовить конфиг для production окружения  

Подготовили yaml файл для запуска в production окружении: [deployprod.yaml](https://github.com/Danil054/devops-netology/blob/main/kub/deployprod.yaml)  
Применяем его:  
```
root@vagrant:~/kub13-1/13-kubernetes-config# kubectl apply -f deployprod.yaml
deployment.apps/frontend created
deployment.apps/backend created
service/frontend created
service/backend created
statefulset.apps/db created
service/db created
```

Проверяем запущенные поды и сервисы в production нэймспэйсе:  
```
root@vagrant:~/kub13-1/13-kubernetes-config# kubectl get pods -n production -o wide
NAME                        READY   STATUS    RESTARTS   AGE     IP               NODE    NOMINATED NODE   READINESS GATES
backend-58c8869d57-fjqw9    1/1     Running   0          2m40s   10.233.71.19     node3   <none>           <none>
db-0                        1/1     Running   0          2m40s   10.233.102.151   node1   <none>           <none>
frontend-55866fb786-gp7hb   1/1     Running   0          2m40s   10.233.74.82     node4   <none>           <none>
root@vagrant:~/kub13-1/13-kubernetes-config#
root@vagrant:~/kub13-1/13-kubernetes-config# kubectl get services -n production -o wide
NAME       TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE     SELECTOR
backend    NodePort   10.233.5.194    <none>        9000:30449/TCP   2m47s   apps=backend
db         NodePort   10.233.9.60     <none>        5432:30634/TCP   2m46s   dbs=db
frontend   NodePort   10.233.26.160   <none>        8000:32069/TCP   2m47s   apps=frontend
```
Всё запустилось.  
