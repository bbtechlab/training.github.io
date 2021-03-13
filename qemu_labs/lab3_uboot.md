# Cross Compiling Bootloader - U-Boot for QEMU ARM emulator
For this lab, we will decrible steps by steps to cross compile U-BOOT for ARM Versatile Express Cortex-A9 that is supported by QEMU ARM Emulator.
* Download U-Boot v2020.10 here,https://github.com/u-boot/u-boot/releases

## I. Prerequisite

Host environment is required for this lab consists of
* Ubuntu 16_O4LTS_x64, for mines:
```
$ cat /proc/version
Linux version 4.15.0-136-generic (buildd@lcy01-amd64-014) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.12)) #140~16.04.1-Ubuntu SMP Wed Feb 3 18:51:03 UTC 2021
```
```
$ sudo apt install qemu-user qemu-system-arm build-essential git autoconf bison flex texinfo help2man gawk libtool-bin libncurses5-dev
```
* Network setting between personal computer and virtual machine Ubuntu 16_04LTS: Use both NAT and Brigde
```
[ Computer (MacOS/Window) ] <-- NAT and Bridge --> [Vmware/VirtualBox (Ubuntu 16_04LTS)]
```

* NAT is used for sharing network (with TUN/TAP interface - see 4.3) between ARM QEMU and host virtual machine Ubuntu 16_04LTS.
* Bridge is responsibilty for ssh remote.

