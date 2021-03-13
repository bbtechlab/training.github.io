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
    * Toolchain path: use the toolchain you built: /opt/toolchains/arm-training-linux-uclibcgnueabi (replace <this path> by your actual path)
    * External toolchain gcc version: 9.x
    * External toolchain kernel headers series: 5.5.x
    * External toolchain C library: uClibc/uClibc-ng
    * We must tell Buildroot about our toolchain configuration, so select Toolchain has WCHAR support?, Toolchain has SSP support? and Toolchain has C++ support?. Buildroot will check these parameters anyway.
* System configuration
    * /dev management (Static using device table)
    * (system/device_table_dev.txt)
* Target packages
    * Keep BusyBox (default version) and keep the Busybox configuration proposed by Buildroot
    * Audio and video applications
        * Select alsa-utils
        * Select alsamixer
        * Select aplay (to play a WAV file as long as the OGG file doesn’t play properly).
        * Select vorbis-tools
* Filesystem images
    Select tar the root filesystem: Compression method (gzip)

The output locates in  buildroot-2021.02/output/images/rootfs.tar.gz
   
## Testing an embedded linux that is built by buildroot with QEMU ARM
Please refer to [lab3_uboot](lab3_uboot.md) to complete setup the environment between ARM QEMU and Virtual Host Machine.

Copy the rootfs,tar to nfsroot and verify the booting system
* Got U_BOOT from [lab3_uboot](lab3_uboot.md)
* Got Kernel & DTB from [lab2_kernel](lab2_kernel.md)
```
$ cd ~/workspace/nfsroot/qemu_arm/
$ tar -xvf ~/workspace/study/bbtechlab_training/qemu_labs/lab4_buildroot/vexpress/rootfs.tar.gz
$ cd ~/workspace/study/bbtechlab_training/qemu_labs/lab3_uboot/
$ ./lab3_uboot_run.sh
U-Boot 2020.10 (Mar 12 2021 - 21:27:22 -0800)

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
	 7.2 MiB/s
done
Bytes transferred = 4664952 (472e78 hex)
smc911x: MAC 52:54:00:12:34:56
smc911x: MAC 52:54:00:12:34:56
smc911x: detected LAN9118 controller
smc911x: phy initialized
smc911x: MAC 52:54:00:12:34:56
Using smc911x-0 device
TFTP from server 172.16.157.100; our IP address is 172.16.157.101
Filename 'vexpress-v2p-ca9.dtb'.
Load address: 0x62000000
Loading: #
	 2.7 MiB/s
done
Bytes transferred = 14143 (373f hex)
smc911x: MAC 52:54:00:12:34:56
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
rcu: 	RCU event tracing is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
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
Calibrating local timer... 93.87MHz.
Calibrating delay loop... 715.16 BogoMIPS (lpj=3575808)
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
SMP: Total of 1 processors activated (715.16 BogoMIPS).
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
input: AT Raw Set 2 keyboard as /devices/platform/smb@4000000/smb@4000000:motherboard/smb@4000000:motherboard:iofpga@7,00000000/10006000.kmi/serio0/input/input0
Error: Driver 'vexpress-muxfpga' is already registered, aborting...
drm-clcd-pl111 10020000.clcd: initializing Versatile Express PL111
drm-clcd-pl111 10020000.clcd: DVI muxed to daughterboard 1 (core tile) CLCD
Error: Driver 'vexpress-muxfpga' is already registered, aborting...
drm-clcd-pl111 10020000.clcd: initializing Versatile Express PL111
drm-clcd-pl111 10020000.clcd: DVI muxed to daughterboard 1 (core tile) CLCD
rtc-pl031 10017000.rtc: setting system clock to 2021-03-13T17:29:49 UTC (1615656589)
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
random: init: uninitialized urandom read (4 bytes read)
random: mount: uninitialized urandom read (4 bytes read)
random: mount: uninitialized urandom read (4 bytes read)
urandom_read: 2 callbacks suppressed
random: swapon: uninitialized urandom read (4 bytes read)
random: ln: uninitialized urandom read (4 bytes read)
random: ln: uninitialized urandom read (4 bytes read)
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Saving random seed: OK
Starting network: ip: RTNETLINK answers: File exists
FAIL

Welcome to BBTECHLAB - Enjoy !
bbtechlab login: root

# cat /proc/version 
Linux version 5.5.5 (bamboo@bbtechlab) (gcc version 9.2.0 (crosstool-NG 1.24.0.105_5659366)) #1 SMP Thu Mar 4 12:33:18 +07 2021
# uname -a
Linux bbtechlab 5.5.5 #1 SMP Thu Mar 4 12:33:18 +07 2021 armv7l GNU/Linux
# 
```
## References,
* [Bootlin QEMU labs](https://github.com/bootlin/training-materials)
* [Installing and Configuring TFTP Server on Ubuntu](https://linuxhint.com/install_tftp_server_ubuntu/)
* https://wiki.qemu.org/Documentation/Networking/NAT
