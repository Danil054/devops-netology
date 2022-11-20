1.  
Запускаем strace, для удобства поиска перенаправляем её вывод в файл:  
``` strace -f /bin/bash -c 'cd /tmp' 2>strace.log ```
После в файле strace.log видим, что для смены директории запускается вызов chdir:  
```
stat("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
chdir("/tmp")                           = 0
```

2.  

Судя по блоку из strace:  
```
stat("/root/.magic.mgc", 0x7ffdee881450) = -1 ENOENT (No such file or directory)
stat("/root/.magic", 0x7ffdee881450)    = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/magic.mgc", O_RDONLY) = -1 ENOENT (No such file or directory)
stat("/etc/magic", {st_mode=S_IFREG|0644, st_size=111, ...}) = 0
openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=111, ...}) = 0
read(3, "# Magic local data for file(1) c"..., 4096) = 111
read(3, "", 4096)                       = 0
close(3)                                = 0
openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=5811536, ...}) = 0
```

Команда file в конечном итоге использует файлы:  
```
/etc/magic
/usr/share/misc/magic.mgc
```

3.  
С помощью lsof находим процесс, который пишет в удалённый файл.  
После, по PID процесса находим файловый дескриптор в /proc/PID/fd/ , удалённого файла (командой ls -la)  
И обнуляем его ``` echo "" > /proc/PID/fd/FDESCRIPTOR ```  

4.  
Нет, они занимают только строки в таблице процессов ядра.  

5.  
```
root@vagrant:/etc# /usr/sbin/opensnoop-bpfcc
PID    COMM               FD ERR PATH
788    vminfo              4   0 /var/run/utmp
590    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
590    dbus-daemon        18   0 /usr/share/dbus-1/system-services
590    dbus-daemon        -1   2 /lib/dbus-1/system-services
590    dbus-daemon        18   0 /var/lib/snapd/dbus-1/system-services/
610    irqbalance          6   0 /proc/interrupts
610    irqbalance          6   0 /proc/stat
610    irqbalance          6   0 /proc/irq/20/smp_affinity
610    irqbalance          6   0 /proc/irq/0/smp_affinity
610    irqbalance          6   0 /proc/irq/1/smp_affinity
610    irqbalance          6   0 /proc/irq/8/smp_affinity
610    irqbalance          6   0 /proc/irq/12/smp_affinity
610    irqbalance          6   0 /proc/irq/14/smp_affinity
610    irqbalance          6   0 /proc/irq/15/smp_affinity
```
6.  
Вызов uname  
В ```  man 2 uname ``` (пришлось доустановить пакет manpages-dev ) видно:  
```
Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}
```

7.  
```;``` - последовательное выполнение команд  
```&&``` - выполнение следующей команды, только если результат первой успешен(0)  

Есть ли смысл использовать в bash &&, если применить set -e  
Из ```bash -c "help set"```  

``` 
 -e  Exit immediately if a command exits with a non-zero status
```
Видимо есть, так как при ```set -e``` произойдёт выход при неуспешности команды, а при использовании ```&&``` команда просто не выполнится.  

8.  

```
 -e  Exit immediately if a command exits with a non-zero status
 -u  Treat unset variables as an error when substituting.
 -x  Print commands and their arguments as they are executed.
 -o pipefail - the return value of a pipeline is the status of
                           the last command to exit with a non-zero status,
                           or zero if no command exited with a non-zero status
```
Для скриптов по мне так: удобство в выводе команд и аргументов и выход при неуспешности команды.  
А вот  -u и -o pipefail - в чём удобство?  


9.  
Самый часто встречающийся статус процессов: ``S`` (interruptible sleep (waiting for an event to complete))  
Дополнительные буквы к основной, это для BSD формата:  
```
For BSD formats and when the stat keyword is used, additional characters may be displayed:

               <    high-priority (not nice to other users)
               N    low-priority (nice to other users)
               L    has pages locked into memory (for real-time and custom IO)
               s    is a session leader
               l    is multi-threaded (using CLONE_THREAD, like NPTL pthreads do)
               +    is in the foreground process group
```


