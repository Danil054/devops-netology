1.  
Файл для docker-compose:
```
version: "3.9"
services:
  postgres:
    image: postgres:12.10
    environment:
      POSTGRES_USER: "tstuser"
      POSTGRES_PASSWORD: "tstpwd"
    volumes:
      - /pgdata:/var/lib/postgresql/data
      - /pgbackup:/var/pgbackup
    ports:
      - "5432:5432"
```

2.  

```
test_db-# cat \l+
 postgres  | tstuser | UTF8     | en_US.utf8 | en_US.utf8 |                               | 7969 kB | pg_default | default administrative connection database
 template0 | tstuser | UTF8     | en_US.utf8 | en_US.utf8 | =c/tstuser                   +| 7825 kB | pg_default | unmodifiable empty database
           |         |          |            |            | tstuser=CTc/tstuser           |         |            |
 template1 | tstuser | UTF8     | en_US.utf8 | en_US.utf8 | =c/tstuser                   +| 7825 kB | pg_default | default template for new databases
           |         |          |            |            | tstuser=CTc/tstuser           |         |            |
 test_db   | tstuser | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/tstuser                  +| 8129 kB | pg_default |
           |         |          |            |            | tstuser=CTc/tstuser          +|         |            |
           |         |          |            |            | "test-admin-user"=CTc/tstuser |         |            |

test_db-#
```

```
test_db=# \dS+ clients
                                                           Table "public.clients"
      Column       |       Type        | Collation | Nullable |               Default               | Storage  | Stats target | Description
-------------------+-------------------+-----------+----------+-------------------------------------+----------+--------------+-------------
 id                | integer           |           | not null | nextval('clients_id_seq'::regclass) | plain    |              |
 фамилия           | character varying |           |          |                                     | extended |              |
 страна проживания | character varying |           |          |                                     | extended |              |
 заказ             | integer           |           |          |                                     | plain    |              |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
Foreign-key constraints:
    "clients_fk" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap

test_db=#
test_db=#
test_db=#
test_db=# \dS+ orders
                                                        Table "public.orders"
    Column    |       Type        | Collation | Nullable |              Default               | Storage  | Stats target | Description
--------------+-------------------+-----------+----------+------------------------------------+----------+--------------+-------------
 id           | integer           |           | not null | nextval('orders_id_seq'::regclass) | plain    |              |
 наименование | character varying |           |          |                                    | extended |              |
 цена         | integer           |           |          |                                    | plain    |              |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_fk" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap

test_db=#

```

```
test_db=# SELECT grantee, table_catalog , table_name , privilege_type FROM information_schema.role_table_grants where table_name = 'clients' or table_name = 'orders';
     grantee      | table_catalog | table_name | privilege_type
------------------+---------------+------------+----------------
 tstuser          | test_db       | orders     | INSERT
 tstuser          | test_db       | orders     | SELECT
 tstuser          | test_db       | orders     | UPDATE
 tstuser          | test_db       | orders     | DELETE
 tstuser          | test_db       | orders     | TRUNCATE
 tstuser          | test_db       | orders     | REFERENCES
 tstuser          | test_db       | orders     | TRIGGER
 test-simple-user | test_db       | orders     | INSERT
 test-simple-user | test_db       | orders     | SELECT
 test-simple-user | test_db       | orders     | UPDATE
 test-simple-user | test_db       | orders     | DELETE
 test-admin-user  | test_db       | orders     | INSERT
 test-admin-user  | test_db       | orders     | SELECT
 test-admin-user  | test_db       | orders     | UPDATE
 test-admin-user  | test_db       | orders     | DELETE
 test-admin-user  | test_db       | orders     | TRUNCATE
 test-admin-user  | test_db       | orders     | REFERENCES
 test-admin-user  | test_db       | orders     | TRIGGER
 tstuser          | test_db       | clients    | INSERT
 tstuser          | test_db       | clients    | SELECT
 tstuser          | test_db       | clients    | UPDATE
 tstuser          | test_db       | clients    | DELETE
 tstuser          | test_db       | clients    | TRUNCATE
 tstuser          | test_db       | clients    | REFERENCES
 tstuser          | test_db       | clients    | TRIGGER
 test-simple-user | test_db       | clients    | INSERT
 test-simple-user | test_db       | clients    | SELECT
 test-simple-user | test_db       | clients    | UPDATE
 test-simple-user | test_db       | clients    | DELETE
 test-admin-user  | test_db       | clients    | INSERT
 test-admin-user  | test_db       | clients    | SELECT
 test-admin-user  | test_db       | clients    | UPDATE
 test-admin-user  | test_db       | clients    | DELETE
 test-admin-user  | test_db       | clients    | TRUNCATE
 test-admin-user  | test_db       | clients    | REFERENCES
 test-admin-user  | test_db       | clients    | TRIGGER
```

