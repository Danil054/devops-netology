1.  

- Будем использовать неизменяемый тип инфраструктуры, что бы убрать шанс возникновения разнородности конфигурации серверов для разработки, тестирования, прода.  
- Без центрального сервера, для управления инфраструктурой планируется использовать terraform + packer + возможно ansible , как довольно хорошо развивающиеся и  имеющие большое сообщество инструменты.  
- Агентов не будет, terraform и ansible их не используют.  
- Для инициализации ресурсов будем использовать terraform + packer, для конфигурации если понадобится - ansible.  

Для нового проекта хотелось бы использовать Kubernetes как оркестратора docker контейнеров, что даст гибкое и масштабируемое решение.  
По поводу новых инструментов, я бы внедрил gitlab для системы  хранения кода, а так же для организации CI/CD процессов, проект развивается, имеет много возможностей.  

2.  
Увы, доступа нет к установки terraform:  
```
root@vagrant:/home/vagrant# curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
curl: (22) The requested URL returned error: 405
gpg: no valid OpenPGP data found.
root@vagrant:/home/vagrant#
```

```
Err:4 https://apt.releases.hashicorp.com focal InRelease
  405  Not allowed [IP: 151.101.86.49 443]
```

Имеется ли у вас какой-то централизованный VPN или proxy с доступом к данным (заблокированным) ресурсам, для обучающихся, что бы мы могли выполнять лабораторные работы?  
Бесплатные VPN не хочется использовать, а сервера за рубежом нет.  

Вообще шаги по установке на ubuntu:  

```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl  
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
```

3.  
Так же, как и 2е задание, нет доступа скачать бинарник.  
```
root@vagrant:/home/vagrant#
root@vagrant:/home/vagrant# wget https://releases.hashicorp.com/terraform/1.1.7/terraform_1.1.7_linux_amd64.zip
--2022-03-14 06:46:43--  https://releases.hashicorp.com/terraform/1.1.7/terraform_1.1.7_linux_amd64.zip
Resolving releases.hashicorp.com (releases.hashicorp.com)... 151.101.85.183, 2a04:4e42:14::439
Connecting to releases.hashicorp.com (releases.hashicorp.com)|151.101.85.183|:443... connected.
HTTP request sent, awaiting response... 405 Not allowed
2022-03-14 06:46:43 ERROR 405: Not allowed.

root@vagrant:/home/vagrant#
```

Задумка была: для использования двух версий, скачать разные версии бинарников и положить их в разные места.  






