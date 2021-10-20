1.  
```cd``` - судя по всему, внутренняя команда оболочки (shell-а) в моём случае bash,  
 так как в системе нет программы/файла с именем cd, если бы был - то cd была бы отдельной программой.  

2.  
```grep -c <some_string> <some_file>``` (выведет количество строк)  

3.  
```systemd```

4.  
```ls 2>/dev/pts/X ``` X - нужная сессия, в которую перенаправляем вывод ошибок  

5.  
можно, например: ```cat < file1 1>file2```

6.  
Получится, но наблюдать в графическом режиме выводимые данные - нет  
нужно переключиться на tty для наблюдения.  

7.  
```
vagrant@vagrant:~$
vagrant@vagrant:~$ bash 5>&1
vagrant@vagrant:~$
vagrant@vagrant:~$ echo netology > /proc/$$/fd/5
netology
vagrant@vagrant:~$
```
сперва мы запустили bash и перенаправили 5й дескриптор на стандартный вывод (stdout)  
после отправили "netology" в 5й дескриптор файла текущего процесса, и увидели отображение на экране, так как до этого сделали перенаправление.  

8.  
Получится, например так:
```
vagrant@vagrant:~$
vagrant@vagrant:~$ ls -la /home/vagrantkjhk/ 6>&2 2>&1 1>&6  | grep 'cannot'
ls: cannot access '/home/vagrantkjhk/': No such file or directory
vagrant@vagrant:~$
```
Что бы поменять потоки местами:  
сперва временный/промежуточный дескриптор отправляем в stderr,  
потом stderr отправляем в stdout  
затем stdout во временный  

9.  
выведет переменные окружения текущего процесса, так же можно получить командой ```env```  

10.  
```
 /proc/[pid]/cmdline
              This read-only file holds the complete command line for the process, unless the process is a zombie.  In the latter case, there is nothing in this file: that is, a read on this file will return 0 characters.  The command-line  argu‐
              ments appear in this file as a set of strings separated by null bytes ('\0'), with a further null byte after the last string.
```
Хранит командную строку, которая использовалась для запуска процесса.  


```
 /proc/[pid]/exe
              Under Linux 2.2 and later, this file is a symbolic link containing the actual pathname of the executed command.  This symbolic link can be dereferenced normally; attempting to open it will open the executable.   You  can  even  type
              /proc/[pid]/exe to run another copy of the same executable that is being run by process [pid].  If the pathname has been unlinked, the symbolic link will contain the string '(deleted)' appended to the original pathname.  In a multi‐
              threaded process, the contents of this symbolic link are not available if the main thread has already terminated (typically by calling pthread_exit(3)).

              Permission to dereference or read (readlink(2)) this symbolic link is governed by a ptrace access mode PTRACE_MODE_READ_FSCREDS check; see ptrace(2).

              Under Linux 2.0 and earlier, /proc/[pid]/exe is a pointer to the binary which was executed, and appears as a symbolic link.  A readlink(2) call on this file under Linux 2.0 returns a string in the format:

                  [device]:inode

              For example, [0301]:1502 would be inode 1502 on device major 03 (IDE, MFM, etc. drives) minor 01 (first partition on the first drive).

              find(1) with the -inum option can be used to locate the file.
```
Символическая ссылка содержащая путь к выполняемой команде.  

11.  
```
vagrant@vagrant:~$ cat /proc/cpuinfo | grep -i SSE
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti fsgsbase avx2 invpcid rdseed clflushopt md_clear flush_l1d
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti fsgsbase avx2 invpcid rdseed clflushopt md_clear flush_l1d
vagrant@vagrant:~$
```
SSE4_2

12.  
В man ssh написано:  If a command is specified, it is executed on the remote host instead of a login shell  
То есть при выполнении команды через ssh, она выполняется на удалённом хосте, но шелл не запускается, следовательно и нет tty.  

13.
Сделал, доустановил пакет reptyr  
При первой попытке перехватить PID из сеанса в screen ошибка вышла:  
```
vagrant@vagrant:~$ reptyr 1733
Unable to attach to pid 1733: Operation not permitted
The kernel denied permission while attaching. If your uid matches
the target's, check the value of /proc/sys/kernel/yama/ptrace_scope.
For more information, see /etc/sysctl.d/10-ptrace.conf
```
Из конфига понятно, что можно поменять значение параметра kernel.yama.ptrace_scope на 0  
После смены значения на 0  (повысился до рута и отправил 0 в /proc/sys/kernel/yama/ptrace_scope )  ```echo 0 > /proc/sys/kernel/yama/ptrace_scope```  
удалось перехватить процесс.  

14.  
Из мана:
```
NAME
       tee - read from standard input and write to standard output and files
```
читает стандартный ввод и пишет в стандартный вывод.
``` echo string | sudo tee /root/new_file ``` будет работать, так как сама команда tee запущена через sudo и будет иметь права на запись в /root/new_file,  
в отличие от ``` sudo echo string > /root/new_file```, где перенаправление запускается в шеле, который запущен без sudo.







