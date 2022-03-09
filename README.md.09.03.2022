1.  

Dockerfile:  

```
root@vagrant:~/docker/netology/6.5# cat Dockerfile
FROM centos:7

RUN yum -y update && yum clean all
RUN yum -y install wget
RUN yum -y install  perl-Digest-SHA
RUN \
  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.0.0-linux-x86_64.tar.gz && \
  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.0.0-linux-x86_64.tar.gz.sha512

RUN \
  shasum -a 512 -c elasticsearch-8.0.0-linux-x86_64.tar.gz.sha512 && \
  tar -xzf elasticsearch-8.0.0-linux-x86_64.tar.gz && \
  cd elasticsearch-8.0.0/


ADD cfg/elasticsearch.yml /elasticsearch-8.0.0/config/elasticsearch.yml

RUN adduser --no-create-home --no-user-group --shell /bin/false elastic
RUN chown -R elastic /elasticsearch-8.0.0

RUN mkdir -p /var/lib/elastic
RUN chown -R elastic /var/lib/elastic

USER elastic
#RUN /elasticsearch-8.0.0/bin/elasticsearch-reset-password --batch --force --silent --username elastic
CMD ["/elasticsearch-8.0.0/bin/elasticsearch"]

EXPOSE 9200

root@vagrant:~/docker/netology/6.5#
```

Ссылка на образ в репозитории dockerhub:  
(https://hub.docker.com/repository/docker/dan054n3/elastic)  


Ответ elasticsearch на запрос пути / в json виде:  
```
root@vagrant:~/docker/netology/6.5#  curl -u elastic:5c0k9VqKxN7pXoxiODkt  -k https://localhost:9200
{
  "name" : "netology_test",
  "cluster_name" : "my-cls1",
  "cluster_uuid" : "3c05XNX1S1W92JgdniO1Vw",
  "version" : {
    "number" : "8.0.0",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "1b6a7ece17463df5ff54a3e1302d825889aa1161",
    "build_date" : "2022-02-03T16:47:57.507843096Z",
    "build_snapshot" : false,
    "lucene_version" : "9.0.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
root@vagrant:~/docker/netology/6.5#
```

2.  

Список индексов:  
```
root@vagrant:~/docker/netology/6.5# curl -u elastic:5c0k9VqKxN7pXoxiODkt  -k -X GET "https://localhost:9200/_cat/indices"
green  open ind-1 mBwT5GQ_QGC39yny30uEpw 1 0 0 0 225b 225b
yellow open ind-3 HObANQmOSLCmTs1QmeBLqQ 4 2 0 0 900b 900b
yellow open ind-2 NTR1CmlQSOGWbhLMEl7w4g 2 1 0 0 450b 450b
root@vagrant:~/docker/netology/6.5#
```

Состояние кластера:  
```
root@vagrant:~/docker/netology/6.5# curl -u elastic:5c0k9VqKxN7pXoxiODkt  -k -X GET "https://localhost:9200/_cluster/health?pretty"
{
  "cluster_name" : "my-cls1",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 9,
  "active_shards" : 9,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 47.368421052631575
}
root@vagrant:~/docker/netology/6.5#
```
Состояние кластера жёлтое, так как одна нода, и репликам деваться некуда.  

Удаление индексов:  
```
curl -u elastic:5c0k9VqKxN7pXoxiODkt  -k -X DELETE "https://localhost:9200/ind-1"
curl -u elastic:5c0k9VqKxN7pXoxiODkt  -k -X DELETE "https://localhost:9200/ind-2"
curl -u elastic:5c0k9VqKxN7pXoxiODkt  -k -X DELETE "https://localhost:9200/ind-3"
```

3.  

Регистрируем репозиторий для бэкапа:  
```
root@vagrant:~/docker/netology/6.5#
root@vagrant:~/docker/netology/6.5# curl -u elastic:E8fXIdqtllwZTD0=82bK  -k -X PUT "https://localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'
> {
>   "type": "fs",
>   "settings": {
>     "location": "/elasticsearch-8.0.0/snapshots"
>   }
> }
> '
{
  "acknowledged" : true
}
root@vagrant:~/docker/netology/6.5#
```

Созданный индекс test:  
```
root@vagrant:~/docker/netology/6.5# curl -u elastic:E8fXIdqtllwZTD0=82bK  -k -X GET "https://localhost:9200/_cat/indices"
green open test 7pedefduQNuSi9R4yod0og 1 0 0 0 225b 225b
root@vagrant:~/docker/netology/6.5#
```

Создаем бэкап:  
```
root@vagrant:~/docker/netology/6.5#
root@vagrant:~/docker/netology/6.5# curl -u elastic:E8fXIdqtllwZTD0=82bK -k -X PUT "https://localhost:9200/_snapshot/netology_backup/bk-01.03.2022?pretty"
{
  "accepted" : true
}
root@vagrant:~/docker/netology/6.5#
```

```
bash-4.2$ ls -la /elasticsearch-8.0.0/snapshots/
total 48
drwxr-xr-x 3 elastic users  4096 Mar  1 18:38 .
drwxr-xr-x 1 elastic root   4096 Mar  1 18:26 ..
-rw-r--r-- 1 elastic users  1098 Mar  1 18:38 index-0
-rw-r--r-- 1 elastic users     8 Mar  1 18:38 index.latest
drwxr-xr-x 5 elastic users  4096 Mar  1 18:38 indices
-rw-r--r-- 1 elastic users 17411 Mar  1 18:38 meta-ZSCWGWe5RgaSGXEOckBfOw.dat
-rw-r--r-- 1 elastic users   396 Mar  1 18:38 snap-ZSCWGWe5RgaSGXEOckBfOw.dat
bash-4.2$
```

Удалили индекс test и создали test2:  
```
root@vagrant:~/docker/netology/6.5#
root@vagrant:~/docker/netology/6.5# curl -u elastic:E8fXIdqtllwZTD0=82bK  -k -X GET "https://localhost:9200/_cat/indices"
green open test-2 9thKaF2XShyDTgOwYwIA5g 1 0 0 0 225b 225b
root@vagrant:~/docker/netology/6.5#
```

Восстанавливаем из снапшота:  
```
root@vagrant:~/docker/netology/6.5#
root@vagrant:~/docker/netology/6.5# curl -u elastic:E8fXIdqtllwZTD0=82bK -k -X POST "https://localhost:9200/_snapshot/netology_backup/bk-01.03.2022/_restore?pretty"
{
  "accepted" : true
}
root@vagrant:~/docker/netology/6.5#
```

Итого индексы:  
```
root@vagrant:~/docker/netology/6.5# curl -u elastic:E8fXIdqtllwZTD0=82bK  -k -X GET "https://localhost:9200/_cat/indices"
green open test-2 9thKaF2XShyDTgOwYwIA5g 1 0 0 0 225b 225b
green open test   8WLzjbl1RrWg-YlDl7ovWQ 1 0 0 0 225b 225b
root@vagrant:~/docker/netology/6.5#
```
Хм, восстановление не перезатёрло всё, а добавило индекс удалённый.  