The linux command on Ubuntu for these configuration as below
```
$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 00:0c:29:37:5b:72 brd ff:ff:ff:ff:ff:ff
3: ens38: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 00:0c:29:37:5b:7c brd ff:ff:ff:ff:ff:ff

$ sudo ip addr add 172.16.157.128/24 dev ens33
$ sudo ip addr add 172.16.157.128/24 dev ens33
$ sudo ip link set dev ens33 up
$ sudo ip addr add 192.168.1.134/24 dev ens38
$ sudo ip link set dev ens38 up
$ sudo ip route add default via 192.168.1.1
$ sudo vi /etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4

$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:37:5b:72 brd ff:ff:ff:ff:ff:ff
    inet 172.16.157.128/24 scope global ens33
       valid_lft forever preferred_lft forever
    inet6 fe80::20c:29ff:fe37:5b72/64 scope link 
       valid_lft forever preferred_lft forever
3: ens38: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:37:5b:7c brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.134/24 scope global ens38
       valid_lft forever preferred_lft forever
    inet6 fe80::20c:29ff:fe37:5b7c/64 scope link 
       valid_lft forever preferred_lft forever

$ ping google.com
PING google.com (216.58.220.206) 56(84) bytes of data.
64 bytes from del01s08-in-f206.1e100.net (216.58.220.206): icmp_seq=1 ttl=110 time=44.3 ms
...
```
Everything will done by adding below line to /etc/network/interfaces
```
$ sudo vi /etc/network/interfaces
auto ens38
    iface ens38 inet static
    address 192.168.1.134
    netmask 255.255.255.0
    gateway 192.168.1.1

auto ens33
    iface en33 inet static
    address 172.168.157.128
    netmask 255.255.255.0
    gateway 172.168.157.1
```
Now I'm able to remote virtual machine Ubuntu through SSH:
```
Fri Mar 12 23:02:44[bamboo@Dos-MacBook-Pro:~]$  ssh -x bamboo@192.168.1.134
The authenticity of host '192.168.1.134 (192.168.1.134)' can't be established.
ECDSA key fingerprint is SHA256:3pEqCbyrx2gz+zAbENQgqyjSfSiMkBqYOZ0PLpKS/+c.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.1.134' (ECDSA) to the list of known hosts.
bamboo@192.168.1.134's password: 
Welcome to Ubuntu 16.04.7 LTS (GNU/Linux 4.15.0-136-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage


26 packages can be updated.
0 updates are security updates.

New release '18.04.5 LTS' available.
Run 'do-release-upgrade' to upgrade to it.

Last login: Fri Mar 12 08:02:57 2021 from 192.168.1.2
bamboo@bbtechlab:~$ uname -a
Linux bbtechlab 4.15.0-136-generic #140~16.04.1-Ubuntu SMP Wed Feb 3 18:51:03 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
```    
## II. Steps to cross compile U-BOOT for QEMU ARM Cortex A9
Download the U_BOOT source code:
```
$ cd opensource
$ wget https://github.com/u-boot/u-boot/archive/v2020.10.tar.gz
$ tar -xfz v2020.10.tar.gz
```
Apply below patch for fixing editenv command
```
diff --git a/qemu_labs/opensource/u-boot-2020.10/board/armltd/vexpress/vexpress_common.c b/qemu_labs/opensource/u-boot-2020.10/board/armltd/vexpress/vexpress_common.c
index 70f6cd8..8fea8ff 100644
--- a/qemu_labs/opensource/u-boot-2020.10/board/armltd/vexpress/vexpress_common.c
+++ b/qemu_labs/opensource/u-boot-2020.10/board/armltd/vexpress/vexpress_common.c
@@ -55,7 +55,6 @@ int board_init(void)
 {
        gd->bd->bi_boot_params = LINUX_BOOT_PARAM_ADDR;
        gd->bd->bi_arch_number = MACH_TYPE_VEXPRESS;
-       gd->flags = 0;
 
        icache_enable();
        flash__init();
```
Steps to compile
```
$ cd u-boot-2020.10/
$ export CROSS_COMPILE=arm-linux-
$ find . -name "vexpress*"
./configs/vexpress_ca5x2_defconfig
./configs/vexpress_aemv8a_semi_defconfig
./configs/vexpress_ca9x4_defconfig
./configs/vexpress_ca15_tc2_defconfig
./configs/vexpress_aemv8a_juno_defconfig
...
$ make vexpress_ca9x4_defconfig
$ make menuconfig ### run this for customizing uboot
$ make
  OBJCOPY examples/standalone/hello_world.bin
  LDS     u-boot.lds
  LD      u-boot
  OBJCOPY u-boot.srec
  OBJCOPY u-boot-nodtb.bin
  COPY    u-boot.bin
  SYM     u-boot.sym
===================== WARNING ======================
This board does not use CONFIG_DM. CONFIG_DM will be
```
## III. Testing U-BOOT with ARM QEMU
```
$ qemu-system-arm -M vexpress-a9 -m 512M -nographic -kernel u-boot
```
* -M: emulated machine
* -m: amount of memory in the emulated machine
* -kernel: allows to load the binary directly in the emulated machine and run the machine with it. This way, you don’t need a first stage bootloader. Of course, you don’t have this with real hardware. Press a key before the end of the timeout, to access the U-Boot prompt. You can then type the help command, and explore the few commands available.
Note: to exit QEMU, type [Ctrl][a] followed by [h] to see available commands. One of them is [Ctrl][a] followed by [x], which allows to exit the emulator.

```
$ qemu-system-arm -M vexpress-a9 -m 512M -nographic -kernel u-boot-2020.04/u-boot

U-Boot 2020.10 (Mar 04 2021 - 17:14:12 +0700)

DRAM:  512 MiB
WARNING: Caches not enabled
Flash: 128 MiB
MMC:   MMC: 0
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Net:   smc911x-0
Hit any key to stop autoboot:  0 
```
## IV. Verify the booting sequence with ARM QEMU (U-BOOT load Kernel & Rootfs into ARM QEMU )
Example the booting sequence - how U-BOOT load Kernel/Rootfs as figure below:
![Booting Sequence](images/lab3_uboot_1.png)
	- U-BOOT loads DTB, Kernel and capably Rootfs binary from storage or network to RAM and jump to Kernel entry point.
	- Kernel launchs and tries to load the RAMDISK into RAM
	- Kernel loads device drivers (parses device tree blob & update it) and config files from RAMDISK
	- Kernel unmount RAMDISK and mounts root filesystem (mounting rootfs from nfs or storage or RAM directly)
	- Finally, Kernel starts the initialization stage

