1.  
c=a+b (потому что не извлекаются переменные)  
d=1+2 (потому что извлекаем переменные a и b)  
e=3  (Потому что вычисляются арифметически в конструкции ``` $((   )) ```  

2.  
для завершения скрипта можно добавить выход из цикла ```break```  
для уменьшения потребления места на жёстком диске можно добавить ```sleep```  
Например:  
```
while ((1==1))
 do
  curl https://localhost:4757
  if (($? != 0))
  then
   date >> ./curl.log
   sleep 2
  else
   break
  fi
 done

```

3.  

```
#!/usr/bin/env bash

list_ip=(192.168.0.1 173.194.222.113 87.250.250.242 )
i=0

while (($i<5))
do

 for ip in ${list_ip[@]}
 do
  curl $ip:80
  if (($? != 0))
  then
   echo IP: $ip not accessed >> ip.log
   sleep 1
  else
   echo IP: $ip accessed >> ip.log
   sleep 1
  fi
 done

let "i=i+1"
done

```

4.  
```
!/usr/bin/env bash

list_ip=(192.168.0.1 173.194.222.113 87.250.250.242)
i=0

while ((1==1))
do

 for ip in ${list_ip[@]}
 do
  curl $ip:80
  if (($? != 0))
  then
   echo IP: $ip not accessed >> error.log
   break 2
  else
   echo IP: $ip accessed >> ip.log
   sleep 1
  fi
 done


done
```


