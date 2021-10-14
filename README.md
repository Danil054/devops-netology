1.  
установлено  
 
2. 
установлено  
 
3.  
putty  

4. 
запущена ВМ  

5. 
2 CPU, 1Gb RAM, 64GB HDD (thin)  
 
6. 
Изменить/добавить в Vagrantfile:
```
  config.vm.provider "virtualbox" do |v|
  v.memory = 1024
  v.cpus = 2
end 
```
7.  