Because we have no storage with QEMU, therfore I will describe steps by steps how U-BOOT load kernel and rootfs from network
 - The Kernel & rootfs got from [lab2_kernel](lab2_kernel.md)
 - U-BOOT loads Kernel & DTB from TFTP.
 - Kernel is trying to mount rootfs from NFS.
### 4.1. Setup TFTP server
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
  3 TFTP_USERNAME="bamboo"
  4 TFTP_DIRECTORY="/home/bamboo/workspace/tftpboot"        ---> Change this path for yours                                                             
  5 TFTP_ADDRESS=":69"
  6 TFTP_OPTIONS="--secure --create"

$ sudo chown bamboo:bamboo /home/bamboo/workspace/tftpboot/
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
$ tftp 172.16.157.128
tftp> verbose
Verbose mode on.
tftp> put test_tftp.txt
putting test_tftp.txt to 172.16.157.128:test_tftp.txt [netascii]
Sent 12 bytes in 0.0 seconds [8664 bit/s]
tftp> quit
$ cat ~/workspace/tftpboot/test_tftp.txt 
helloworld
```
### 4.2. Setup nfs-kernel-server
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
/home/bamboo/workspace/nfsroot  *(rw,no_root_squash,no_all_squash,async,no_subtree_check)
make sure that there is no space between the IP address and the NFS options, otherwise default options will be used for this IP address, causing your root filesystem to be read-only.
$ sudo service nfs-kernel-server restart
```
Display all exported file systems from an NFS server
```
$ sudo showmount -e
Export list for bbtechlab:
/home/bamboo/workspace/nfsroot *
```
### 4.3. Setup networking between QEMU and the host
QEMU supports networking by emulating some popular network cards (NICs), and establishing virtual LANs (VLAN). There are four ways how QEMU guests can be connected then: user mode, socket redirection, Tap and VDE networking.

With this lab, I tried to setup network between QEMU and host - TAP interfaces, figure show the example configuration
![TAP/TUN Interface](images/lab3_uboot_2.png)
* $ sudo apt-get install bridge-utils iptables dnsmasq openvpn firestarter

Create a qemu-ifup locates in /etc
* $ cd /etc
* $ sudo vi qemu-ifup
```
#!/bin/sh
# Sample /etc/qemu-ifup to have bridged networking between qemu instances and your real net
# You need "youruser ALL=(root) NOPASSWD: /etc/qemu-ifup" in /etc/sudoers
# You also need enough rights on /dev/tun

# script to bring up the tun device in QEMU in bridged mode
# first parameter is name of tap device (e.g. tap0)

#
# some constants specific to the local host - change to suit your host
#
ETH0IPADDR=172.16.157.100
MASK=255.255.255.0
GATEWAY=172.16.157.1
BROADCAST=172.16.157.255
#
# First take ens33  down, then bring it up with IP address 0.0.0.0 
#
/sbin/ifdown ens33
/sbin/ifconfig ens33 0.0.0.0 promisc up
#
# Bring up the tap device (name specified as first argument, by QEMU)
#
/usr/sbin/openvpn --mktun --dev $1 --user `id -un`
/sbin/ifconfig $1 0.0.0.0 promisc up
#
# create the bridge between ens33 and the tap device
#
/sbin/brctl addbr br0
/sbin/brctl addif br0 ens33
/sbin/brctl addif br0 $1
# 
# only a single bridge so loops are not possible, turn off spanning tree
# protocol
#
/sbin/brctl stp br0 off 
# 
# Bring up the bridge with ETH0IPADDR and add the default route 
#
/sbin/ifconfig br0 $ETH0IPADDR netmask $MASK broadcast $BROADCAST
/sbin/route add default gw $GATEWAY
#
# stop firewall - comment this out if you don't use Firestarter
#
/usr/sbin/service firestarter stop
```
Create a qemu-ifdown locates in /etc
* $ cd /etc
* $ sudo vi qemu-ifdown
```
#!/bin/sh 
# 
# Script to bring down and delete bridge br0 when QEMU exits 
# 
# Bring down ens33 and br0 
#
/sbin/ifdown ens33
/sbin/ifdown br0
/sbin/ifconfig br0 down 
# 
# Delete the bridge
#
/sbin/brctl delbr br0 
# 
# bring up ens33 in "normal" mode 
#
/sbin/ifconfig ens33 -promisc
/sbin/ifup ens33
#
# delete the tap device
#
/usr/sbin/openvpn --rmtun --dev $1
#
# start firewall again
# 
/usr/sbin/service firestarter start
```
Allow user to excute scripts
* $ sudo chmod +x /etc/qemu-if*
### Verify the booting system with ARM QEMU
Load U-BOOT by using commands:

