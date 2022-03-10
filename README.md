1.  

 - включить профайлинг командой в монгошеле:  db.setProfilingLevel()  
 - найти в system.profile нужный процесс, например, который выполняется дольше определённого времени:  db.system.profile.find( { millis : { $gt : 1000 } } ).pretty()  
 - или вместо первых двух, найти ID запроса через db.currentOp()  
 - убить процесс: db.killOp(<opid of the query to kill>)  

Для решения проблемы с зависающими запросами можно навешать параметр maxTimeMS(), что ограничит время выполнения запроса.  

2.  
Возможно, в базе данных используется много ключей, срок действия которых истекает в одну и ту же секунду, тем самым создавая Latency (Latency generated by expires)  

3.  
Происходить скорее всего начало из-за увеличения времени выполнения запросов, так как БД выросла.  
Можно подкрутить параметры "таймингов":  net_read_timeout и connect_timeout  

4.  
СУБД выедает всю ОЗУ, я бы попробовал сперва ограничить в конфиге потребление памяти, если будут продолжаться проблемы с СУБД, то добавить оперативной памяти.  

Уменьшение потребления  памяти в конфиге postgresql.conf параметрами:  
Уменьшить shared_buffers  
Уменьшить work_mem  
Уменьшить max_connections  

Можно попробовать задать лимиты для демона со стороны systemd:
в юните описывающим сервис, добавить параметр: MemoryLimit

