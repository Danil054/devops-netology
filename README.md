## Задание 1. Яндекс.Облако  

Подготовили манифесты для Terraform [terraform files](https://github.com/Danil054/devops-netology/blob/main/15-2/terraform15-2/)  
- [main.tf](https://github.com/Danil054/devops-netology/blob/main/15-2/terraform15-2/main.tf):  
Задаём провайдера и зону доступности.  
Переменные для доступа к облаку экспортированы в окружение:  
```
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
```

- [001-rtb.tf](https://github.com/Danil054/devops-netology/blob/main/15-2/terraform15-2/001-rtb.tf):  
Задаём таблицу маршрутизации  
(В данном задании не используем)  

- [005-vpc.tf](https://github.com/Danil054/devops-netology/blob/main/15-2/terraform15-2/005-vpc.tf):  
Создаём vpc и подсети  
(В данном задании используем только public подсеть)  

- [010-vm-nat.tf](https://github.com/Danil054/devops-netology/blob/main/15-2/terraform15-2/010-vm-nat.tf):  
Создаём ВМ для NAT  
(В данном задании не используем)  

- [015-s3.tf](https://github.com/Danil054/devops-netology/blob/main/15-2/terraform15-2/015-s3.tf):  
Создаём S3 хранидище, загружаем туда картинку, вешаем ACL с правом чтения на весь интернет  

- [020-ig.tf](https://github.com/Danil054/devops-netology/blob/main/15-2/terraform15-2/020-ig.tf):  
Создаём Instance Group с 3 ВМ  

- [025-lb.tf](https://github.com/Danil054/devops-netology/blob/main/15-2/terraform15-2/025-lb.tf):  
Создаём таргет группу из 3-х ВМ, и создаём балансировщик для данной таргет группы  




В результате выполнения terraform apply,  
в Яндекс облаке создались необходимые ресурсы:  
- [инстанс группа из 3-х ВМ](https://github.com/Danil054/devops-netology/blob/main/15-2/pics/ig.png)  
- [балансировщик](https://github.com/Danil054/devops-netology/blob/main/15-2/pics/lb.png)  

Зайдя на внешний адрес балансировщика, открывается необходимая нам [страничка с картинкой из S3](https://github.com/Danil054/devops-netology/blob/main/15-2/pics/img1.png)  
Удалили ВМ (на которую перевёл балансировщик при открытии страницы) [удаление](https://github.com/Danil054/devops-netology/blob/main/15-2/pics/del.png)  
Опять зашли на внеш. адрес балансировщика, пока не успела создаться ВМ в группе, видно, что открылась страница с другого [сеовера](https://github.com/Danil054/devops-netology/blob/main/15-2/pics/afterdel.png)  
Таким образом, проверили работу балансировщика.  





