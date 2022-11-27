## Задача 1: Рассмотрите пример 14.5/example-security-context.yml

Применим к кластеру файл [example-security-context.yml](https://github.com/Danil054/devops-netology/blob/main/kub/14-5/example-security-context.yml)

```
vagrant@vagrant:~/kub14-5$ kubectl apply -f example-security-context.yml 
pod/security-context-demo created
vagrant@vagrant:~/kub14-5$ 
```

Посмотрим поды в default нэймспэйсе:
```
vagrant@vagrant:~/kub14-5$ kubectl get pods -n default
NAME                    READY   STATUS      RESTARTS      AGE
security-context-demo   0/1     Completed   4 (48s ago)   116s
vagrant@vagrant:~/kub14-5$ 
```

Проверяем установленные настройки внутри контейнера:
```
vagrant@vagrant:~/kub14-5$ kubectl logs security-context-demo
uid=1000 gid=3000 groups=3000
vagrant@vagrant:~/kub14-5$ 
```
