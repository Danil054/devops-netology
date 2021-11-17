1.  
Sparse-файл, это файл в котором последовательность нулевых байтов, заменены информацией о этой последовательности, тем самым позволяя занимать меньше дискового пространства.  


2.  
Нет, так как inode один для всех хардлинков на файл.  


3.  
Запускаемся:  
```
d:\vm\vagrant>vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'bento/ubuntu-20.04'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'bento/ubuntu-20.04' version '202107.28.0' is up to date...
==> default: Setting the name of the VM: vagrant_default_1635481179786_62305
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
    default:
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default:
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
==> default: Mounting shared folders...
    default: /vagrant => D:/vm/vagrant

d:\vm\vagrant>
```


4.  
Разбиваем первый доп. диск (``` fdisk /dev/sdb ``` ):  

```
Command (m for help): p
Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x08ab6673

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-5242879, default 2048):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-5242879, default 5242879): +2G

Created a new partition 1 of type 'Linux' and of size 2 GiB.

Command (m for help): n
Partition type
   p   primary (1 primary, 0 extended, 3 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (2-4, default 2): 2
First sector (4196352-5242879, default 4196352):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-5242879, default 5242879):

Created a new partition 2 of type 'Linux' and of size 511 MiB.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

root@vagrant:/home/vagrant#
root@vagrant:/home/vagrant# fdisk -l /dev/sdb
Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x08ab6673

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdb1          2048 4196351 4194304    2G 83 Linux
/dev/sdb2       4196352 5242879 1046528  511M 83 Linux
root@vagrant:/home/vagrant#
```


5.  
Копируем таблицу разделов с перого на второй доп. диск:  
```
root@vagrant:/home/vagrant#
root@vagrant:/home/vagrant# sfdisk -d /dev/sdb | sfdisk /dev/sdc
Checking that no-one is using this disk right now ... OK

Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Created a new DOS disklabel with disk identifier 0x08ab6673.
/dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.
/dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
/dev/sdc3: Done.

New situation:
Disklabel type: dos
Disk identifier: 0x08ab6673

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdc1          2048 4196351 4194304    2G 83 Linux
/dev/sdc2       4196352 5242879 1046528  511M 83 Linux

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
root@vagrant:/home/vagrant#
```


6.  
Создаём рэйд зеркало:  
```
root@vagrant:/home/vagrant#
root@vagrant:/home/vagrant# mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
mdadm: size set to 2094080K
Continue creating array? yes
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.
root@vagrant:/home/vagrant#
```


7.  
Создаём страйп:  
```
root@vagrant:/home/vagrant#
root@vagrant:/home/vagrant# mdadm --create --verbose /dev/md1 --level=0 --raid-devices=2 /dev/sdb2 /dev/sdc2
mdadm: chunk size defaults to 512K
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md1 started.
root@vagrant:/home/vagrant#
```


8.  
Создаём физич тома для LVM:  
```
root@vagrant:/home/vagrant# pvcreate /dev/md0
  Physical volume "/dev/md0" successfully created.
root@vagrant:/home/vagrant#
root@vagrant:/home/vagrant# pvcreate /dev/md1
  Physical volume "/dev/md1" successfully created.
root@vagrant:/home/vagrant#
```


9.  
Создаём LVM группу:  
```
root@vagrant:/home/vagrant#
root@vagrant:/home/vagrant# vgcreate lvmgrp1 /dev/md0 /dev/md1
  Volume group "lvmgrp1" successfully created
root@vagrant:/home/vagrant# 
```


10.  
Создаём LV на RAID0:  
```
root@vagrant:/home/vagrant# lvcreate -L100M lvmgrp1 /dev/md1
  Logical volume "lvol0" created.
root@vagrant:/home/vagrant#
```


11.  
Создаём файловую систему на LV:  
```
root@vagrant:/home/vagrant# mkfs.ext4 /dev/lvmgrp1/lvol0
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

root@vagrant:/home/vagrant#
```


12.  
Монтируем:  
```
root@vagrant:/home/vagrant#
root@vagrant:/home/vagrant# mkdir /tmp/new
root@vagrant:/home/vagrant# mount /dev/lvmgrp1/lvol0 /tmp/new
root@vagrant:/home/vagrant#
```


13.  
Размещаем файл:  
```
root@vagrant:/home/vagrant# wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
--2021-10-29 04:52:14--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 22126613 (21M) [application/octet-stream]
Saving to: ‘/tmp/new/test.gz’

/tmp/new/test.gz                                                100%[====================================================================================================================================================>]  21.10M  4.70MB/s    in 8.2s

2021-10-29 04:52:23 (2.58 MB/s) - ‘/tmp/new/test.gz’ saved [22126613/22126613]

root@vagrant:/home/vagrant#
```


14.  
Вывод lsblk:  
```
root@vagrant:/home/vagrant#
root@vagrant:/home/vagrant# lsblk
NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                    8:0    0   64G  0 disk
├─sda1                 8:1    0  512M  0 part  /boot/efi
├─sda2                 8:2    0    1K  0 part
└─sda5                 8:5    0 63.5G  0 part
  ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
  └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
sdb                    8:16   0  2.5G  0 disk
├─sdb1                 8:17   0    2G  0 part
│ └─md0                9:0    0    2G  0 raid1
└─sdb2                 8:18   0  511M  0 part
  └─md1                9:1    0 1018M  0 raid0
    └─lvmgrp1-lvol0  253:2    0  100M  0 lvm   /tmp/new
sdc                    8:32   0  2.5G  0 disk
├─sdc1                 8:33   0    2G  0 part
│ └─md0                9:0    0    2G  0 raid1
└─sdc2                 8:34   0  511M  0 part
  └─md1                9:1    0 1018M  0 raid0
    └─lvmgrp1-lvol0  253:2    0  100M  0 lvm   /tmp/new
root@vagrant:/home/vagrant#
```


15.  
Тестируем целостность:  
```
root@vagrant:/home/vagrant#
root@vagrant:/home/vagrant# gzip -t /tmp/new/test.gz
root@vagrant:/home/vagrant# echo $?
0
root@vagrant:/home/vagrant#
```


16.  
Перемещаем:  
```
root@vagrant:/home/vagrant# pvmove /dev/md1 /dev/md0
  /dev/md1: Moved: 8.00%
  /dev/md1: Moved: 100.00%
root@vagrant:/home/vagrant#
```


17.  
Делаем сбой одного из дисков  врейде:  
```
root@vagrant:/home/vagrant#
root@vagrant:/home/vagrant# mdadm --fail /dev/md0 /dev/sdb1
mdadm: set /dev/sdb1 faulty in /dev/md0
root@vagrant:/home/vagrant#
```


18.  
Наблюдаем в выводе dmesg:  
```
[ 2639.768098] md/raid1:md0: Disk failure on sdb1, disabling device.
               md/raid1:md0: Operation continuing on 1 devices.
```


19.  
Проверяем уелостность:  
```
root@vagrant:/home/vagrant#
root@vagrant:/home/vagrant# gzip -t /tmp/new/test.gz
root@vagrant:/home/vagrant# echo $?
0
root@vagrant:/home/vagrant#
```


20.  
Уничтожаем чего вагрант насоздавал:
```
d:\vm\vagrant>vagrant halt
==> default: Attempting graceful shutdown of VM...

d:\vm\vagrant>
```
```
d:\vm\vagrant>vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: Destroying VM and associated drives...

d:\vm\vagrant>
```
