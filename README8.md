## Задание 1: подключить для тестового конфига общую папку  

За основу возьмём файл из прошлого задания.  
Подготовили yaml файл для запуска в stage окружении и применили его: [deploystage.yaml](https://github.com/Danil054/devops-netology/blob/main/kub/13-2/deploystage.yaml)  
Проверили запущенные поды:  
```
root@vagrant:~/kub13-2# kubectl get pods -n stage -o wide
NAME                          READY   STATUS    RESTARTS   AGE     IP             NODE    NOMINATED NODE   READINESS GATES
db-0                          1/1     Running   0          7m38s   10.233.71.21   node3   <none>           <none>
front-back-85685c97bf-fhvzp   2/2     Running   0          7m38s   10.233.74.84   node4   <none>           <none>
root@vagrant:~/kub13-2#
```

Проверяем работу общей папки, в контейнере frontend создали файл в директории /static, и увидели что он доступен из контейнера backend:  
```
root@vagrant:~/kub13-2# kubectl -n stage exec front-back-85685c97bf-fhvzp -c frontend -- sh -c " echo '1234' > /static/tstfile2"
root@vagrant:~/kub13-2#
root@vagrant:~/kub13-2# kubectl -n stage exec front-back-85685c97bf-fhvzp -c backend -- cat /static/tstfile2
1234
root@vagrant:~/kub13-2#
```

## Задание 2: подключить общую папку для прода

Установили через HELM nfs-server-provisioner  
Подготовили yaml файл для запуска в production окружении и применили его: [deployprod.yaml](https://github.com/Danil054/devops-netology/blob/main/kub/13-2/deployprod.yaml)  
Увидели запущенные поды, pv и pvc:  
```
root@vagrant:~/kub13-2# kubectl get pod,pv,pvc -n production -o wide
NAME                            READY   STATUS    RESTARTS   AGE   IP               NODE    NOMINATED NODE   READINESS GATES
pod/backend-b59ccbd-jzqp4       1/1     Running   0          20m   10.233.74.85     node4   <none>           <none>
pod/db-0                        1/1     Running   0          12s   10.233.102.154   node1   <none>           <none>
pod/frontend-66579546fc-8qz78   1/1     Running   0          20m   10.233.102.153   node1   <none>           <none>

NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM            STORAGECLASS   REASON   AGE   VOLUMEMODE
persistentvolume/pvc-2262e1d0-f81b-48c3-adc8-588216804f39   1Gi        RWX            Delete           Bound    production/pvc   nfs                     16m   Filesystem

NAME                        STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE   VOLUMEMODE
persistentvolumeclaim/pvc   Bound    pvc-2262e1d0-f81b-48c3-adc8-588216804f39   1Gi        RWX            nfs            16m   Filesystem
root@vagrant:~/kub13-2#

```

Проверим доступность общего тома из пода фронта и пода бэка:  
```
root@vagrant:~/kub13-2# kubectl -n production exec pod/frontend-66579546fc-8qz78 -- sh -c " echo 'prod1234' > /static/tstfileprod"
root@vagrant:~/kub13-2#
root@vagrant:~/kub13-2# kubectl -n production exec pod/backend-b59ccbd-jzqp4 -- cat /static/tstfileprod
prod1234
root@vagrant:~/kub13-2#
```

Удалим поды и проверим останется данный файл при пересоздании подов или нет:  
```
root@vagrant:~/kub13-2# kubectl delete pod backend-b59ccbd-jzqp4 -n production
pod "backend-b59ccbd-jzqp4" deleted
root@vagrant:~/kub13-2#
root@vagrant:~/kub13-2# kubectl delete pod frontend-66579546fc-8qz78 -n production
pod "frontend-66579546fc-8qz78" deleted
root@vagrant:~/kub13-2#
```

Смотрим новые поды:  
```
root@vagrant:~/kub13-2# kubectl get pod -n production -o wide
NAME                        READY   STATUS    RESTARTS   AGE     IP               NODE    NOMINATED NODE   READINESS GATES
backend-b59ccbd-bltdv       1/1     Running   0          3m23s   10.233.71.23     node3   <none>           <none>
db-0                        1/1     Running   0          5m58s   10.233.102.154   node1   <none>           <none>
frontend-66579546fc-xzq62   1/1     Running   0          91s     10.233.71.24     node3   <none>           <none>
root@vagrant:~/kub13-2#
```

Проверяем доступность файла:  
```
root@vagrant:~/kub13-2#
root@vagrant:~/kub13-2#  kubectl -n production exec frontend-66579546fc-xzq62 -- cat /static/tstfileprod
prod1234
root@vagrant:~/kub13-2#
root@vagrant:~/kub13-2# kubectl -n production exec backend-b59ccbd-bltdv  -- cat /static/tstfileprod
prod1234
root@vagrant:~/kub13-2#
```
Видно, что PV переподключился к новым подам.  

