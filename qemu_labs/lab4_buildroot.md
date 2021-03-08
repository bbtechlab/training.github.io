# Using buildroot to cross compile completly a embedded linux for QEMU ARM emulator 
We need to complete [lab1_toolchains](lab1_toolchains_crosstool-ng.md) to generate the ARM cross toolchain which uses for compling kernel in this lab.

For this lab, we will decrible steps by steps to cross compile embedded linux (linux, rootfs) for ARM Versatile Express Cortex-A9 that is supported by QEMU ARM Emulator.
* Download buildroot v2021.02 available at https://buildroot.org/download.html.

## Prerequisite

Host environment is required for this lab consists of
* Ubuntu 16_O4LTS_x64, for mines:
```
$ cat /proc/version
Linux version 4.15.0-136-generic (buildd@lcy01-amd64-014) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.12)) #140~16.04.1-Ubuntu SMP Wed Feb 3 18:51:03 UTC 2021
```
* $ sudo apt install qemu-user qemu-system-arm build-essential git autoconf bison flex texinfo help2man gawk libtool-bin libncurses5-dev

## Steps to cross compile buildroot for QEMU ARM Cortex A9
```
$ cd ~/workspace/bbtechlab_training/qemu_labs/opensource
$ wget https://buildroot.org/downloads/buildroot-2021.02.tar.gz
$ tar -xvf buildroot-2021.02.tar.gz
```
Configure the buildroot for QEMU ARM Cortex A9
```
$ cd buildroot-2021.02/
$ make menuconfig
```
* Target options
    * Target Architecture: ARM (little endian)
    * Target Architecture Variant: cortex-A9
* Toolchain - using external toolchains from  [lab1_toolchains](lab1_toolchains_crosstool-ng.md)
    * Toolchain type: External toolchain
    * Toolchain: Custom toolchain
    * Toolchain path: use the toolchain you built: /opt/toolchains/arm-traininglinux-uclibcgnueabi (replace <this path> by your actual path)
    * External toolchain gcc version: 9.x
    * External toolchain kernel headers series: 5.5.x
    * External toolchain C library: uClibc/uClibc-ng
    * We must tell Buildroot about our toolchain configuration, so select Toolchain has WCHAR support?, Toolchain has SSP support? and Toolchain has C++ support?. Buildroot will check these parameters anyway.
* Target packages
    * Keep BusyBox (default version) and keep the Busybox configuration proposed by Buildroot
    * Audio and video applications
        * Select alsa-utils
        * Select alsamixer
        * Select aplay (to play a WAV file as long as the OGG file doesn’t play properly).
        * Select vorbis-tools
* Filesystem images
    Select tar the root filesystem
The output locates in  buildroot-2021.02/output/images/rootfs.tar
   
## Testing an embedded linux that is built by buildroot with QEMU ARM
### Setup nfs-kernel-server
```
$ sudo apt-get install nfs-kernel-server
Once installed, edit the /etc/exports file as root to add the following line, assuming that the IP address of qemu emulator board will be 192.168.1.100:
$ sudo vi /etc/exports
# /etc/exports: the access control list for filesystems which may be exported
  1 # /etc/exports: the access control list for filesystems which may be exported
  2 #       to NFS clients.  See exports(5).
  3 #
  4 # Example for NFSv2 and NFSv3:
  5 # /srv/homes       hostname1(rw,sync,no_subtree_check) hostname2(ro,sync,no_subtree_check)
  6 #
  7 # Example for NFSv4:
  8 # /srv/nfs4        gss/krb5i(rw,sync,fsid=0,crossmnt,no_subtree_check)
  9 # /srv/nfs4/homes  gss/krb5i(rw,sync,no_subtree_check)
 10 #
 11 # /home/bamboo/workspace/nfsroot/qemu_arm/vexpress_a9 192.168.1.100(rw,no_root_squash,no_subtree_check)
make sure that there is no space between the IP address and the NFS options, otherwise default options will be used for this IP address, causing your root filesystem to be read-only.
$ sudo service nfs-kernel-server restart
```
Display all exported file systems from an NFS server
```
[12:36 PM]bamboo@bbtechlab~/workspace/nfsroot/qemu_arm/vexpress_a9
$ sudo showmount -e
Export list for bbtechlab:
/home/bamboo/workspace/nfsroot/qemu_arm/vexpress_a9 192.168.1.100
```

