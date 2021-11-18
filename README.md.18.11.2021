1.  
Получили код 301 - Постоянный редирект  
```
root@lin-tst2:~# telnet stackoverflow.com 80
Trying 151.101.1.69...
Connected to stackoverflow.com.
Escape character is '^]'.
GET /questions HTTP/1.0
HOST: stackoverflow.com


HTTP/1.1 301 Moved Permanently
cache-control: no-cache, no-store, must-revalidate
location: https://stackoverflow.com/questions
x-request-guid: 02a361f5-766c-41b6-bd1e-88114992a5e8
feature-policy: microphone 'none'; speaker 'none'
content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
Accept-Ranges: bytes
Date: Tue, 16 Nov 2021 07:03:35 GMT
Via: 1.1 varnish
Connection: close
X-Served-By: cache-fra19160-FRA
X-Cache: MISS
X-Cache-Hits: 0
X-Timer: S1637046215.085295,VS0,VE92
Vary: Fastly-SSL
X-DNS-Prefetch-Control: off
Set-Cookie: prov=56c8c277-a71f-6f6f-f29e-a1c4e469bd0b; domain=.stackoverflow.com; expires=Fri, 01-Jan-2055 00:00:00 GMT; path=/; HttpOnly

Connection closed by foreign host.
root@lin-tst2:~#
```


