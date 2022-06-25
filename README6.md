1. Опишите основные плюсы и минусы pull и push систем мониторинга.  
PUSH системы менее требовательны к сети, так как отправка по UDP, что позволит с большей производительностью получать метрики  
PUSH системы более гибки в плане настройки и отправки метрик, настройки для отправки в несколько серверов  
Но и недостатки есть, нет гарантии доставки метрик в сервер мониторинга  
PULL модель более контролируемая, имеется гарантия доставки метрик  
PULL системы использует конкретные опрашиваемые "точки", что не позволит влить "левые" данные в систему  
Из недостатков - более требовательны к качеству канала связи  

2.  
PUSH системы:  
TICK  
VictoriaMetrics  
  
PULL системы:  
Prometheus  
Nagios  

Гибридные системы:  
Zabbix  
  
  
3.  
```
root@vagrant:~/gitrepo/TICK/sandbox#
root@vagrant:~/gitrepo/TICK/sandbox# curl http://localhost:8086/ping
root@vagrant:~/gitrepo/TICK/sandbox#
root@vagrant:~/gitrepo/TICK/sandbox# curl http://localhost:8086/ping -v
*   Trying ::1:8086...
* TCP_NODELAY set
* Connected to localhost (::1) port 8086 (#0)
> GET /ping HTTP/1.1
> Host: localhost:8086
> User-Agent: curl/7.68.0
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 204 No Content
< Content-Type: application/json
< Request-Id: 387c7f74-f4b5-11ec-814f-0242ac140002
< X-Influxdb-Build: OSS
< X-Influxdb-Version: 1.8.10
< X-Request-Id: 387c7f74-f4b5-11ec-814f-0242ac140002
< Date: Sat, 25 Jun 2022 18:32:51 GMT
<
* Connection #0 to host localhost left intact
root@vagrant:~/gitrepo/TICK/sandbox#
```

```
root@vagrant:~/gitrepo/TICK/sandbox# curl http://localhost:8888
<!DOCTYPE html><html><head><meta http-equiv="Content-type" content="text/html; charset=utf-8"><title>Chronograf</title><link rel="icon shortcut" href="/favicon.fa749080.ico"><link rel="stylesheet" href="/src.9cea3e4e.css"></head><body> <div id="react-root" data-basepath=""></div> <script src="/src.a969287c.js"></script> </body></html>
```

```
root@vagrant:~/gitrepo/TICK/sandbox#
root@vagrant:~/gitrepo/TICK/sandbox# curl http://localhost:9092/kapacitor/v1/ping
root@vagrant:~/gitrepo/TICK/sandbox#
root@vagrant:~/gitrepo/TICK/sandbox# curl http://localhost:9092/kapacitor/v1/ping -v
*   Trying ::1:9092...
* TCP_NODELAY set
* Connected to localhost (::1) port 9092 (#0)
> GET /kapacitor/v1/ping HTTP/1.1
> Host: localhost:9092
> User-Agent: curl/7.68.0
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 204 No Content
< Content-Type: application/json; charset=utf-8
< Request-Id: 91dc1e30-f4b5-11ec-8149-000000000000
< X-Kapacitor-Version: 1.6.4
< Date: Sat, 25 Jun 2022 18:35:21 GMT
<
* Connection #0 to host localhost left intact
root@vagrant:~/gitrepo/TICK/sandbox#
```
  
chronograf: (https://github.com/Danil054/devops-netology/blob/main/pics/screen-tick.png)  

4.  
Скриншот с отображением метрик утилизации места на диске:  
(https://github.com/Danil054/devops-netology/blob/main/pics/screen-tick-disk.png)  
  
5.  
Docker plugin:  
(https://github.com/Danil054/devops-netology/blob/main/pics/screen-tick-docker.png)  

