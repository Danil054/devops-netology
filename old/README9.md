## Задание 1: подготовить приложение для работы через qbec  
Подготовили файлы для развёртывания через Qbec, приложения myapp, на примере образа nginx, в разных окружениях stage и prod:
[Qbeq myapp](https://github.com/Danil054/devops-netology/blob/main/kub/13-5/myapp)  

Разворачиваем приложение в stage и prod namespaces, командой qbec apply ...:  
```
root@vagrant:~/kub13-5/myapp#
root@vagrant:~/kub13-5/myapp# qbec apply stage
setting cluster to cluster.local
setting context to kubernetes-admin@cluster.local
cluster metadata load took 75ms
1 components evaluated in 18ms

will synchronize 2 object(s)

Do you want to continue [y/n]: y
1 components evaluated in 7ms
create deployments myapp -n stage (source mynginx)
server objects load took 418ms
---
stats:
  created:
  - deployments myapp -n stage (source mynginx)
  same: 1

waiting for readiness of 1 objects
  - deployments myapp -n stage

  0s    : deployments myapp -n stage :: 0 of 1 updated replicas are available
✓ 23s   : deployments myapp -n stage :: successfully rolled out (0 remaining)

✓ 23s: rollout complete
command took 25.07s
root@vagrant:~/kub13-5/myapp#
root@vagrant:~/kub13-5/myapp#
root@vagrant:~/kub13-5/myapp# qbec apply prod
setting cluster to cluster.local
setting context to kubernetes-admin@cluster.local
cluster metadata load took 78ms
1 components evaluated in 20ms

will synchronize 2 object(s)

Do you want to continue [y/n]: y
1 components evaluated in 4ms
create deployments myapp -n prod (source mynginx)
create services myappsvc -n prod (source mynginx)
waiting for deletion list to be returned
server objects load took 641ms
---
stats:
  created:
  - deployments myapp -n prod (source mynginx)
  - services myappsvc -n prod (source mynginx)

waiting for readiness of 1 objects
  - deployments myapp -n prod

  0s    : deployments myapp -n prod :: 0 of 3 updated replicas are available
  7s    : deployments myapp -n prod :: 1 of 3 updated replicas are available
  12s   : deployments myapp -n prod :: 2 of 3 updated replicas are available
✓ 15s   : deployments myapp -n prod :: successfully rolled out (0 remaining)

✓ 15s: rollout complete
command took 17.24s
root@vagrant:~/kub13-5/myapp#
```

Проверяем запущены ли поды:  
```
root@vagrant:~/kub13-5/myapp#
root@vagrant:~/kub13-5/myapp# kubectl get pods -n stage -o wide
NAME                     READY   STATUS    RESTARTS   AGE    IP               NODE    NOMINATED NODE   READINESS GATES
myapp-5449f5fdd8-rlgq5   1/1     Running   0          113s   10.233.102.172   node1   <none>           <none>
root@vagrant:~/kub13-5/myapp#
root@vagrant:~/kub13-5/myapp#
root@vagrant:~/kub13-5/myapp# kubectl get pods -n prod -o wide
NAME                     READY   STATUS    RESTARTS   AGE   IP               NODE    NOMINATED NODE   READINESS GATES
myapp-6f7df48cbd-hrlmp   1/1     Running   0          88s   10.233.74.107    node4   <none>           <none>
myapp-6f7df48cbd-s4hxt   1/1     Running   0          88s   10.233.102.173   node1   <none>           <none>
myapp-6f7df48cbd-shp2w   1/1     Running   0          88s   10.233.75.30     node2   <none>           <none>
root@vagrant:~/kub13-5/myapp#
```

Видно, что в нэймспэйсе stage запущен один под с приложением, а в нэймспэйсе prod три.  

Проверка services и endpoint:  
```
root@vagrant:~/kub13-5/myapp#
root@vagrant:~/kub13-5/myapp# kubectl get services,ep -n prod -o wide
NAME               TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE     SELECTOR
service/myappsvc   ClusterIP   10.233.45.28   <none>        80/TCP    3m30s   app=myapp

NAME                 ENDPOINTS                                            AGE
endpoints/myappsvc   10.233.102.173:80,10.233.74.107:80,10.233.75.30:80   3m30s
root@vagrant:~/kub13-5/myapp#

```
Видно, что сервис с эндпоинтами создались.