* $ sudo /etc/qemu-ifup tap0
* $ ip a

The we can the tap0 & br0 are added
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST,PROMISC,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master br0 state UP group default qlen 1000
    link/ether 00:0c:29:37:5b:72 brd ff:ff:ff:ff:ff:ff
    inet 172.16.157.128/24 brd 172.16.157.255 scope global dynamic ens33
       valid_lft 1352sec preferred_lft 1352sec
    inet6 fe80::2313:88cc:f73a:cf30/64 scope link 
       valid_lft forever preferred_lft forever
3: ens38: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:37:5b:7c brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.134/24 brd 192.168.1.255 scope global ens38
       valid_lft forever preferred_lft forever
    inet6 fe80::20c:29ff:fe37:5b7c/64 scope link 
       valid_lft forever preferred_lft forever
4: tap0: <BROADCAST,MULTICAST,PROMISC,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master br0 state UP group default qlen 100
    link/ether 0a:ef:fe:f3:50:e5 brd ff:ff:ff:ff:ff:ff
5: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:0c:29:37:5b:72 brd ff:ff:ff:ff:ff:ff
    inet 172.16.157.100/24 brd 172.16.157.255 scope global br0
       valid_lft forever preferred_lft forever
    inet6 fe80::20c:29ff:fe37:5b72/64 scope link 
       valid_lft forever preferred_lft forever
```
* $ cd ~/workspace/study/bbtechlab_training/qemu_labs/lab3_uboot
* $ sudo qemu-system-arm -M vexpress-a9 -m 512M -nographic -kernel vexpress/u-boot -net nic -net tap,ifname=tap0,script=no,downscript=no
```
U-Boot 2020.10 (Mar 05 2021 - 11:58:19 +0700)

DRAM:  512 MiB
WARNING: Caches not enabled
Flash: 128 MiB
MMC:   MMC: 0
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Net:   smc911x-0
Hit any key to stop autoboot:  0 
=> setenv ipaddr 172.16.157.101
=> setenv serverip 172.16.157.100
=> setenv gateway 172.16.157.1
=> ping 172.16.157.100
smc911x: MAC 52:54:00:12:34:56
smc911x: detected LAN9118 controller
smc911x: phy initialized
smc911x: MAC 52:54:00:12:34:56
Using smc911x-0 device
smc911x: MAC 52:54:00:12:34:56
host 172.16.157.100 is alive
=> setenv bootargs root=/dev/nfs rdinit=/sbin/init earlyprintk=serial,ttyS0 console=ttyAMA0 ip=172.16.157.101:::::eth0 nfsroot=172.16.157.100:/home/bamboo/workspace/nfsroot/qemu_arm,nfsvers=3,tcp rw
```
run bdinfo, which will allow you to find out that RAM starts at 0x60000000. Therefore, we will use the 0x61000000 address to load Kernel and 0x62000000 to load DTB
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
Copy the output Kernel, DTB binaries and Rootfs from We need to complete [lab2_kernel](lab1_kernel.md) to tftpboot & nfsroot directory
```
$ ls -al ~/workspace/tftpboot/
-rw-rw-r-- 1 bamboo bamboo   14143 Mar 12 09:18 vexpress-v2p-ca9.dtb
-rwxrwxr-x 1 bamboo bamboo 4664952 Mar 12 09:37 zImage

