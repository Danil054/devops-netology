## Задание 1: Подготовить инвентарь kubespray  

Предварительно создал пять виртуальных машин, через vagrant, и распространил на них pubkey для подключения по ssh.  
 [Vagrantfile](https://github.com/Danil054/devops-netology/blob/main/vagrantfiles/Vagrantfile)

IP адреса:  
```
192.168.31.201
192.168.31.202
192.168.31.203
192.168.31.204
192.168.31.205
```

Склонировал репозиторий kubespray, и перешёл в директорию kubespray:  
```
git clone https://github.com/kubernetes-sigs/kubespray
cd kubespray
```

Установил необходимые пакеты командой:  
```
pip3 install -r requirements.txt
```

Подготовил инвентори командами:  
```
cp -rfp inventory/sample inventory/mycluster
declare -a IPS=(192.168.31.201 192.168.31.202 192.168.31.203 192.168.31.204 192.168.31.205)
export CONFIG_FILE=inventory/mycluster/hosts.yaml
python3 contrib/inventory_builder/inventory.py ${IPS[@]}
```

Привёл файл hosts.yaml к такому виду:  
```
root@vagrant:~/gitrepo/devops-netology# cat /root/gitrepo/kubernetes/kubespray/inventory/mycluster/hosts.yaml
all:
  hosts:
    cp1:
      ansible_host: 192.168.31.201
      ip: 192.168.31.201
      access_ip: 192.168.31.201
      ansible_user: vagrant
    node1:
      ansible_host: 192.168.31.202
      ip: 192.168.31.202
      access_ip: 192.168.31.202
      ansible_user: vagrant
    node2:
      ansible_host: 192.168.31.203
      ip: 192.168.31.203
      access_ip: 192.168.31.203
      ansible_user: vagrant
    node3:
      ansible_host: 192.168.31.204
      ip: 192.168.31.204
      access_ip: 192.168.31.204
      ansible_user: vagrant
    node4:
      ansible_host: 192.168.31.205
      ip: 192.168.31.205
      access_ip: 192.168.31.205
      ansible_user: vagrant
  children:
    kube_control_plane:
      hosts:
        cp1:
    kube_node:
      hosts:
        node1:
        node2:
        node3:
        node4:
    etcd:
      hosts:
        cp1:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
```

Запустил установку кластера командой:  
```
ansible-playbook -i inventory/mycluster/hosts.yaml cluster.yml -b -v
```

После установки проверяем кластер, видно что запущена нода с control plane и четыре worker ноды:  
```
root@cp1:~# kubectl get nodes
NAME    STATUS   ROLES           AGE    VERSION
cp1     Ready    control-plane   142m   v1.24.4
node1   Ready    <none>          138m   v1.24.4
node2   Ready    <none>          138m   v1.24.4
node3   Ready    <none>          138m   v1.24.4
node4   Ready    <none>          139m   v1.24.4
```


