1.  

Список баз:  
```
tstuser=# \l
                               List of databases
   Name    |  Owner  | Encoding |  Collate   |   Ctype    |  Access privileges
-----------+---------+----------+------------+------------+---------------------
 postgres  | tstuser | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | tstuser | UTF8     | en_US.utf8 | en_US.utf8 | =c/tstuser         +
           |         |          |            |            | tstuser=CTc/tstuser
 template1 | tstuser | UTF8     | en_US.utf8 | en_US.utf8 | =c/tstuser         +
           |         |          |            |            | tstuser=CTc/tstuser
 tstuser   | tstuser | UTF8     | en_US.utf8 | en_US.utf8 |
(4 rows)

tstuser=#
```

Подключение к БД:  
```
tstuser=# \c postgres
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1), server 13.6 (Debian 13.6-1.pgdg110+1))
WARNING: psql major version 12, server major version 13.
         Some psql features might not work.
You are now connected to database "postgres" as user "tstuser".
postgres=#
```

Вывод списка таблиц:  
```
postgres=# \dS+
                                     List of relations
   Schema   |              Name               | Type  |  Owner  |    Size    | Description
------------+---------------------------------+-------+---------+------------+-------------
 pg_catalog | pg_aggregate                    | table | tstuser | 56 kB      |
 pg_catalog | pg_am                           | table | tstuser | 40 kB      |
 pg_catalog | pg_amop                         | table | tstuser | 80 kB      |
 pg_catalog | pg_amproc                       | table | tstuser | 64 kB      |
 pg_catalog | pg_attrdef                      | table | tstuser | 8192 bytes |
 pg_catalog | pg_attribute                    | table | tstuser | 456 kB     |
 pg_catalog | pg_auth_members                 | table | tstuser | 40 kB      |
 pg_catalog | pg_authid                       | table | tstuser | 48 kB      |
 pg_catalog | pg_available_extension_versions | view  | tstuser | 0 bytes    |
 pg_catalog | pg_available_extensions         | view  | tstuser | 0 bytes    |
 pg_catalog | pg_cast                         | table | tstuser | 48 kB      |
```

Вывод описания таблицы:  
```
postgres=# \dS+ pg_aggregate
                                   Table "pg_catalog.pg_aggregate"
      Column      |   Type   | Collation | Nullable | Default | Storage  | Stats target | Description
------------------+----------+-----------+----------+---------+----------+--------------+-------------
 aggfnoid         | regproc  |           | not null |         | plain    |              |
 aggkind          | "char"   |           | not null |         | plain    |              |
 aggnumdirectargs | smallint |           | not null |         | plain    |              |
 aggtransfn       | regproc  |           | not null |         | plain    |              |
 aggfinalfn       | regproc  |           | not null |         | plain    |              |
 aggcombinefn     | regproc  |           | not null |         | plain    |              |
 aggserialfn      | regproc  |           | not null |         | plain    |              |
 aggdeserialfn    | regproc  |           | not null |         | plain    |              |
 aggmtransfn      | regproc  |           | not null |         | plain    |              |
 aggminvtransfn   | regproc  |           | not null |         | plain    |              |
 aggmfinalfn      | regproc  |           | not null |         | plain    |              |
 aggfinalextra    | boolean  |           | not null |         | plain    |              |
 aggmfinalextra   | boolean  |           | not null |         | plain    |              |
 aggfinalmodify   | "char"   |           | not null |         | plain    |              |
 aggmfinalmodify  | "char"   |           | not null |         | plain    |              |
 aggsortop        | oid      |           | not null |         | plain    |              |
 aggtranstype     | oid      |           | not null |         | plain    |              |
 aggtransspace    | integer  |           | not null |         | plain    |              |
 aggmtranstype    | oid      |           | not null |         | plain    |              |
 aggmtransspace   | integer  |           | not null |         | plain    |              |
 agginitval       | text     | C         |          |         | extended |              |
 aggminitval      | text     | C         |          |         | extended |              |
Indexes:
    "pg_aggregate_fnoid_index" UNIQUE, btree (aggfnoid)
Access method: heap

postgres=#
```

Выход из psql:  
```
postgres=# \q
```


2.  

Используя таблицу pg_stats, найдите столбец таблицы orders с наибольшим средним значением размера элементов в байтах:  
```
test_database=#
test_database=# SELECT attname FROM pg_stats WHERE tablename='orders' AND avg_width = ( SELECT  MAX(avg_width) FROM pg_stats WHERE tablename='orders');
 attname
---------
 title
(1 row)

test_database=#
```

3.  

```
CREATE TABLE orders_1 (
    id          integer NOT NULL,
    title       varchar(80) NOT NULL,
    price       integer
);
CREATE TABLE orders_2 (
    id          integer NOT NULL,
    title       varchar(80) NOT NULL,
    price       integer
);
INSERT INTO orders_1 (id,title,price) SELECT id,title,price FROM orders WHERE price > 499;
INSERT INTO orders_2 (id,title,price) SELECT id,title,price FROM orders WHERE price <= 499;
```

"Ручное" разделение можно было бы избежать применив вертикальное шадрирование изначально, например через наследование таблиц с указанием ограничений и создания правил:  
```
CREATE TABLE orders_1 ( CHECK ( price > 499 ) ) INHERITS (orders);
CREATE TABLE orders_2 ( CHECK ( price <= 499 ) ) INHERITS (orders);

CREATE RULE ins_to_order1 AS ON INSERT TO orders WHERE ( price > 499 ) DO INSTEAD INSERT INTO orders_1 VALUES (NEW.*);
CREATE RULE ins_to_order2 AS ON INSERT TO orders WHERE ( price <= 499 ) DO INSTEAD INSERT INTO orders_2 VALUES (NEW.*);
```

4.  
Можно внутри файла дампа в секциях CREATE TABLE добавить ограничения на уникальность, например:  
```
CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0

    CONSTRAINT titleuniq UNIQUE (title)
);

```

