1.  

Ссылка на докерхаб:   (https://hub.docker.com/r/dan054n3/nginxdan)  

Создали докер файл, и директорию myhtml в которую поместили индексную страничку:  
```
root@vagrant:~/dicker/netology/nginxdan# cat dockerfile
FROM nginx
COPY myhtml /usr/share/nginx/html
root@vagrant:~/dicker/netology/nginxdan#
```

На основе докерфайла собрали образ:  
```
root@vagrant:~/dicker/netology/nginxdan# docker build -t dan054n3/nginxdan .
Sending build context to Docker daemon  3.584kB
Step 1/2 : FROM nginx
 ---> 605c77e624dd
Step 2/2 : COPY myhtml /usr/share/nginx/html
 ---> Using cache
 ---> 69a1a103493d
Successfully built 69a1a103493d
Successfully tagged dan054n3/nginxdan:latest
root@vagrant:~/dicker/netology/nginxdan#
```

Залили образ на докерхаб:  
```
root@vagrant:~/dicker/netology/nginxdan# docker push dan054n3/nginxdan
Using default tag: latest
The push refers to repository [docker.io/dan054n3/nginxdan]
2ff4f2bfa55a: Pushed
d874fd2bc83b: Pushed
32ce5f6a5106: Pushed
f1db227348d0: Pushed
b8d6e692a25e: Pushed
e379e8aedd4d: Pushed
2edcec3590a4: Pushed

latest: digest: sha256:1d0f36b4bd410aa2ca0354a0a4533fd27f4732986f74e2698dab84180eccf884 size: 1777
root@vagrant:~/dicker/netology/nginxdan#
```

Пример запуска и работы контейнера:  
```
root@vagrant:~/dicker/netology/nginxdan# docker run --name nginxdan-container1 -d -p 8080:80 dan054n3/nginxdan
9d9c9c3e1b42e21abfef15a11703ec66c957bd0219cb81fb60160f3662fa6716
root@vagrant:~/dicker/netology/nginxdan#
root@vagrant:~/dicker/netology/nginxdan#
root@vagrant:~/dicker/netology/nginxdan# curl localhost:8080
<html>
 <head>
  Hey, Netology
 </head>
 <body>
  <h1>I’m DevOps Engineer!</h1>
 </body>
</html>
root@vagrant:~/dicker/netology/nginxdan#
root@vagrant:~/dicker/netology/nginxdan#
root@vagrant:~/dicker/netology/nginxdan# docker ps
CONTAINER ID   IMAGE               COMMAND                  CREATED          STATUS          PORTS                                   NAMES
9d9c9c3e1b42   dan054n3/nginxdan   "/docker-entrypoint.…"   40 seconds ago   Up 36 seconds   0.0.0.0:8080->80/tcp, :::8080->80/tcp   nginxdan-container1
root@vagrant:~/dicker/netology/nginxdan#
```


2.  
Собственно (судя по уже готовым образам на docker hub и информации в Интернет по контейнеризации приложений), для всех сценариев хорошо подойдёт docker контейнеризация, кроме:  
 - Мобильное приложение c версиями для Android и iOS  (в этом случае не совсем представляю что имеется ввиду под приложением для контейнеризации,  
 если это какой-то веб сервер со своим api для мобильного приложения, то вполне и контейнеризация пойдёт, если само мобильное приложение - то что-то отдельное, что умеет виртуализировать Android и iOS)  
 - Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry. (тут лучше отдельный виртуальный сервер или железный, так как он и будет хранить нужные образы, скрипты  и прочее для запуска/сборки контейнеров/приложений)  

3.  

Пробуем:  
```
/root/docker/netology
root@vagrant:~/docker/netology# docker run -v /root/docker/netology/data:/data -t -d centos
fae77698aba2406e040028f05515b221ac3b60d613caa3835f8a2758fccc575e
root@vagrant:~/docker/netology#
root@vagrant:~/docker/netology#
root@vagrant:~/docker/netology# docker run -v /root/docker/netology/data:/data -t -d debian
86cae10b32c54c8479025f9ce067158c428cafd88f45db4bf5c2ee120a23c29b
root@vagrant:~/docker/netology#
root@vagrant:~/docker/netology# docker ps
CONTAINER ID   IMAGE               COMMAND                  CREATED             STATUS             PORTS                                   NAMES
86cae10b32c5   debian              "bash"                   22 seconds ago      Up 19 seconds                                              vibrant_booth
fae77698aba2   centos              "/bin/bash"              31 seconds ago      Up 29 seconds                                              jolly_burnell
9d9c9c3e1b42   dan054n3/nginxdan   "/docker-entrypoint.…"   About an hour ago   Up About an hour   0.0.0.0:8080->80/tcp, :::8080->80/tcp   nginxdan-container1
root@vagrant:~/docker/netology#
root@vagrant:~/docker/netology# docker exec jolly_burnell touch /data/file_exec_centos
root@vagrant:~/docker/netology#
root@vagrant:~/docker/netology# touch data/file_in_host
root@vagrant:~/docker/netology#
root@vagrant:~/docker/netology#  docker exec vibrant_booth ls -la /data
total 8
drwxr-xr-x 2 root root 4096 Jan 25 12:05 .
drwxr-xr-x 1 root root 4096 Jan 25 12:03 ..
-rw-r--r-- 1 root root    0 Jan 25 12:04 file_exec_centos
-rw-r--r-- 1 root root    0 Jan 25 12:05 file_in_host
root@vagrant:~/docker/netology#
```


