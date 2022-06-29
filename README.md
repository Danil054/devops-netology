#### Задание 1 
С помощью [docker-compose файла](https://github.com/Danil054/devops-netology/blob/main/grafana/docker-compose.yml), 
запущены контейнеры  prometheus, node-exporter, grafana. 
В grafana подключен источник данных prometheus. 
[Cписок подключенных Datasource](https://github.com/Danil054/devops-netology/blob/main/pics/grf1.png) 

#### Задание 2 
Создали новый Дашборд, с четырьмя панелями: 
 - Утилизация CPU для node-exporter (в процентах) 
 - CPULA 1/5/15 
 - Free RAM 
 - Free disk space 

Соответствующие ```promql``` запросы: 
 - ```100 * (1 - avg by(instance)(irate(node_cpu_seconds_total{mode='idle'}[1m])))``` 
 - ```node_load1, node_load5, node_load15``` 
 - ```node_memory_MemFree_bytes{}``` 
 - ```node_filesystem_free_bytes{mountpoint="/"}``` 

[Скриншот дашборда](https://github.com/Danil054/devops-netology/blob/main/pics/grf3.png) 

#### Задание 3 
[Созданы правила алертинга для каждой панели](https://github.com/Danil054/devops-netology/blob/main/pics/grf2.png) 

#### Задание 4 

[Дашбоард созранён в JSON модели](https://github.com/Danil054/devops-netology/blob/main/grafana/grafana-json-model.json) 

