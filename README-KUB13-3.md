## Задание 1: проверить работоспособность каждого компонента  

Подготовили yaml файл для запуска в production окружении: [deployprod.yaml](https://github.com/Danil054/devops-netology/blob/main/kub/13-3/deployprod.yaml)  
Применяем его:  
```
root@vagrant:~/kub13-3# kubectl apply -f deployprod.yaml
persistentvolumeclaim/pvc created
deployment.apps/frontend created
deployment.apps/backend created
service/frontend created
service/backend created
statefulset.apps/db created
service/db created
root@vagrant:~/kub13-3#

```

Проверяем запущенные поды в production нэймспэйсе:  
```
root@vagrant:~/kub13-3# kubectl -n production get pods -o wide
NAME                        READY   STATUS    RESTARTS   AGE   IP             NODE    NOMINATED NODE   READINESS GATES
backend-757578bdc5-r59jn    1/1     Running   0          14m   10.233.71.36   node3   <none>           <none>
db-0                        1/1     Running   0          26m   10.233.74.94   node4   <none>           <none>
frontend-564f547876-sm4dw   1/1     Running   0          13m   10.233.74.95   node4   <none>           <none>
root@vagrant:~/kub13-3#

```

Сперва проверим доступность сервисов внутри каждого пода через команду exec:  

Frontend:  
```
root@vagrant:~/kub13-3#
root@vagrant:~/kub13-3# kubectl -n production exec frontend-564f547876-sm4dw -- curl http://localhost:80
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   448  100   448    0     0   218k      0 --:--:-- --:--:-- --:--:--  218k
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
</html>
root@vagrant:~/kub13-3#
```

Backend:  
```
root@vagrant:~/kub13-3#
root@vagrant:~/kub13-3# kubectl -n production exec backend-757578bdc5-r59jn -- curl http://localhost:9000/api/news/1
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0{"id":1,"title":"title 0","short_description":"small text 0small text 0small text 0small text 0small text 0small text 0small text 0small text 0small text 0small text 0","description":"0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more te100  2016  100  2016    0     0   281k      0 --:--:-- --:--:-- --:--:--  281ksome more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, ","preview":"/static/image.png"}
root@vagrant:~/kub13-3#

```

BD:  
```
root@vagrant:~/kub13-3#
root@vagrant:~/kub13-3# kubectl -n production exec db-0 -- psql -U postgres -c "\l"
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 news      | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(4 rows)

root@vagrant:~/kub13-3#

```
Видно, что сервисы отвечают по заданным портам.  

Теперь проверим доступность через port-forward:  

Frontend:  
```
root@vagrant:~/kub13-3#
root@vagrant:~/kub13-3# kubectl -n production port-forward frontend-564f547876-sm4dw 8888:80
Forwarding from 127.0.0.1:8888 -> 80
Forwarding from [::1]:8888 -> 80
```
```
root@vagrant:~/kub13-3#
root@vagrant:~/kub13-3# curl http://localhost:8888
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
</html>
root@vagrant:~/kub13-3#

```

Backend:  
```
root@vagrant:~/kub13-3#
root@vagrant:~/kub13-3# kubectl -n production port-forward backend-757578bdc5-r59jn 9000:9000
Forwarding from 127.0.0.1:9000 -> 9000
Forwarding from [::1]:9000 -> 9000
```

```
root@vagrant:~/kub13-3#
root@vagrant:~/kub13-3# curl http://localhost:9000/api/news/1
{"id":1,"title":"title 0","short_description":"small text 0small text 0small text 0small text 0small text 0small text 0small text 0small text 0small text 0small text 0","description":"0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, 0 some more text, ","preview":"/static/image.png"}root@vagrant:~/kub13-3#
root@vagrant:~/kub13-3#
```

BD:
```
root@vagrant:~/kub13-3#
root@vagrant:~/kub13-3# kubectl -n production port-forward db-0 55432:5432
Forwarding from 127.0.0.1:55432 -> 5432
Forwarding from [::1]:55432 -> 5432
```
```
root@vagrant:~/kub13-3#
root@vagrant:~/kub13-3# psql -h localhost -p 55432 -U postgres -c "\l"
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 news      | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(4 rows)

root@vagrant:~/kub13-3#

```

Видим, что при обращении к localhost, там где был запущен portforward, происходит перенаправление запросов на соответствующие поды.  

## Задание 2: ручное масштабирование  

Увеличим количество реплик фронтенда и бэкенда до трёх:  
```
root@vagrant:~/kub13-3#
root@vagrant:~/kub13-3# kubectl -n production scale --replicas=3 deploy/backend
deployment.apps/backend scaled
root@vagrant:~/kub13-3#
root@vagrant:~/kub13-3# kubectl -n production scale --replicas=3 deploy/frontend
deployment.apps/frontend scaled
root@vagrant:~/kub13-3#
```

Проверяем запущенные поды:  
```
root@vagrant:~/kub13-3# kubectl -n production get pods -o wide
NAME                        READY   STATUS    RESTARTS   AGE    IP               NODE    NOMINATED NODE   READINESS GATES
backend-757578bdc5-7l42b    1/1     Running   0          104s   10.233.102.160   node1   <none>           <none>
backend-757578bdc5-kljwr    1/1     Running   0          104s   10.233.74.96     node4   <none>           <none>
backend-757578bdc5-r59jn    1/1     Running   0          34m    10.233.71.36     node3   <none>           <none>
db-0                        1/1     Running   0          46m    10.233.74.94     node4   <none>           <none>
frontend-564f547876-hz48f   1/1     Running   0          97s    10.233.71.37     node3   <none>           <none>
frontend-564f547876-m4nk6   1/1     Running   0          97s    10.233.102.161   node1   <none>           <none>
frontend-564f547876-sm4dw   1/1     Running   0          33m    10.233.74.95     node4   <none>           <none>
root@vagrant:~/kub13-3#
```
Видно, что успешно запустились по три пода для фронта и три для бэка.  

Возвращаем до одной реплики:  
```
root@vagrant:~/kub13-3#
root@vagrant:~/kub13-3# kubectl -n production scale --replicas=1 deploy/frontend
deployment.apps/frontend scaled
root@vagrant:~/kub13-3#
root@vagrant:~/kub13-3# kubectl -n production scale --replicas=1 deploy/backend
deployment.apps/backend scaled
root@vagrant:~/kub13-3#
root@vagrant:~/kub13-3#
root@vagrant:~/kub13-3# kubectl -n production get pods -o wide
NAME                        READY   STATUS    RESTARTS   AGE   IP             NODE    NOMINATED NODE   READINESS GATES
backend-757578bdc5-r59jn    1/1     Running   0          36m   10.233.71.36   node3   <none>           <none>
db-0                        1/1     Running   0          49m   10.233.74.94   node4   <none>           <none>
frontend-564f547876-sm4dw   1/1     Running   0          35m   10.233.74.95   node4   <none>           <none>
```

