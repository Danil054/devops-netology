## Задание 1: подготовить helm чарт для приложения  
Подготовили небольшой Helm chart: myapp, на примере образа nginx:
[myapp](https://github.com/Danil054/devops-netology/blob/main/kub/13-4/myapp)  

## Задание 2: запустить 2 версии в разных неймспейсах  

Запустим установку приложения в первом нэймспейсе (stage), для двух разных версий, командами:  
```
 helm install myapp1 myapp
 helm install myapp2 myapp -f ./myapp/values-override.yaml 

```

Запустим установку приложения в другом нэймспейсе (prod):  
```
helm install myapp-prod myapp -f ./myapp/values-override-prod.yaml
```

Проверяем, посмотрим все поды в stage:  
```
root@vagrant:~/kub13-4#
root@vagrant:~/kub13-4# kubectl get all -n stage
NAME                              READY   STATUS    RESTARTS   AGE
pod/mynginx-6777d846b-5jnwt       1/1     Running   0          4m1s
pod/mynginx-v2-7577cb54b9-p624x   1/1     Running   0          3m37s

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
service/mynginx      ClusterIP   10.233.25.0     <none>        80/TCP    4m1s
service/mynginx-v2   ClusterIP   10.233.22.115   <none>        80/TCP    3m37s

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mynginx      1/1     1            1           4m1s
deployment.apps/mynginx-v2   1/1     1            1           3m37s

NAME                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/mynginx-6777d846b       1         1         1       4m1s
replicaset.apps/mynginx-v2-7577cb54b9   1         1         1       3m37s
root@vagrant:~/kub13-4#

```

Все поды в prod:  
```
root@vagrant:~/kub13-4#
root@vagrant:~/kub13-4# kubectl get all -n prod
NAME                           READY   STATUS    RESTARTS   AGE
pod/mynginx-8499df9986-vwnmt   1/1     Running   0          3m54s

NAME              TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
service/mynginx   ClusterIP   10.233.55.14   <none>        80/TCP    3m54s

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mynginx   1/1     1            1           3m54s

NAME                                 DESIRED   CURRENT   READY   AGE
replicaset.apps/mynginx-8499df9986   1         1         1       3m54s
root@vagrant:~/kub13-4#

```

Видно, что все поды запущены.  

Проверим версии nginx:  
```
root@vagrant:~/kub13-4#
root@vagrant:~/kub13-4# curl -sI 10.233.25.0 | grep Server:
Server: nginx/1.23.1
root@vagrant:~/kub13-4#
root@vagrant:~/kub13-4# curl -sI 10.233.22.115 | grep Server:
Server: nginx/1.22.1
root@vagrant:~/kub13-4#
root@vagrant:~/kub13-4#
root@vagrant:~/kub13-4# curl -sI 10.233.55.14 | grep Server:
Server: nginx/1.22.1
root@vagrant:~/kub13-4#
```

Видно, что в неймспэйсе stage запущены приложения с двумя разными версиями: 1.23.1 и 1.22.1  
в неймспэйсе prod только одна: 1.22.1.  
