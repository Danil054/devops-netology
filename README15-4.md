## Задание 1. Яндекс.Облако  

Подгототвили  манифесты для Terraform [terraform files](https://github.com/Danil054/devops-netology/blob/main/15-4/terraform15-4/)  

- [main.tf](https://github.com/Danil054/devops-netology/blob/main/15-4/terraform15-4/main.tf):
Задаём провайдера и зону доступности.  
Переменные для доступа к облаку экспортированы в окружение:  
```
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
```

- [005-vpc.tf](https://github.com/Danil054/devops-netology/blob/main/15-4/terraform15-4/005-vpc.tf):  
Создаём vpc и подсети  

- [015-mysqlcls.tf](https://github.com/Danil054/devops-netology/blob/main/15-4/terraform15-4/015-mysqlcls.tf):  
Создаём MySQL кластер, Базу данных и пользователя  

- [020-kubsvcacc.tf](https://github.com/Danil054/devops-netology/blob/main/15-4/terraform15-4/020-kubsvcacc.tf):  
Создаём сервисный аккаунт для работы кластера кубернетес  

- [022-ssekey.tf](https://github.com/Danil054/devops-netology/blob/main/15-4/terraform15-4/022-ssekey.tf):  
Создаём ключ для шифрования  

- [025-kubcls.tf](https://github.com/Danil054/devops-netology/blob/main/15-4/terraform15-4/025-kubcls.tf):  
Создаём кластер кубернетес  

- [030-kubnodes.tf](https://github.com/Danil054/devops-netology/blob/main/15-4/terraform15-4/030-kubnodes.tf):  
Создаём группу рабочих нод для кластера  

В результате выполнения terraform apply,  
в Яндекс облаке создались необходимые ресурсы:  
- [MySQL кластер](https://github.com/Danil054/devops-netology/blob/main/15-4/pics/mysql.png)  
- [Kubernetes кластер](https://github.com/Danil054/devops-netology/blob/main/15-4/pics/kub-cls.png)  
- [Группа рабочих серверов для кластера Kubernetes](https://github.com/Danil054/devops-netology/blob/main/15-4/pics/kub-nodes.png)  

Получаем конфиг для подключения к кластеру Kubernetes:  
```
vagrant@vagrant:~/15-4$ yc managed-kubernetes cluster get-credentials kub-cls-1 --external

Context 'yc-kub-cls-1' was added as default to kubeconfig '/home/vagrant/.kube/config'.
Check connection to cluster using 'kubectl cluster-info --kubeconfig /home/vagrant/.kube/config'.

```

Проверяем запущенные рабочие узлы:  
```
vagrant@vagrant:~/15-4$ kubectl get nodes
NAME                        STATUS   ROLES    AGE   VERSION
cl1bgco19thrmasc7r4n-avyp   Ready    <none>   29m   v1.22.6
cl1bgco19thrmasc7r4n-igug   Ready    <none>   29m   v1.22.6
cl1bgco19thrmasc7r4n-udic   Ready    <none>   29m   v1.22.6
vagrant@vagrant:~/15-4$
```




