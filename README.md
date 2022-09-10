## Задание 1: Описать требования к кластеру  
* База данных должна быть отказоустойчивой. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии.
* Кэш должен быть отказоустойчивый. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии.
* Фронтенд обрабатывает внешние запросы быстро, отдавая статику. Потребляет не более 50 МБ ОЗУ на каждый экземпляр, 0.2 ядра. 5 копий.
* Бекенд потребляет 600 МБ ОЗУ и по 1 ядру на копию. 10 копий.

Итого для базы, кэша, фронта и бэка необходимо: 32ГБ ОЗУ и 17 CPU  
Количество worker нод прикинем из расчёта максимума CPU, для одновременного использования 17 CPU можно взять три ноды по два сокета и четыре ядра в каждом, итого получим  24 CPU  
По ОЗУ в сумме должно быть минимум 32 GB, то есть можно взять по 12 ГБ на каждую ноду, получим 36 ГБ, как раз с запасом с учётом ещё использование ОЗУ самой worker нодой  

Нужно учесть ещё выход из строя одной ноды  
При выходе из строя одной ноды, получим 16 CPU а не 17,  
что мне кажется, не сильно страшно, так как вряд ли все экземпляры будут всегда использовать 100% процессороного времени  
По ОЗУ, при выходе из строя ноды, получим всего 24ГБ ОЗУ,  
Что бы уместить 32ГБ при выходе  одной ноды, нужно на каждую ноду добавить по 4ГБ озу, плюс по 1ГБ для работы самой worker ноды по началу,  

Получим три worker ноды по 17ГБ ОЗУ, CPU в каждой: два сокета по четыре ядра  

Для отказоустойчивости control plane ноды их поместим в кластер, для кластера рекомендуется нечётное количество нод  
получим три control plane ноды с 2ГБ ОЗУ и 2 CPU каждая  

Итого:  
Три worker ноды по 17ГБ ОЗУ, CPU в каждой: два сокета по четыре ядра  
Три control plane ноды с 2ГБ ОЗУ и 2 CPU каждая  