3.  
```
test_db=# SELECT COUNT(*) from clients;
 count
-------
     5
(1 row)

test_db=#
test_db=# SELECT COUNT(*) from orders;
 count
-------
     5
(1 row)

test_db=#
```


4.  
```
UPDATE clients SET заказ=3 WHERE id=1;
UPDATE clients SET заказ=4 WHERE id=2;
UPDATE clients SET заказ=5 WHERE id=3;
```

```
test_db=# SELECT * FROM clients WHERE заказ IS NOT null;
 id |       фамилия        | страна проживания | заказ
----+----------------------+-------------------+-------
  1 | Иванов Иван Иванович | USA               |     3
  2 | Петров Петр Петрович | Canada            |     4
  3 | Иоганн Себастьян Бах | Japan             |     5
(3 rows)

test_db=#
```

5.  

```
test_db=#
test_db=# EXPLAIN SELECT * FROM clients WHERE заказ IS NOT null;
                        QUERY PLAN
-----------------------------------------------------------
 Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72)
   Filter: ("заказ" IS NOT NULL)
(2 rows)

test_db=#
```
Видим вес/стоимость, ожидаемое число строк и их размер, да фильтр.

6.  

Смотрим какой id контейнера с постресс, заходим в него:

```
root@vagrant:/# docker ps
CONTAINER ID   IMAGE            COMMAND                  CREATED       STATUS       PORTS                                       NAMES
1240824a5541   postgres:12.10   "docker-entrypoint.s…"   3 hours ago   Up 3 hours   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   62_postgres_1
root@vagrant:/#
root@vagrant:/#
root@vagrant:/# docker exec -it 1240824a5541 bash
root@1240824a5541:/#
```

Делаем дамп:
```
root@1240824a5541:/# pg_dump -Utstuser test_db > /var/pgbackup/test_db.sql
```

Поднимаем новый инстанс постгри на другом порту, с прокинутым volume для бэкапов:
```
root@vagrant:~/docker/netology/6.2# docker run -it -v /pgbackup:/var/pg/backup -p 5433:5432 -e POSTGRES_PASSWORD=tstpwd  postgres:12.10
```

Ищем его id и заходим в него:
```
root@vagrant:/home/vagrant# docker ps
CONTAINER ID   IMAGE            COMMAND                  CREATED         STATUS         PORTS                                       NAMES
b8b825f8276d   postgres:12.10   "docker-entrypoint.s…"   4 minutes ago   Up 4 minutes   0.0.0.0:5433->5432/tcp, :::5433->5432/tcp   suspicious_moser
1240824a5541   postgres:12.10   "docker-entrypoint.s…"   4 hours ago     Up 4 hours     0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   62_postgres_1
root@vagrant:/home/vagrant#
root@vagrant:/home/vagrant# docker exec -it b8b825f8276d bash
root@b8b825f8276d:/#
root@b8b825f8276d:/#

```
Подключаемся к постре, создаём БД и вливаем в неё дамп, конектимся к БД и проверяем:

```
root@b8b825f8276d:/# psql -Upostgres
psql (12.10 (Debian 12.10-1.pgdg110+1))
Type "help" for help.

postgres=#
postgres=#
postgres=#
postgres=# CREATE DATABASE tstdb;
CREATE DATABASE
postgres=#
\q
root@b8b825f8276d:/#
root@b8b825f8276d:/#
root@b8b825f8276d:/# psql tstdb < /var/pg/backup/test_db.sql
psql: error: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: FATAL:  role "root" does not exist
root@b8b825f8276d:/# psql -Upostgres tstdb < /var/pg/backup/test_db.sql
....

postgres=# \c tstdb
tstdb=# select * from clients
tstdb-# ;
 id |       фамилия        | страна проживания | заказ
----+----------------------+-------------------+-------
  5 | Ritchie Blackmore    | Russia            |
  4 | Ронни Джеймс Дио     | Russia            |
  1 | Иванов Иван Иванович | USA               |     3
  2 | Петров Петр Петрович | Canada            |     4
  3 | Иоганн Себастьян Бах | Japan             |     5
(5 rows)

tstdb=#


```


