## Задание 1. Яндекс.Облако  

Подготовили манифесты для Terraform [terraform files](https://github.com/Danil054/devops-netology/blob/main/15-1/terraform15-1/)  
- [main.tf](https://github.com/Danil054/devops-netology/blob/main/15-1/terraform15-1/main.tf):  
Задаём провайдера и зону доступности.  
Переменные для доступа к облаку экспортированы в окружение:  
```
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
```

- [rtb.tf](https://github.com/Danil054/devops-netology/blob/main/15-1/terraform15-1/rtb.tf):  
Задаём таблицу маршрутизации  

- [vpc.tf](https://github.com/Danil054/devops-netology/blob/main/15-1/terraform15-1/vpc.tf):  
Создаём vpc и подсети, сопоставляем таблицу маршрутизации с подсетью private  

- [vms.tf](https://github.com/Danil054/devops-netology/blob/main/15-1/terraform15-1/vms.tf):  
Создаём ВМ, одна для NAT, и по одной в каждой подсети  

В результате выполнения terraform apply,  
в Яндекс облаке создались необходимые [подсети](https://github.com/Danil054/devops-netology/blob/main/15-1/pics/subnets-yc.png)  
и [виртуальные машины](https://github.com/Danil054/devops-netology/blob/main/15-1/pics/vms-yc.png)  

На [скриншоте](https://github.com/Danil054/devops-netology/blob/main/15-1/pics/ping-curl.png) видно,  
что ВМ из private сети имеет доступ в интернет, и выходит в него под внешним IP адресом нашей ВМ для NAT.