2.  
В первом ответе получили код 301 ```Status Code: 301 Moved Permanently```  
Судя по всему самое долго обрабатывался следующий. после получения кода об редиректе (так как потрачено время на инициализацию соединения)  
см. скриншот:  (https://github.com/Danil054/devops-netology/blob/main/pics/f12-net.png)   


3.  
91.207.82.13  
```
root@lin-tst2:~/gitrepo/devops-netology# curl 2ip.ru
91.207.82.13
root@lin-tst2:~/gitrepo/devops-netology#
```


4  
 Far-Eastern Distribution Company JSC  
 AS48058  
```
root@lin-tst2:~/gitrepo/devops-netology# whois 91.207.82.13
% This is the RIPE Database query service.
% The objects are in RPSL format.
%
% The RIPE Database is subject to Terms and Conditions.
% See http://www.ripe.net/db/support/db-terms-conditions.pdf

% Note: this output has been filtered.
%       To receive output for a database update, use the "-B" flag.

% Information related to '91.207.82.0 - 91.207.83.255'

% Abuse contact for '91.207.82.0 - 91.207.83.255' is 'abuse@drsk.ru'

inetnum:        91.207.82.0 - 91.207.83.255
netname:        DRSK-NET
country:        RU
org:            ORG-FDCJ1-RIPE
admin-c:        DRSK1-RIPE
tech-c:         DRSK1-RIPE
status:         ASSIGNED PI
mnt-by:         MNT-DRSK
mnt-by:         RIPE-NCC-END-MNT
mnt-routes:     MNT-DRSK
mnt-domains:    MNT-DRSK
created:        2008-10-02T11:29:54Z
last-modified:  2019-05-28T09:55:31Z
source:         RIPE # Filtered
sponsoring-org: ORG-CS216-RIPE

organisation:   ORG-FDCJ1-RIPE
org-name:       Far-Eastern Distribution Company JSC.
org-type:       OTHER
address:        Russia, Amurskaya obl., Blagoveschensk, Shevchenko str., 28
abuse-c:        DRSK1-RIPE
mnt-ref:        MNT-DRSK
mnt-by:         MNT-DRSK
created:        2008-07-30T08:33:27Z
last-modified:  2014-11-18T09:52:52Z
source:         RIPE # Filtered

role:           DRSK NOC
abuse-mailbox:  abuse@drsk.ru
address:        28, Shevchenko st
address:        675000 Blagoveschensk Russia
admin-c:        NSA10-RIPE
tech-c:         YBT1-RIPE
nic-hdl:        DRSK1-RIPE
mnt-by:         MNT-DRSK
created:        2008-10-06T13:09:28Z
last-modified:  2014-11-18T09:49:51Z
source:         RIPE # Filtered

% Information related to '91.207.82.0/24AS48058'

route:          91.207.82.0/24
origin:         AS48058
mnt-by:         MNT-DRSK
created:        2017-10-05T02:23:49Z
last-modified:  2017-10-05T02:23:49Z
source:         RIPE

% This query was served by the RIPE Database Query Service version 1.101 (ANGUS)


root@lin-tst2:~/gitrepo/devops-netology#
```
p.s.  
Это на работе, у нас свой небольшой (/23) блок адресов  


5.  
```
root@lin-tst2:~/gitrepo/devops-netology# traceroute -An 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  10.74.9.254 [*]  0.422 ms  0.264 ms  0.220 ms
 2  91.207.82.1 [AS48058]  4.569 ms  4.576 ms  4.485 ms
 3  85.140.127.5 [AS39811]  4.825 ms  4.868 ms  5.037 ms
 4  85.140.127.161 [AS39811]  4.528 ms  4.820 ms  4.853 ms
 5  212.188.22.198 [AS8359]  5.131 ms  4.961 ms  4.967 ms
 6  212.188.2.105 [AS8359]  105.190 ms  102.093 ms  102.207 ms
 7  212.188.55.161 [AS8359]  13.091 ms  12.942 ms  13.453 ms
 8  212.188.1.201 [AS8359]  31.651 ms  31.546 ms  32.353 ms
 9  212.188.55.113 [AS8359]  96.757 ms  96.696 ms  96.725 ms
10  212.188.42.177 [AS8359]  48.519 ms  48.437 ms  48.651 ms
11  212.188.42.149 [AS8359]  69.410 ms  69.607 ms  67.946 ms
12  212.188.29.85 [AS8359]  83.660 ms  83.686 ms  83.665 ms
13  195.34.50.161 [AS8359]  96.522 ms  96.476 ms  96.484 ms
14  212.188.29.82 [AS8359]  96.130 ms  96.409 ms  96.420 ms
15  108.170.250.34 [AS15169]  94.968 ms 108.170.250.99 [AS15169]  95.037 ms 108.170.250.83 [AS15169]  95.176 ms
16  * 142.251.49.24 [AS15169]  118.551 ms 209.85.255.136 [AS15169]  121.567 ms
17  72.14.238.168 [AS15169]  118.822 ms 216.239.57.222 [AS15169]  117.386 ms 72.14.238.168 [AS15169]  126.026 ms
18  216.239.63.65 [AS15169]  116.503 ms 216.239.47.167 [AS15169]  119.378 ms 142.250.56.125 [AS15169]  116.592 ms
19  * * *
20  * * *
21  * * *
22  * * *
23  * * *
24  * * *
25  * * *
26  8.8.8.8 [AS15169]  117.005 ms * *
root@lin-tst2:~/gitrepo/devops-netology#
```


6.  
```
                                                                                      My traceroute  [v0.94]
lin-tst2 (10.74.9.29) -> 8.8.8.8                                                                                                                                               2021-11-17T08:58:02+0900
Keys:  Help   Display mode   Restart statistics   Order of fields   quit
                                                                                                                                                               Packets               Pings
 Host                                                                                                                                                        Loss%   Snt   Last   Avg  Best  Wrst StDev
 1. AS???    10.74.9.254                                                                                                                                      0.0%    51    0.5   1.4   0.3  47.2   6.6
 2. AS48058  91.207.82.1                                                                                                                                      0.0%    51    0.9   0.8   0.6   1.3   0.1
 3. AS39811  85.140.127.5                                                                                                                                     0.0%    51   29.0   6.7   2.0  55.2  11.3
 4. AS39811  85.140.127.161                                                                                                                                   0.0%    51    2.1   2.2   2.0   2.7   0.1
 5. AS8359   212.188.22.198                                                                                                                                   0.0%    51    2.2   3.1   1.8  30.4   4.1
 6. AS8359   212.188.2.105                                                                                                                                    0.0%    51  104.2 102.5 101.9 105.2   0.7
 7. AS8359   212.188.55.161                                                                                                                                   0.0%    51   12.8  13.2  12.5  28.7   2.3
 8. AS8359   212.188.1.201                                                                                                                                    0.0%    51   35.6  31.5  31.0  35.6   0.7
 9. AS8359   212.188.55.113                                                                                                                                   0.0%    51   95.8  95.9  95.3  97.3   0.5
10. AS8359   212.188.42.177                                                                                                                                   0.0%    51   47.2  47.1  46.7  47.4   0.1
11. AS8359   212.188.42.149                                                                                                                                   0.0%    51   68.3  67.9  67.6  68.5   0.2
12. AS8359   212.188.29.85                                                                                                                                    0.0%    51   84.0  83.8  83.4  84.5   0.2
13. AS8359   195.34.50.161                                                                                                                                    0.0%    51   96.0  95.8  95.4  96.3   0.2
14. AS8359   212.188.29.82                                                                                                                                    0.0%    51   95.7  95.6  95.2  96.4   0.2
15. AS15169  108.170.250.34                                                                                                                                   0.0%    51   93.3  93.5  93.2  96.0   0.4
16. AS15169  172.253.66.116                                                                                                                                   0.0%    51  118.9 119.4 118.6 124.5   1.1
17. AS15169  172.253.66.108                                                                                                                                   0.0%    51  120.7 120.2 117.2 156.6   7.0
18. AS15169  72.14.235.193                                                                                                                                    0.0%    51  120.3 119.8 118.4 150.3   4.5
19. (waiting for reply)
20. (waiting for reply)
21. (waiting for reply)
22. (waiting for reply)
23. (waiting for reply)
24. (waiting for reply)
25. (waiting for reply)
26. (waiting for reply)
27. (waiting for reply)
28. AS15169  8.8.8.8                                                                                                                                         38.0%    50  117.7 117.7 117.5 117.9   0.1

```
наибольшая задержка от 172.253.66.108  


7.  
```
root@lin-tst2:~/gitrepo/devops-netology# dig +trace dns.google ns

; <<>> DiG 9.16.15-Debian <<>> +trace dns.google ns
;; global options: +cmd
.                       107579  IN      NS      j.root-servers.net.
.                       107579  IN      NS      k.root-servers.net.
.                       107579  IN      NS      l.root-servers.net.
.                       107579  IN      NS      h.root-servers.net.
.                       107579  IN      NS      f.root-servers.net.
.                       107579  IN      NS      e.root-servers.net.
.                       107579  IN      NS      m.root-servers.net.
.                       107579  IN      NS      i.root-servers.net.
.                       107579  IN      NS      g.root-servers.net.
.                       107579  IN      NS      c.root-servers.net.
.                       107579  IN      NS      b.root-servers.net.
.                       107579  IN      NS      d.root-servers.net.
.                       107579  IN      NS      a.root-servers.net.
;; Received 824 bytes from 10.74.9.140#53(10.74.9.140) in 0 ms

google.                 172800  IN      NS      ns-tld1.charlestonroadregistry.com.
google.                 172800  IN      NS      ns-tld2.charlestonroadregistry.com.
google.                 172800  IN      NS      ns-tld3.charlestonroadregistry.com.
google.                 172800  IN      NS      ns-tld4.charlestonroadregistry.com.
google.                 172800  IN      NS      ns-tld5.charlestonroadregistry.com.
google.                 86400   IN      DS      6125 8 2 80F8B78D23107153578BAD3800E9543500474E5C30C29698B40A3DB2 3ED9DA9F
google.                 86400   IN      RRSIG   DS 8 1 86400 20211129170000 20211116160000 14748 . L9Zyh/iUxwO9RNXO1zSEiPhfZVqqdagSNfGPnSkhFk/Bk63v0YCOmiRh n01o6TwGZ94u+j7KxYq4a/e+J0gy+QgN9oGvUhXm+MvqFmOVJcG/Vv91 6W1OB8MtnlB5bLop3zWPyuUTRCajQfN3NzIPOzssMn/vsBUBL5YrDSL0 Brn0ec5WONNXbLDp8viTf5fUlu5epRVDKM9wjDz9oek85ACecikvFp0s OYYV7P/g4JgY6Tp1yCFGpR38V4ZC4XS7W6HYCszDR6s+2WJpaLfMWtpk UF8pX2js+HtxKUSQ/hi4oXtKRiD/CeZO5trpFOvlmr6bT04SwdlhbAD3 EiQN3A==
;; Received 730 bytes from 192.5.5.241#53(f.root-servers.net) in 104 ms

dns.google.             10800   IN      NS      ns4.zdns.google.
dns.google.             10800   IN      NS      ns1.zdns.google.
dns.google.             10800   IN      NS      ns3.zdns.google.
dns.google.             10800   IN      NS      ns2.zdns.google.
dns.google.             3600    IN      DS      56044 8 2 1B0A7E90AA6B1AC65AA5B573EFC44ABF6CB2559444251B997103D2E4 0C351B08
dns.google.             3600    IN      RRSIG   DS 8 2 3600 20211206042303 20211114042303 8830 google. GeLPRK+MKGF7VVXfaJcTebk1xAMKbAbbJny2ZmgmYX0EXp0TeuADlR/B YbzzGI1aAUwrCiofdvh2nA2NUTKKanGCjWrs7yMdJpHfDnjy2Qg3C+kP lRUPq0/DrDNHsantE6HX9YS5ESi/uKAJZkJmq+h4pmrLmM7jzJ6okTyL ZbY=
;; Received 506 bytes from 216.239.38.105#53(ns-tld4.charlestonroadregistry.com) in 124 ms

dns.google.             86400   IN      NS      ns1.zdns.google.
dns.google.             86400   IN      NS      ns2.zdns.google.
dns.google.             86400   IN      NS      ns4.zdns.google.
dns.google.             86400   IN      NS      ns3.zdns.google.
dns.google.             86400   IN      RRSIG   NS 8 2 86400 20211216161145 20211116161145 1773 dns.google. DmWYia6rp1dMI2/G+EQNvTJZoltbjaXXLi22Tmn4PWWefFU7RoOjIFfg Jcg+v9rfimDbg2n+qIpWBqbqc0tWNpcNqm8+A0+j9ow+kykTnJW683lC BOE+8e2pqA+D6nDf3UuDKBwtDbknOjGd1MHvMsjl/cnnEPiX/qQ6LQxd 7Zw=
;; Received 286 bytes from 216.239.32.114#53(ns1.zdns.google) in 148 ms

root@lin-tst2:~/gitrepo/devops-netology#
```

DNS сервера для dns.google:  
```
ns1.zdns.google.
ns2.zdns.google.
ns4.zdns.google.
ns3.zdns.google.
```

A записи:  
```
dns.google.             900     IN      A       8.8.8.8
dns.google.             900     IN      A       8.8.4.4
```

Поиск A записи:  
```
root@lin-tst2:~/gitrepo/devops-netology# dig @ns1.zdns.google. dns.google a

; <<>> DiG 9.16.15-Debian <<>> @ns1.zdns.google. dns.google a
; (2 servers found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 932
;; flags: qr aa rd; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;dns.google.                    IN      A

;; ANSWER SECTION:
dns.google.             900     IN      A       8.8.8.8
dns.google.             900     IN      A       8.8.4.4

;; Query time: 148 msec
;; SERVER: 216.239.32.114#53(216.239.32.114)
;; WHEN: Wed Nov 17 09:03:03 +09 2021
;; MSG SIZE  rcvd: 71

root@lin-tst2:~/gitrepo/devops-netology#
```

8.  
PTR записи:  
```
8.8.8.8.in-addr.arpa.   86399   IN      PTR     dns.google.
4.4.8.8.in-addr.arpa.   86399   IN      PTR     dns.google.
```
Доменное имя привязано: dns.google.  

```
root@lin-tst2:~/gitrepo/devops-netology# dig -x 8.8.8.8

; <<>> DiG 9.16.15-Debian <<>> -x 8.8.8.8
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 56156
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4000
;; QUESTION SECTION:
;8.8.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
8.8.8.8.in-addr.arpa.   86399   IN      PTR     dns.google.

;; Query time: 724 msec
;; SERVER: 10.74.9.140#53(10.74.9.140)
;; WHEN: Wed Nov 17 09:05:05 +09 2021
;; MSG SIZE  rcvd: 73

root@lin-tst2:~/gitrepo/devops-netology#
root@lin-tst2:~/gitrepo/devops-netology#
root@lin-tst2:~/gitrepo/devops-netology# dig -x 8.8.4.4

; <<>> DiG 9.16.15-Debian <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 62845
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4000
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.   86399   IN      PTR     dns.google.

;; Query time: 376 msec
;; SERVER: 10.74.9.140#53(10.74.9.140)
;; WHEN: Wed Nov 17 09:05:13 +09 2021
;; MSG SIZE  rcvd: 73

root@lin-tst2:~/gitrepo/devops-netology#
```