$ ls -al ~/workspace/nfsroot/qemu_arm/
drwxrwxr-x 2 bamboo bamboo 4096 Mar 12 09:36 bin
drwxrwxr-x 3 bamboo bamboo 4096 Mar 12 09:36 etc
lrwxrwxrwx 1 bamboo bamboo   11 Mar 12 09:36 linuxrc -> bin/busybox
drwxrwxr-x 2 bamboo bamboo 4096 Mar 12 09:36 sbin
drwxrwxr-x 4 bamboo bamboo 4096 Mar 12 09:36 usr
```
Back to U-BOOT command line. Now we try to load kernel to 0x61000000 and DTB to 0x62000000 of ARM QEMU
```
=> tftp 0x61000000 zImage
smc911x: MAC 52:54:00:12:34:56
smc911x: detected LAN9118 controller
smc911x: phy initialized
smc911x: MAC 52:54:00:12:34:56
Using smc911x-0 device
TFTP from server 172.16.157.100; our IP address is 172.16.157.101
Filename 'zImage'.
Load address: 0x61000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         ##########################################################
         6.6 MiB/s
done
Bytes transferred = 4664952 (472e78 hex)
smc911x: MAC 52:54:00:12:34:56
=> tftp 0x62000000 vexpress-v2p-ca9.dtb
smc911x: MAC 52:54:00:12:34:56
smc911x: detected LAN9118 controller
smc911x: phy initialized
smc911x: MAC 52:54:00:12:34:56
Using smc911x-0 device
TFTP from server 172.16.157.100; our IP address is 172.16.157.101
Filename 'vexpress-v2p-ca9.dtb'.
Load address: 0x62000000
Loading: #
         3.4 MiB/s
done
Bytes transferred = 14143 (373f hex)
smc911x: MAC 52:54:00:12:34:56
=> bootz 0x61000000 - 0x62000000
Kernel image @ 0x61000000 [ 0x000000 - 0x472e78 ]
## Flattened Device Tree blob at 62000000
   Booting using the fdt blob at 0x62000000
   Loading Device Tree to 7fe6e000, end 7fe7473e ... OK

Starting kernel ...

