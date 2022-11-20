1.  
Скачал и распаковал node_exporter в /opt/node_exporter/  
Создал в /etc/systemd/system/ файл node_exporter.service  
с содержимым:  
```
[Unit]
Description=Node_Exporter autostart

[Service]
EnvironmentFile=-/etc/default/node_exporter
ExecStart=/opt/node_exporter/node_exporter $NODE_EXPORTER_OPTS
KillMode=mixed

[Install]
WantedBy=multi-user.target
```

Почему, в документации написано, что не рекомендовано использовать ```KillMode=process```  
Но, посмотрел файлы описания для того же ssh или cron многие используют  KillMode=process  
?  

Перечитал файлы: ```systemctl daemon-reload```  
После этого запускается и останавливается node_exporter через systemctl, и стартует после перезагрузки ОС.  


2.  
Для процессора:  
```
process_cpu_seconds_total
все для:
node_cpu_seconds_total
```

Для оперативки:  
```
node_memory_Active_bytes
node_memory_Cached_bytes
node_memory_MemAvailable_bytes
node_memory_MemFree_bytes
node_memory_MemTotal_bytes
```

Для дисков:  
```
node_disk_io_now (для нужных дисков)
node_filesystem_free_bytes (по всем ФС)
```
Не совсем понял какие метрики подойдут для отоброжения скорости чтения и записи для дисков?  

Для сети:  
```
node_network_receive_errs_total
node_network_transmit_errs_total
node_network_receive_bytes_total
node_network_transmit_bytes_total
node_network_speed_bytes
node_network_receive_drop_total
node_network_transmit_drop_total
```
Так же, не совсем понял скорость как снять?  

3.  
 Собирает метрики по cpu, load average, disk, ram, swap, network, processes, idlejitter, interrupts, softirqs, softnet, entropy, uptime, ipc semaphores, ipc shared memory  

4.  
```
root@vagrant:/etc/netdata# dmesg | grep virt
[    0.002315] CPU MTRRs all blank - virtualized system.
[    0.072909] Booting paravirtualized kernel on KVM
[    2.611103] systemd[1]: Detected virtualization oracle.
```
Видимо да.  

5.  
```
root@vagrant:/etc/netdata# sysctl -a | grep fs.nr_open
fs.nr_open = 1048576
```
Означает максимальное количество открытых файловых дескрипторов.  

Не дас открыть столько ограничение в ulimit:  
```
  -n        the maximum number of open file descriptors
```
сейчас установлен в:  
```
root@vagrant:/etc/sysctl.d# ulimit -n
1024
```

6.  
Переходим в screen, там:  
```
root@vagrant:/etc/sysctl.d# unshare -f --pid --mount-proc /bin/bash
запускаем sleep 1h
```

После в "хвостовом" нэймспейсе:  
```
root@vagrant:/home/vagrant# ps aux  | grep sleep
root        2868  0.0  0.0   8076   592 pts/2    S+   07:06   0:00 sleep 1h
root        3114  0.0  0.0   8900   740 pts/3    S+   07:23   0:00 grep --color=auto sleep
root@vagrant:/home/vagrant#
root@vagrant:/home/vagrant# nsenter --target 2868 --pid --mount
root@vagrant:/# ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.4   9836  4048 pts/2    S    07:05   0:00 /bin/bash
root           9  0.0  0.0   8076   592 pts/2    S+   07:06   0:00 sleep 1h
root          10  0.0  0.4   9836  4140 pts/3    S    07:23   0:00 -bash
root          19  0.0  0.3  11492  3388 pts/3    R+   07:23   0:00 ps aux
root@vagrant:/#
```

7.  

породит процессы до kernel смерти :-)  
отработал "pids controller" :  
```
[Thu Oct 28 07:27:27 2021] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-7.scope
```
