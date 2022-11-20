## Задание 1: установить в кластер CNI плагин Calico  
Установил кластер с CNI плагином Calico через kubespray, [как в прошлом задании](https://github.com/Danil054/devops-netology/blob/main/README2.md)  
Для тестирования политик развернул три тестовых деплоя:  
```
root@vagrant:~/gitrepo/kubernetes-for-beginners# kubectl create deployment dep1 --image=k8s.gcr.io/echoserver:1.4
deployment.apps/dep1 created
root@vagrant:~/gitrepo/kubernetes-for-beginners# kubectl create deployment dep2 --image=k8s.gcr.io/echoserver:1.4
deployment.apps/dep2 created
root@vagrant:~/gitrepo/kubernetes-for-beginners# kubectl create deployment dep3 --image=k8s.gcr.io/echoserver:1.4
deployment.apps/dep3 created
root@vagrant:~/gitrepo/kubernetes-for-beginners# kubectl expose deployment dep1 --type=LoadBalancer --port=8080
service/dep1 exposed
root@vagrant:~/gitrepo/kubernetes-for-beginners# kubectl expose deployment dep2 --type=LoadBalancer --port=8080
service/dep2 exposed
root@vagrant:~/gitrepo/kubernetes-for-beginners# kubectl expose deployment dep3 --type=LoadBalancer --port=8080
service/dep3 exposed

```

Проверим доступность из 1-го и 2-го пода в 3-й, без применения политики (видим, что запрос проходит)  
```
root@vagrant:~# kubectl exec dep1-7dd8c44ddd-xbjrk -- curl -s -m 1 dep3:8080
CLIENT VALUES:
client_address=10.233.75.2
command=GET
real path=/
query=nil
request_version=1.1
request_uri=http://dep3:8080/

SERVER VALUES:
server_version=nginx: 1.10.0 - lua: 10001

HEADERS RECEIVED:
accept=*/*
host=dep3:8080
user-agent=curl/7.47.0
BODY:
-no body in request

root@vagrant:~# kubectl exec dep2-7597d8b669-f92bx -- curl -s -m 1 dep3:8080
CLIENT VALUES:
client_address=10.233.71.2
command=GET
real path=/
query=nil
request_version=1.1
request_uri=http://dep3:8080/

SERVER VALUES:
server_version=nginx: 1.10.0 - lua: 10001

HEADERS RECEIVED:
accept=*/*
host=dep3:8080
user-agent=curl/7.47.0
BODY:
-no body in request

```

Ограничим доступ в 3-й под только со второго  

Для этого сперва применим политику запрета по умолчанию, создал файл с содержанием:  
```
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
spec:
  podSelector: {}
  policyTypes:
  - Ingress
```

и применил его:  
```
root@vagrant:~/gitrepo/kubernetes/tstpolicy# kubectl apply -f defdeny.yaml
networkpolicy.networking.k8s.io/default-deny-ingress created
```
Теперь видно, что в 3-й под ниоткуда нет доступа:  
```
root@vagrant:~#
root@vagrant:~# kubectl exec dep1-7dd8c44ddd-xbjrk -- curl -s -m 1 dep3:8080
command terminated with exit code 28
root@vagrant:~#
root@vagrant:~# kubectl exec dep2-7597d8b669-f92bx -- curl -s -m 1 dep3:8080
command terminated with exit code 28
root@vagrant:~#
```
Для того, что бы разрешить доступ в 3-й под только из 2-го, добавим ещё одну политику, применим файл с данным содержанием:  
```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: dep3
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: dep3
  policyTypes:
    - Ingress
  ingress:
    - from:
      - podSelector:
          matchLabels:
            app: dep2
      ports:
        - protocol: TCP
          port: 8080
```
Применяем файл:  
```
root@vagrant:~/gitrepo/kubernetes/tstpolicy# kubectl apply -f dep2todep3.yaml
networkpolicy.networking.k8s.io/dep3 created
```
Проверяем:  
```
root@vagrant:~# kubectl exec dep1-7dd8c44ddd-xbjrk -- curl -s -m 1 dep3:8080
command terminated with exit code 28
root@vagrant:~#
root@vagrant:~# kubectl exec dep2-7597d8b669-f92bx -- curl -s -m 1 dep3:8080
CLIENT VALUES:
client_address=10.233.71.2
command=GET
real path=/
query=nil
request_version=1.1
request_uri=http://dep3:8080/

SERVER VALUES:
server_version=nginx: 1.10.0 - lua: 10001

HEADERS RECEIVED:
accept=*/*
host=dep3:8080
user-agent=curl/7.47.0
BODY:
-no body in request
```
Видно, что с 1-го пода нет доступа в 3-й, а со 2-го есть доступ.

## Задание 2: изучить, что запущено
Установим calicoctl:  
```
root@vagrant:~# curl -L https://github.com/projectcalico/calico/releases/download/v3.24.1/calicoctl-linux-amd64 -o kubectl-calico
root@vagrant:~# chmod +x kubectl-calico
root@vagrant:~# mv kubectl-calico /usr/local/bin/kubectl-calico
```
проверка:
```
root@vagrant:~# kubectl calico -h
Usage:
  kubectl-calico [options] <command> [<args>...]
```

Получаем необходимую информацию:  
Список нод:  
```
root@vagrant:~# kubectl calico --allow-version-mismatch get nodes
NAME
cp1
node1
node2
node3
node4
```
IpPool:
```
root@vagrant:~# kubectl calico --allow-version-mismatch get ipPool
NAME           CIDR             SELECTOR
default-pool   10.233.64.0/18   all()
```

profile:
```
root@vagrant:~# kubectl calico --allow-version-mismatch get profile
NAME
projectcalico-default-allow
kns.default
kns.kube-node-lease
kns.kube-public
kns.kube-system
ksa.default.default
ksa.kube-node-lease.default
ksa.kube-public.default
ksa.kube-system.attachdetach-controller
ksa.kube-system.bootstrap-signer
ksa.kube-system.calico-node
ksa.kube-system.certificate-controller
ksa.kube-system.clusterrole-aggregation-controller
ksa.kube-system.coredns
ksa.kube-system.cronjob-controller
ksa.kube-system.daemon-set-controller
ksa.kube-system.default
ksa.kube-system.deployment-controller
ksa.kube-system.disruption-controller
ksa.kube-system.dns-autoscaler
ksa.kube-system.endpoint-controller
ksa.kube-system.endpointslice-controller
ksa.kube-system.endpointslicemirroring-controller
ksa.kube-system.ephemeral-volume-controller
ksa.kube-system.expand-controller
ksa.kube-system.generic-garbage-collector
ksa.kube-system.horizontal-pod-autoscaler
ksa.kube-system.job-controller
ksa.kube-system.kube-proxy
ksa.kube-system.namespace-controller
ksa.kube-system.node-controller
ksa.kube-system.nodelocaldns
ksa.kube-system.persistent-volume-binder
ksa.kube-system.pod-garbage-collector
ksa.kube-system.pv-protection-controller
ksa.kube-system.pvc-protection-controller
ksa.kube-system.replicaset-controller
ksa.kube-system.replication-controller
ksa.kube-system.resourcequota-controller
ksa.kube-system.root-ca-cert-publisher
ksa.kube-system.service-account-controller
ksa.kube-system.service-controller
ksa.kube-system.statefulset-controller
ksa.kube-system.token-cleaner
ksa.kube-system.ttl-after-finished-controller
ksa.kube-system.ttl-controller
```