Booting Linux on physical CPU 0x0
Linux version 5.5.5 (bamboo@bbtechlab) (gcc version 9.2.0 (crosstool-NG 1.24.0.105_5659366)) #1 SMP Thu Mar 4 12:33:18 +07 2021
CPU: ARMv7 Processor [410fc090] revision 0 (ARMv7), cr=10c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
OF: fdt: Machine model: V2P-CA9
OF: fdt: Ignoring memory block 0x80000000 - 0x80000004
Memory policy: Data cache writeback
Reserved memory: created DMA memory pool at 0x4c000000, size 8 MiB
OF: reserved mem: initialized node vram@4c000000, compatible id shared-dma-pool
cma: Reserved 16 MiB at 0x7ec00000
CPU: All CPU(s) started in SVC mode.
percpu: Embedded 19 pages/cpu s45644 r8192 d23988 u77824
Built 1 zonelists, mobility grouping on.  Total pages: 130048
Kernel command line: root=/dev/nfs rdinit=/sbin/init earlyprintk=serial,ttyS0 console=ttyAMA0 ip=172.16.157.101:::::eth0 nfsroot=172.16.157.100:/home/bamboo/workspace/nfsroot/qemu_arm
printk: log_buf_len individual max cpu contribution: 4096 bytes
printk: log_buf_len total cpu_extra contributions: 12288 bytes
printk: log_buf_len min size: 16384 bytes
printk: log_buf_len: 32768 bytes
printk: early log buf free: 14656(89%)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
mem auto-init: stack:off, heap alloc:off, heap free:off
Memory: 492136K/524288K available (7168K kernel code, 429K rwdata, 1708K rodata, 1024K init, 155K bss, 15768K reserved, 16384K cma-reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
rcu: Hierarchical RCU implementation.
rcu:    RCU event tracing is enabled.
rcu:    RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
GIC CPU mask not found - kernel will fail to boot.
GIC CPU mask not found - kernel will fail to boot.
L2C: platform modifies aux control register: 0x02020000 -> 0x02420000
L2C: DT/platform modifies aux control register: 0x02020000 -> 0x02420000
L2C-310 enabling early BRESP for Cortex-A9
L2C-310 full line of zeros enabled for Cortex-A9
L2C-310 dynamic clock gating disabled, standby mode disabled
L2C-310 cache controller enabled, 8 ways, 128 kB
L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x46420001
random: get_random_bytes called from start_kernel+0x310/0x4c0 with crng_init=0
sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
Failed to initialize '/smb@4000000/motherboard/iofpga@7,00000000/timer@12000': -22
smp_twd: clock not found -2
Console: colour dummy device 80x30
Calibrating local timer... 96.90MHz.
Calibrating delay loop... 910.13 BogoMIPS (lpj=4550656)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
CPU: Testing write buffer coherency: ok
CPU0: Spectre v2: using BPIALL workaround
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x60100000 - 0x60100060
rcu: Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
smp: Brought up 1 node, 1 CPU
SMP: Total of 1 processors activated (910.13 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 0
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
cpuidle: using governor ladder
hw-breakpoint: debug architecture 0x4 unsupported.
Serial: AMBA PL011 UART driver
10009000.uart: ttyAMA0 at MMIO 0x10009000 (irq = 25, base_baud = 0) is a PL011 rev1
printk: console [ttyAMA0] enabled
1000a000.uart: ttyAMA1 at MMIO 0x1000a000 (irq = 26, base_baud = 0) is a PL011 rev1
1000b000.uart: ttyAMA2 at MMIO 0x1000b000 (irq = 27, base_baud = 0) is a PL011 rev1
1000c000.uart: ttyAMA3 at MMIO 0x1000c000 (irq = 28, base_baud = 0) is a PL011 rev1
OF: amba_device_add() failed (-19) for /smb@4000000/motherboard/iofpga@7,00000000/wdt@f000
OF: amba_device_add() failed (-19) for /memory-controller@100e0000
OF: amba_device_add() failed (-19) for /memory-controller@100e1000
OF: amba_device_add() failed (-19) for /watchdog@100e5000
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Advanced Linux Sound Architecture Driver Initialized.
clocksource: Switched to clocksource arm,sp804
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes, linear)
TCP established hash table entries: 4096 (order: 2, 16384 bytes, linear)
TCP bind hash table entries: 4096 (order: 3, 32768 bytes, linear)
TCP: Hash tables configured (established 4096 bind 4096)
UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, linear)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
hw perfevents: enabled with armv7_cortex_a9 PMU driver, 1 counters available
workingset: timestamp_bits=30 max_order=17 bucket_order=0
squashfs: version 4.0 (2009/01/31) Phillip Lougher
jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
9p: Installing v9fs 9p2000 file system support
io scheduler mq-deadline registered
io scheduler kyber registered
drm-clcd-pl111 1001f000.clcd: assigned reserved memory node vram@4c000000
drm-clcd-pl111 1001f000.clcd: using device-specific reserved memory
drm-clcd-pl111 1001f000.clcd: initializing Versatile Express PL111
drm-clcd-pl111 1001f000.clcd: core tile graphics present
drm-clcd-pl111 1001f000.clcd: this device will be deactivated
Error: Driver 'vexpress-muxfpga' is already registered, aborting...
drm-clcd-pl111 10020000.clcd: initializing Versatile Express PL111
drm-clcd-pl111 10020000.clcd: DVI muxed to daughterboard 1 (core tile) CLCD
physmap-flash 40000000.flash: physmap platform flash device: [mem 0x40000000-0x43ffffff]
40000000.flash: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 0x000000 Chip ID 0x000000
Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
physmap-flash 40000000.flash: physmap platform flash device: [mem 0x44000000-0x47ffffff]
40000000.flash: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 0x000000 Chip ID 0x000000
Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
Concatenating MTD devices:
(0): "40000000.flash"
(1): "40000000.flash"
into device "40000000.flash"
physmap-flash 48000000.psram: physmap platform flash device: [mem 0x48000000-0x49ffffff]
libphy: Fixed MDIO Bus: probed
libphy: smsc911x-mdio: probed
smsc911x 4e000000.ethernet eth0: MAC Address: 52:54:00:12:34:56
isp1760 4f000000.usb: bus width: 32, oc: digital
isp1760 4f000000.usb: NXP ISP1760 USB Host Controller
isp1760 4f000000.usb: new USB bus registered, assigned bus number 1
isp1760 4f000000.usb: Scratch test failed.
isp1760 4f000000.usb: can't setup: -19
isp1760 4f000000.usb: USB bus 1 deregistered
usbcore: registered new interface driver usb-storage
rtc-pl031 10017000.rtc: registered as rtc0
mmci-pl18x 10005000.mmci: Got CD GPIO
mmci-pl18x 10005000.mmci: Got WP GPIO
mmci-pl18x 10005000.mmci: mmc0: PL181 manf 41 rev0 at 0x10005000 irq 21,22 (pio)
ledtrig-cpu: registered to indicate activity on CPUs
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
aaci-pl041 10004000.aaci: ARM AC'97 Interface PL041 rev0 at 0x10004000, irq 20
aaci-pl041 10004000.aaci: FIFO 512 entries
oprofile: using arm/armv7-ca9
NET: Registered protocol family 17
9pnet: Installing 9P2000 support
Registering SWP/SWPB emulation handler
Error: Driver 'vexpress-muxfpga' is already registered, aborting...
drm-clcd-pl111 10020000.clcd: initializing Versatile Express PL111
drm-clcd-pl111 10020000.clcd: DVI muxed to daughterboard 1 (core tile) CLCD
input: AT Raw Set 2 keyboard as /devices/platform/smb@4000000/smb@4000000:motherboard/smb@4000000:motherboard:iofpga@7,00000000/10006000.kmi/serio0/input/input0
Error: Driver 'vexpress-muxfpga' is already registered, aborting...
drm-clcd-pl111 10020000.clcd: initializing Versatile Express PL111
drm-clcd-pl111 10020000.clcd: DVI muxed to daughterboard 1 (core tile) CLCD
Error: Driver 'vexpress-muxfpga' is already registered, aborting...
drm-clcd-pl111 10020000.clcd: initializing Versatile Express PL111
drm-clcd-pl111 10020000.clcd: DVI muxed to daughterboard 1 (core tile) CLCD
rtc-pl031 10017000.rtc: setting system clock to 2021-03-13T06:02:11 UTC (1615615331)
input: ImExPS/2 Generic Explorer Mouse as /devices/platform/smb@4000000/smb@4000000:motherboard/smb@4000000:motherboard:iofpga@7,00000000/10007000.kmi/serio1/input/input2
Generic PHY 4e000000.ethernet-ffffffff:01: attached PHY driver [Generic PHY] (mii_bus:phy_addr=4e000000.ethernet-ffffffff:01, irq=POLL)
smsc911x 4e000000.ethernet eth0: SMSC911x/921x identified at 0xa08c0000, IRQ: 18
Error: Driver 'vexpress-muxfpga' is already registered, aborting...
drm-clcd-pl111 10020000.clcd: initializing Versatile Express PL111
drm-clcd-pl111 10020000.clcd: DVI muxed to daughterboard 1 (core tile) CLCD
IP-Config: Guessing netmask 255.255.0.0
IP-Config: Complete:
     device=eth0, hwaddr=52:54:00:12:34:56, ipaddr=172.16.157.101, mask=255.255.0.0, gw=255.255.255.255
     host=172.16.157.101, domain=, nis-domain=(none)
     bootserver=255.255.255.255, rootserver=172.16.157.100, rootpath=