### Setup tftp server
Setup tfpt server
```
$ sudo apt install tftpd-hpa
$ sudo systemctl status tftpd-hpa
● tftpd-hpa.service - LSB: HPA's tftp server
   Loaded: loaded (/etc/init.d/tftpd-hpa; bad; vendor preset: enabled)
   Active: active (running) since T2 2021-03-08 12:42:09 +07; 10s ago
     Docs: man:systemd-sysv-generator(8)
   CGroup: /system.slice/tftpd-hpa.service
           └─21611 /usr/sbin/in.tftpd --listen --user tftp --address :69 --secure /var/lib/tftpboot

Th03 08 12:42:09 bbtechlab systemd[1]: Starting LSB: HPA's tftp server...
Th03 08 12:42:09 bbtechlab tftpd-hpa[21598]:  * Starting HPA's tftpd in.tftpd
Th03 08 12:42:09 bbtechlab tftpd-hpa[21598]:    ...done.
Th03 08 12:42:09 bbtechlab systemd[1]: Started LSB: HPA's tftp server.

$ sudo vi /etc/default/tftpd-hpa
  1 # /etc/default/tftpd-hpa
  2 
  3 TFTP_USERNAME="tftp"
  4 TFTP_DIRECTORY="/home/bamboo/workspace/tftpboot"        ---> Change this path for yours                                                             
  5 TFTP_ADDRESS=":69"
  6 TFTP_OPTIONS="--secure --create"

$ sudo chown tftp:tftp /home/bamboo/workspace/tftpboot/
$ sudo systemctl restart tftpd-hpa
$ sudo systemctl status tftpd-hpa
● tftpd-hpa.service - LSB: HPA's tftp server
   Loaded: loaded (/etc/init.d/tftpd-hpa; bad; vendor preset: enabled)
   Active: active (running) since T2 2021-03-08 12:47:23 +07; 7s ago
     Docs: man:systemd-sysv-generator(8)
  Process: 21786 ExecStop=/etc/init.d/tftpd-hpa stop (code=exited, status=0/SUCCESS)
  Process: 21797 ExecStart=/etc/init.d/tftpd-hpa start (code=exited, status=0/SUCCESS)
   CGroup: /system.slice/tftpd-hpa.service
           └─21812 /usr/sbin/in.tftpd --listen --user tftp --address :69 --secure --create /home/bamboo/workspace

Th03 08 12:47:23 bbtechlab systemd[1]: Stopped LSB: HPA's tftp server.
Th03 08 12:47:23 bbtechlab systemd[1]: Starting LSB: HPA's tftp server...
Th03 08 12:47:23 bbtechlab tftpd-hpa[21797]:  * Starting HPA's tftpd in.tftpd
Th03 08 12:47:23 bbtechlab tftpd-hpa[21797]:    ...done.
Th03 08 12:47:23 bbtechlab systemd[1]: Started LSB: HPA's tftp server.
lines 1-14/14 (END)
```
As you can see, the tftpd-hpa service is running. So, the configuration is successful. Now, we try to test tftp server
```
$ sudo apt install tftp-hpa     #install tftp client
$ cd ~/workspace
$ echo "helloworld" > test_tftp.txt
$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:2b:e3:c9 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 74230sec preferred_lft 74230sec
    inet6 fe80::be1a:8dfd:8981:6518/64 scope link 
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:df:5e:8c brd ff:ff:ff:ff:ff:ff
    inet 192.168.56.103/24 brd 192.168.56.255 scope global dynamic enp0s8
       valid_lft 480sec preferred_lft 480sec
    inet6 fe80::7cdf:d2c8:3166:6f1c/64 scope link 
       valid_lft forever preferred_lft forever
$ tftp 192.168.56.103
tftp> verbose
Verbose mode on.
tftp> put test_tftp.txt
tftp> quit
$ cat ~/workspace/tftpboot/test_tftp.txt 
helloworld
```
### Booting the system
Got zImage and device tree from [lab2_kernel](https://github.com/bbtechlab/training.github.io/tree/embedded_linux/qemu_labs/lab2_kernel), copy them to tftp server directory
```
$ cp ~/workspace/bbtechlab_training/qemu_labs/lab2_kernel/vexpress/zImage ~/workspace/tftpboot/qemu_arm/vexpress_a9/
$ cp -f ~/workspace/bbtechlab_training/qemu_labs/lab2_kernel/vexpress/vexpress-v2p-ca9.dtb ~/workspace/tftpboot/qemu_arm/vexpress_a9/
```
Extract rootfilesystem from this lab to nfsroot directory
```
$ cd ~/workspace/nfsroot/qemu_arm/vexpress_a9/
$ tar -xvf  ~/workspace/bbtechlab_training/qemu_labs/opensource/buildroot-2021.02/output/images/rootfs.tar ./
$ ls -al
[12:23 PM]bamboo@bbtechlab~/workspace/nfsroot/qemu_arm/vexpress_a9
$ ls -al
total 68
drwxr-xr-x 17 bamboo bamboo 4096 Th03  8 10:15 .
drwxrwxr-x  3 bamboo bamboo 4096 Th03  8 12:20 ..
drwxr-xr-x  2 bamboo bamboo 4096 Th03  8 10:19 bin
drwxr-xr-x  4 bamboo bamboo 4096 Th03  7 04:16 dev
drwxr-xr-x  5 bamboo bamboo 4096 Th03  8 10:19 etc
drwxr-xr-x  2 bamboo bamboo 4096 Th03  8 10:19 lib
lrwxrwxrwx  1 bamboo bamboo    3 Th03  8 10:09 lib32 -> lib
lrwxrwxrwx  1 bamboo bamboo   11 Th03  8 10:15 linuxrc -> bin/busybox
drwxr-xr-x  2 bamboo bamboo 4096 Th03  7 04:16 media
drwxr-xr-x  2 bamboo bamboo 4096 Th03  7 04:16 mnt
drwxr-xr-x  2 bamboo bamboo 4096 Th03  7 04:16 opt
drwxr-xr-x  2 bamboo bamboo 4096 Th03  7 04:16 proc
drwx------  2 bamboo bamboo 4096 Th03  7 04:16 root
drwxr-xr-x  2 bamboo bamboo 4096 Th03  7 04:16 run
drwxr-xr-x  2 bamboo bamboo 4096 Th03  8 10:15 sbin
drwxr-xr-x  2 bamboo bamboo 4096 Th03  7 04:16 sys
drwxrwxr-x  2 bamboo bamboo 4096 Th03  7 04:16 tmp
drwxr-xr-x  6 bamboo bamboo 4096 Th03  8 10:19 usr
drwxr-xr-x  4 bamboo bamboo 4096 Th03  8 10:19 var
``` 
Setup networking between QEMU and the host
```
$ cd ~/workspace/bbtechlab_training/qemu_labs/lab3_uboot
$ sudo apt-get install bridge-utils iptables dnsmasq
$ sudo chmod 755 /etc/qemu-ifup
$ vi qemu-myifup
#!/bin/sh
/sbin/ip a add 192.168.56.1/24 dev $1
/sbin/ip link set $1 up
$ chmod +x qemu-myifup
$ qemu-system-arm -M vexpress-a9 -m 512M -nographic -kernel vexpress/u-boot -net tap,script=./qemu-myifup -net nic
```

Back in U-Boot, run bdinfo, which will allow you to find out that RAM starts at 0x60000000. Therefore, we will use the 0x61000000 address to test tftp.
```
=> bdinfo
boot_params = 0x60002000
DRAM bank   = 0x00000000
-> start    = 0x60000000
-> size     = 0x20000000
DRAM bank   = 0x00000001
-> start    = 0x80000000
-> size     = 0x00000004
memstart    = 0x60000000
memsize     = 0x20000000
flashstart  = 0x00000000
flashsize   = 0x08000000
flashoffset = 0x00000000
baudrate    = 38400 bps
relocaddr   = 0x7ff76000
reloc off   = 0x1f776000
Build       = 32-bit
current eth = smc911x-0
ethaddr     = 52:54:00:12:34:56
IP addr     = <NULL>
fdt_blob    = 0x00000000
new_fdt     = 0x00000000
fdt_size    = 0x00000000
arch_number = 0x000008e0
TLB addr    = 0x7fff0000
irq_sp      = 0x7fe75ee0
sp start    = 0x7fe75ed0
```
The tftp command should have downloaded the zImage file from your development workstation (tftpboot directory) into the board’s memory at location 0x61000000.
```

```
## References,
* [Bootlin QEMU labs](https://github.com/bootlin/training-materials)
* [Installing and Configuring TFTP Server on Ubuntu](https://linuxhint.com/install_tftp_server_ubuntu/)
* https://wiki.qemu.org/Documentation/Networking/NAT
