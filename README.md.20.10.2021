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
Изменить/добавить в Vagrantfile параметры v.memory и v.cpus:
```
config.vm.provider "virtualbox" do |v|
  v.memory = 1024
  v.cpus = 2
end 
```
7.  
Подключились.  

8.  
 history-size (1674 строчка)  
 ignoreboth - значение для переменной HISTCONTROL, оно эквиваленто двум значениям ignorespace (не сохранять в истории команд, которые начинались с пробела)  и ignoredups (не сохранять повторные команды)

9.  
В составных командах, команды выполняются в текущем окружении оболочки.  
Говорится начиная со строчки 192:
```
 { list; }
              list is simply executed in the current shell environment.  list must be terminated with a newline or semicolon.  This is known as a group command.  The return status is the exit status of list.  Note that unlike the metacharacters (
              and ), { and } are reserved words and must occur where a reserved word is permitted to be recognized.  Since they do not cause a word break, they must be separated from list by whitespace or another shell metacharacter.
```

Так же фигурные скобки можно использовать как механизм генерирования строк, говорится начиная с 728 строки:
```
 Brace Expansion
       Brace expansion is a mechanism by which arbitrary strings may be generated.  This mechanism is similar to pathname expansion, but the filenames generated need not exist.  Patterns to be brace expanded take the form of an optional preamble,
       followed  by either a series of comma-separated strings or a sequence expression between a pair of braces, followed by an optional postscript.  The preamble is prefixed to each string contained within the braces, and the postscript is then
       appended to each resulting string, expanding left to right.

       Brace expansions may be nested.  The results of each expanded string are not sorted; left to right order is preserved.  For example, a{d,c,b}e expands into `ade ace abe'.

       A sequence expression takes the form {x..y[..incr]}, where x and y are either integers or single characters, and incr, an optional increment, is an integer.  When integers are supplied, the expression expands to each number between  x  and
       y,  inclusive.   Supplied integers may be prefixed with 0 to force each term to have the same width.  When either x or y begins with a zero, the shell attempts to force all generated terms to contain the same number of digits, zero-padding
       where necessary.  When characters are supplied, the expression expands to each character lexicographically between x and y, inclusive, using the default C locale.  Note that both x and y must be of the same type.   When  the  increment  is
       supplied, it is used as the difference between each term.  The default increment is 1 or -1 as appropriate.

       Brace  expansion  is performed before any other expansions, and any characters special to other expansions are preserved in the result.  It is strictly textual.  Bash does not apply any syntactic interpretation to the context of the expan‐
       sion or the text between the braces.

       A correctly-formed brace expansion must contain unquoted opening and closing braces, and at least one unquoted comma or a valid sequence expression.  Any incorrectly formed brace expansion is left unchanged.  A { or , may be quoted with  a
       backslash to prevent its being considered part of a brace expression.  To avoid conflicts with parameter expansion, the string ${ is not considered eligible for brace expansion, and inhibits brace expansion until the closing }.

       This construct is typically used as shorthand when the common prefix of the strings to be generated is longer than in the above example:

              mkdir /usr/local/src/bash/{old,new,dist,bugs}
       or
              chown root /usr/{ucb/{ex,edit},lib/{ex?.?*,how_ex}}

```

10.  
Создать 100 000 файлов можно командой:
```
touch file{1..100000}
```

300 000 файлов не даёт создать, выходит ошибка:
```
vagrant@vagrant:~/tst1$ touch file{1..300000}
-bash: /usr/bin/touch: Argument list too long
```
Похоже где-то задано максимальное количество аргументов, только вот и вопрос для чего именно и где задано :-)  
Погуглил, имеется системная переменная ARG_MAX задающая максимальный размер строки аргументов  
В нашей ВМ оно:
```
vagrant@vagrant:~$ getconf -a | grep ARG_MAX
ARG_MAX                            2097152
POSIX_ARG_MAX                     2097152
```
Видимо, строка в 300к аргументов превышает 2097152 байт

11.  
Конструкция [[ expression ]] - возвращает статус 0 или 1 в зависимости от раскрытия expression.  
[[ -d /tmp ]] - вернёт "успешное завершение команды (или 0)" если файл /tmp  существует и это каталог, в противном случае вернет неуспешное завершение.  

из мана:
```
-d file
              True if file exists and is a directory
```

12.  
Создаём директорию: 
```
vagrant@vagrant:~/tst1$ mkdir /tmp/new_path_directory/
```

Копируем туда bash:
```
cp /bin/bash /tmp/new_path_directory/
```

Копируем bash в /usr/local/bin/
```
sudo cp /bin/bash /usr/local/bin/
```

Смотрим текущее значение переменной PATH:
```
vagrant@vagrant:~/tst1$ env | grep PATH
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
vagrant@vagrant:~/tst1$
```

Меняем значение, добавив вначале путь до нашей директории:
```
vagrant@vagrant:~/tst1$ PATH=/tmp/new_path_directory:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
vagrant@vagrant:~/tst1$
```

Выводим пути для bash:
```
vagrant@vagrant:~/tst1$ type -a bash
bash is /tmp/new_path_directory/bash
bash is /usr/local/bin/bash
bash is /usr/bin/bash
bash is /bin/bash
vagrant@vagrant:~/tst1$
```

13.  
at - выполнение команд по времени  
batch -  выполнение команд, если допустимый уровень загрузки системы  

14.  
vagrant halt  - выключаем ВМ.  