ALSA device list:
  #0: ARM AC'97 Interface PL041 rev0 at 0x10004000, irq 20
VFS: Mounted root (nfs filesystem) readonly on device 0:13.
Freeing unused kernel memory: 1024K
Run /sbin/init as init process
/ # 
/ # uname -a
Linux 172.16.157.101 5.5.5 #1 SMP Thu Mar 4 12:33:18 +07 2021 armv7l GNU/Linux
/ # hostname
172.16.157.101
/ # ls -al /
drwxrwxr-x    7 1000     1000          4096 Mar 13 05:52 .
drwxrwxr-x    7 1000     1000          4096 Mar 13 05:52 ..
drwxrwxr-x    2 1000     1000          4096 Mar 12 17:36 bin
drwxrwxr-x    3 1000     1000          4096 Mar 12 17:36 etc
lrwxrwxrwx    1 1000     1000            11 Mar 12 17:36 linuxrc -> bin/busybox
drwxrwxr-x    2 1000     1000          4096 Mar 12 17:36 sbin
drwxrwxr-x    4 1000     1000          4096 Mar 12 17:36 usr
```
If we want the U-BOOT load kernel & mount rootfs automatically, we should apply below patch for U-BOOT
```
diff --git a/qemu_labs/opensource/u-boot-2020.10/include/configs/vexpress_common.h b/qemu_labs/opensource/u-boot-2020.10/include/configs/vexpress_common.h
index b131480..82f9a16 100644
--- a/qemu_labs/opensource/u-boot-2020.10/include/configs/vexpress_common.h
+++ b/qemu_labs/opensource/u-boot-2020.10/include/configs/vexpress_common.h
@@ -238,4 +238,11 @@
 /* Monitor Command Prompt */
 #define CONFIG_SYS_CBSIZE              512     /* Console I/O Buffer Size */
 
