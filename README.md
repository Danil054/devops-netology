1.  
Полная аппаратная виртуализация - позволяет создавать наиболее изолирнованные виртуальн машины, со своим набором "виртуального железа",  
в которые можно инсталлировать различные ОС без изменения самого ядра ОС. Гипервизор для управления виртуалками используется как/вместо ОС.  
Паравиртуализация - позволяет создавать виртуальные машины, так же с разными ОС и ядрами. Но гипервизор ставится на ОС и использует ресурсы ОС для обеспечения виртуализации  
Виртуализация на основе ОС - позволяют создавать виртуальные машины с ОС, где ядро основано на ядре гостевой ОС, что лишает гибкости в выборе ОС для гостевой виртуальной машины.  
  
2.  
Высоконагруженная база данных, чувствительная к отказу - выбрал бы физический сервер, что бы никто "не мешался" работе СУБД, и отдать "максимальную производительность".  
Различные web-приложения - виртуализация уровня ОС либо паравиртуализация (в зависимости от типа веб приложений, если всё однотипное то на уровне ОС виртуализацию)  
Windows системы для использования бухгалтерским отделом - паравиртуализация (не слышал про виртуализацию на основе ОС для Windows)  
Системы, выполняющие высокопроизводительные расчеты на GPU - физический сервер, дабы отдать под это дело весь графический процессор, а не виртуализировать его.  
  
3.  
  
   *1. VMWare - так как требуется виртуализировать и Windows и Linux, имеет в себе механизмы балансировки нагрузкой (DRS), имеются решения для аварийного восстановления (VMware vSphere Replication, SRM)  
   *2. KVM или KVM в обёртке PROXMOX - так как разные ОС для виртуализации и требование, что open source.  
   *3. либо Xen либо ESXi от vmware (без vsphere) - довольно не плохо виртуализируют Windows.  
   *4. тут пожалуй любое, кроме Hyper-V, если нет денег то бесплатные Xen, VMWare ESXi, KVM, если денег не жалко то vsphere.  
  
4.  
Во первых недостаток в обслуживании, необходимы специалисты, разбирающиеся, и в тех и в других системах виртуализуциии.  
Во вторых, сложность в "совместимости" ВМ, например виртуальную машину из Hyper-V не поднять на Vmware, необходимо конвертировать (вдруг хост упадёт да не хватит ресурсов на других поднять из той же системы виртуализации, и придётся переносить в другую)  
В третьих сложнее организовать мониторинг и систему резервного копирования  
Я бы солянку из гипервизоров не создавал, а наоборот, если попалась такая, постепенно уходил бы в сторону одного (умеющего нормально виртуализировать и Windows и Linux).  





