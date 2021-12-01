1.  
Плагин поставил, зарегистрировался, создал пару записей:  
(https://github.com/Danil054/devops-netology/blob/main/pics/bitwarden1.png)  

2.  
На телефон установил authenticator, в профиле настроил двухфакторную аутентификацию и активировал в приложении по qr коду, теперь при входе запрос:  
(https://github.com/Danil054/devops-netology/blob/main/pics/bitwarden2Fa.png)  
В приложении на телефоне смотрим код, вводим его в браузере и заходим  

3.  
Apache2 установлен:  
```
root@lin-tst2:/etc/apache2# dpkg -l | grep apach
ii  apache2                                2.4.51-1~deb11u1               amd64        Apache HTTP Server
ii  apache2-bin                            2.4.51-1~deb11u1               amd64        Apache HTTP Server (modules and other binary files)
ii  apache2-data                           2.4.51-1~deb11u1               all          Apache HTTP Server (common files)
ii  apache2-utils                          2.4.51-1~deb11u1               amd64        Apache HTTP Server (utility programs for web servers)
ii  libapache2-mod-php7.4                  7.4.25-1+deb11u1               amd64        server-side, HTML-embedded scripting language (Apache 2 module)
root@lin-tst2:/etc/apache2#
```
подключаем модуль ssl и перезапускаем вебсервис:  
```
root@lin-tst2:/# a2enmod ssl
Considering dependency setenvif for ssl:
Module setenvif already enabled
Considering dependency mime for ssl:
Module mime already enabled
Considering dependency socache_shmcb for ssl:
Enabling module socache_shmcb.
Enabling module ssl.
See /usr/share/doc/apache2/README.Debian.gz on how to configure SSL and create self-signed certificates.
To activate the new configuration, you need to run:
  systemctl restart apache2
root@lin-tst2:/#
root@lin-tst2:/#   systemctl restart apache2
root@lin-tst2:/#
```

Генерируем самоподписанный сертификат:  
```
root@lin-tst2:/#
root@lin-tst2:/# openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
> -keyout /etc/ssl/private/apache-selfsigned.key \
> -out /etc/ssl/certs/apache-selfsigned.crt \
> -subj "/C=RU/ST=Moscow/L=Moscow/O=Company Name/OU=Org/CN=lin-tst2.drsk.ru"
Generating a RSA private key
.......................+++++
..................+++++
writing new private key to '/etc/ssl/private/apache-selfsigned.key'
-----
root@lin-tst2:/#
```

Создаём конфигурацию для веб сервера:  
```
root@lin-tst2:/var/www/vhosts/lin-tst2.drsk.ru# cat /etc/apache2/sites-available/010-lin-tst2.drsk.ru.conf
<VirtualHost *:443>
   ServerName lin-tst2.drsk.ru
   DocumentRoot /var/www/vhosts/lin-tst2.drsk.ru
   SSLEngine on
   SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
   SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
</VirtualHost>
root@lin-tst2:/var/www/vhosts/lin-tst2.drsk.ru#
```

"Активируем" конфигурацию:  
```
root@lin-tst2:/var/www/vhosts/lin-tst2.drsk.ru#
root@lin-tst2:/var/www/vhosts/lin-tst2.drsk.ru# ln -s /etc/apache2/sites-available/010-lin-tst2.drsk.ru.conf /etc/apache2/sites-enabled/010-lin-tst2.drsk.ru.conf
root@lin-tst2:/var/www/vhosts/lin-tst2.drsk.ru#
```

Помещаем по пути DocumentRoot сайт:  
```
root@lin-tst2:/var/www/vhosts/lin-tst2.drsk.ru#
root@lin-tst2:/var/www/vhosts/lin-tst2.drsk.ru# cat /var/www/vhosts/lin-tst2.drsk.ru/index.php
<h1> Hello Netlogy</h1>
```

перечитываем апача:  
```
root@lin-tst2:/var/www/vhosts/lin-tst2.drsk.ru#
root@lin-tst2:/var/www/vhosts/lin-tst2.drsk.ru# systemctl reload apache2
root@lin-tst2:/var/www/vhosts/lin-tst2.drsk.ru#
```

Проверяем доступность сайта:  
(https://github.com/Danil054/devops-netology/blob/main/pics/sslself.png)  
Сайт открывается, но в браузере ругань на недоверие к сертификату, так как самоподписанный.  

4.  
Склониоровали гит репозитарий:  
```
root@lin-tst2:~/gitrepo/testssl# git clone --depth 1 https://github.com/drwetter/testssl.sh.git
Cloning into 'testssl.sh'...
remote: Enumerating objects: 100, done.
remote: Counting objects: 100% (100/100), done.
remote: Compressing objects: 100% (93/93), done.
remote: Total 100 (delta 14), reused 40 (delta 6), pack-reused 0
Receiving objects: 100% (100/100), 8.60 MiB | 4.82 MiB/s, done.
Resolving deltas: 100% (14/14), done.
root@lin-tst2:~/gitrepo/testssl#
```

Запустили сканирование:  
```
root@lin-tst2:~/gitrepo/testssl/testssl.sh#
root@lin-tst2:~/gitrepo/testssl/testssl.sh# ./testssl.sh -U --sneaky https://example.org

###########################################################
    testssl.sh       3.1dev from https://testssl.sh/dev/
    (f6571c7 2021-11-30 11:19:44 -- )

      This program is free software. Distribution and
             modification under GPLv2 permitted.
      USAGE w/o ANY WARRANTY. USE IT AT YOUR OWN RISK!

       Please file bugs @ https://testssl.sh/bugs/

###########################################################

 Using "OpenSSL 1.0.2-chacha (1.0.2k-dev)" [~179 ciphers]
 on lin-tst2:./bin/openssl.Linux.x86_64
 (built: "Jan 18 17:12:17 2019", platform: "linux-x86_64")


 Start 2021-12-01 13:40:27        -->> 93.184.216.34:443 (example.org) <<--

 Further IP addresses:   2606:2800:220:1:248:1893:25c8:1946
 rDNS (93.184.216.34):   --
 Service detected:       HTTP


 Testing vulnerabilities

 Heartbleed (CVE-2014-0160)                not vulnerable (OK), no heartbeat extension
 CCS (CVE-2014-0224)                       not vulnerable (OK)
 Ticketbleed (CVE-2016-9244), experiment.  not vulnerable (OK)
 ROBOT                                     not vulnerable (OK)
 Secure Renegotiation (RFC 5746)           supported (OK)
 Secure Client-Initiated Renegotiation     not vulnerable (OK)
 CRIME, TLS (CVE-2012-4929)                not vulnerable (OK)
 BREACH (CVE-2013-3587)                    potentially NOT ok, "gzip deflate" HTTP compression detected. - only supplied "/" tested
                                           Can be ignored for static pages or if no secrets in the page
 POODLE, SSL (CVE-2014-3566)               not vulnerable (OK)
 TLS_FALLBACK_SCSV (RFC 7507)              Downgrade attack prevention supported (OK)
 SWEET32 (CVE-2016-2183, CVE-2016-6329)    not vulnerable (OK)
 FREAK (CVE-2015-0204)                     not vulnerable (OK)
 DROWN (CVE-2016-0800, CVE-2016-0703)      not vulnerable on this host and port (OK)
                                           make sure you don't use this certificate elsewhere with SSLv2 enabled services
                                           https://censys.io/ipv4?q=200DCAFA767C8450ECE644879C062A0CDF52240FE05BB7EB284611C3AEF3EC2E could help you to find out
 LOGJAM (CVE-2015-4000), experimental      not vulnerable (OK): no DH EXPORT ciphers, no common prime detected
 BEAST (CVE-2011-3389)                     TLS1: ECDHE-RSA-AES128-SHA ECDHE-RSA-AES256-SHA DHE-RSA-AES128-SHA DHE-RSA-AES256-SHA DHE-RSA-CAMELLIA256-SHA DHE-RSA-CAMELLIA128-SHA AES256-SHA
                                                 CAMELLIA256-SHA AES128-SHA CAMELLIA128-SHA DHE-RSA-SEED-SHA SEED-SHA
                                           VULNERABLE -- but also supports higher protocols  TLSv1.1 TLSv1.2 (likely mitigated)
 LUCKY13 (CVE-2013-0169), experimental     potentially VULNERABLE, uses cipher block chaining (CBC) ciphers with TLS. Check patches
 Winshock (CVE-2014-6321), experimental    not vulnerable (OK)
 RC4 (CVE-2013-2566, CVE-2015-2808)        no RC4 ciphers detected (OK)


 Done 2021-12-01 13:42:18 [ 115s] -->> 93.184.216.34:443 (example.org) <<--


root@lin-tst2:~/gitrepo/testssl/testssl.sh#
```

5.  
SSH сервер установлен:  
```
vagrant@vagrant:~$
vagrant@vagrant:~$ dpkg -l | grep openssh
ii  openssh-client                       1:8.2p1-4ubuntu0.2                amd64        secure shell (SSH) client, for secure access to remote machines
ii  openssh-server                       1:8.2p1-4ubuntu0.2                amd64        secure shell (SSH) server, for secure access from remote machines
ii  openssh-sftp-server                  1:8.2p1-4ubuntu0.2                amd64        secure shell (SSH) sftp server module, for SFTP access from remote machines
vagrant@vagrant:~$
```

Генерируем ключи:  
```
vagrant@vagrant:~$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/vagrant/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/vagrant/.ssh/id_rsa
Your public key has been saved in /home/vagrant/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:iztWHBXrmEoeknRmWxAInGVWV8mz5oBLGn9z1T+EgM0 vagrant@vagrant
The key's randomart image is:
+---[RSA 3072]----+
| ..++o+..o*o     |
|  oo.  o .=E     |
|    . +....o...  |
|   ..=ooo+o .... |
|    o=+oS=..  .. |
|    .+o+=.o    ..|
|      +o.o      .|
|      o.         |
|     ...         |
+----[SHA256]-----+
vagrant@vagrant:~$
```

Копируем публичный ключ на другой сервер, к которому хотим подключаться по ssh:  
```
vagrant@vagrant:~$
vagrant@vagrant:~$ ssh-copy-id root@10.74.9.29
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/vagrant/.ssh/id_rsa.pub"
The authenticity of host '10.74.9.29 (10.74.9.29)' can't be established.
ECDSA key fingerprint is SHA256:60dSjs9xJ+MITzSsQD/cS9faAOpZSjiZd7xVmS+vCE8.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
root@10.74.9.29's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'root@10.74.9.29'"
and check to make sure that only the key(s) you wanted were added.

vagrant@vagrant:~$
```

Проверяем подключение по ключу:  
```
vagrant@vagrant:~$
vagrant@vagrant:~$ ssh 'root@10.74.9.29'
Linux lin-tst2 5.10.0-9-amd64 #1 SMP Debian 5.10.70-1 (2021-09-30) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Thu Nov 25 10:31:50 2021 from 172.20.5.4
root@lin-tst2:~#
root@lin-tst2:~#
```
попали на сервер под root-ом  

6.  
Переименовываем файл закрытого ключа:  
```
vagrant@vagrant:~/.ssh$
vagrant@vagrant:~/.ssh$ mv id_rsa for-lin-tst2.key
vagrant@vagrant:~/.ssh$
```

Создаём конфиг для клиента:  
```
vagrant@vagrant:~/.ssh$ cat config
Host lin-tst2
  HostName lin-tst2.drsk.ru
  IdentityFile ~/.ssh/for-lin-tst2.key
  User root
  Port 22
vagrant@vagrant:~/.ssh$
```

Проверяем подключение по имени хоста:  
```
vagrant@vagrant:~/.ssh$
vagrant@vagrant:~/.ssh$ ssh lin-tst2
The authenticity of host 'lin-tst2.drsk.ru (10.74.9.29)' can't be established.
ECDSA key fingerprint is SHA256:60dSjs9xJ+MITzSsQD/cS9faAOpZSjiZd7xVmS+vCE8.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'lin-tst2.drsk.ru' (ECDSA) to the list of known hosts.
Linux lin-tst2 5.10.0-9-amd64 #1 SMP Debian 5.10.70-1 (2021-09-30) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Wed Dec  1 14:00:28 2021 from 172.20.5.4
root@lin-tst2:~#
```
Подключились рутом у серверу.  

7.  
Запускаем дамп:  
```
root@lin-tst2:~#
root@lin-tst2:~# tcpdump -c 100 -w dump.pcap
tcpdump: listening on ens192, link-type EN10MB (Ethernet), snapshot length 262144 bytes

100 packets captured
108 packets received by filter
0 packets dropped by kernel
root@lin-tst2:~#
```
Копируем dump.pcap на компьютер с установленным wireshark и открываем файл, видим в основном ssh трафик:  
(https://github.com/Danil054/devops-netology/blob/main/pics/dump.png)  