+/* Set default network interface for booting TFTP/NFS */
+#define CONFIG_IPADDR   172.16.157.101
+#define CONFIG_NETMASK  255.255.255.0
+#define CONFIG_SERVERIP 172.16.157.100
+#define CONFIG_GATEWAYIP 172.16.157.1
+
+#define CONFIG_BOOTCOMMAND "tftp 0x61000000 zImage; tftp 0x62000000 vexpress-v2p-ca9.dtb; setenv bootargs 'root=/dev/nfs rdinit=/sbin/init earlyprintk=serial,ttyS0 console=ttyAMA0 ip=172.16.157.101:::::eth0 nfsroot=172.16.157.100:/home/bamboo/workspace/nfsroot/qemu_arm'; bootz 0x61000000 - 0x62000000"
 #endif /* VEXPRESS_COMMON_H */
```
### Verify hello world application
We got hello_staic binary from [lab1_toolchains](lab1_toolchains_crosstool-ng.md), copy to nfsroot
```
$ mkdir -p ~/workspace/nfsroot/qemu_arm/home
$ cp lab1_toolchains/lab1_hello_static ~/workspace/nfsroot/qemu_arm/home/
``
Back to ARM QEMU, we excute hello world application
```
/ # ls -al /home
total 124
drwxrwxr-x    2 1000     1000          4096 Mar 13 05:52 .
drwxrwxr-x    7 1000     1000          4096 Mar 13 05:52 ..
-rwxrwxr-x    1 1000     1000        117940 Mar 13 05:52 lab1_hello_static
/ # cd /home
/home # ./lab1_hello_static 
Hello World - VQDO!
/home # 
```

## References
* https://ubuntu.com/server/docs/network-configuration
* https://vitux.com/ubuntu-network-configuration/
* https://en.wikibooks.org/wiki/QEMU/Networking#TAP/TUN_device
