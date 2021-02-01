# Cross Compiling Linux kernel for QEMU ARM emulator
We need to complete [lab1_toolchains](lab1_toolchains.md) to generate the ARM cross toolchain which uses for compling kernel in this lab.

For this lab, we will decrible steps by steps for cross compiling kernel for ARM Versatile Express Cortex-A15 that is supported by QEMU ARM Emulator.
* Kernel header 5.9.x
* Target device: vexpress-a15 (ARM Versatile Express for Cortex-A15)

## Prerequisite

Host environment is required for this lab consists of
* Ubuntu 14_O4_05LTS_x64
* $ sudo apt install qemu-user qemu-system-arm build-essential git autoconf bison flex texinfo help2man gawk libtool-bin libncurses5-dev

## Cross compiling kernel for ARM
Install ARM Cross toolchain
```
$ export PATH=/opt/toolchains/arm-buildroot-linux-uclibcgnueabihf/bin/:$PATH
$ export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/toolchains/arm-buildroot-linux-uclibcgnueabihf/arm-buildroot-linux-uclibcgnueabihf/sysroot:/opt/toolchains/arm-buildroot-linux-uclibcgnueabihf/lib/
```

Download kernel source from kernel.org
```
$ wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.9.16.tar.xz
$ tar -xvf linux-5.9.16.tar.xz
```
Make kernel configuration for ARM Versatile Express Cortex-A15
```
$ cd linux-5.9.16
$ make ARCH=arm vexpress_defconfig
$ make ARCH=arm CROSS_COMPILE=arm-buildroot-linux-uclibcgnueabihf- menuconfig
```

![General setup](images/lab2_kernel_1.png)
![Boot options](images/lab2_kernel_2.png)

Compiling
```
$ make ARCH=arm CROSS_COMPILE=arm-buildroot-linux-uclibcgnueabihf- all
...
  AS      arch/arm/boot/compressed/bswapsdi2.o
  LD      arch/arm/boot/compressed/vmlinux
  OBJCOPY arch/arm/boot/zImage
  Kernel: arch/arm/boot/zImage is ready
  DTC     arch/arm/boot/dts/vexpress-v2p-ca5s.dtb
  DTC     arch/arm/boot/dts/vexpress-v2p-ca9.dtb
  DTC     arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dtb
  DTC     arch/arm/boot/dts/vexpress-v2p-ca15_a7.dtb
  MODPOST Module.symvers
```
Finally we have the ouput of kernel image locates in
```
[09:32 AM]vqdo@vietnam:~/work/bbtechlab_training/qemu_labs/linux-5.9.16$ tree -L 1 arch/arm/boot/
arch/arm/boot/
|-- bootp
|-- compressed
|-- deflate_xip_data.sh
|-- dts
|-- Image
|-- install.sh
|-- Makefile
`-- zImage
```
To load kernel into QEMU ARM, we need device tree as well. With this labs, device file tree files also is gernerated during the cross conmpile kernel, it locates in
```
[09:40 AM]vqdo@vietnam:~/work/bbtechlab_training/qemu_labs/linux-5.9.16$ ls -al arch/arm/boot/dts/vexpress-v2p-ca15_a7.dtb
-rw-rw-r-- 1 vqdo vqdo 18772 Jan 10 09:30 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dtb
```
Now, we try to verify kernel zImage using QEMU ARM emulator by using command as below
```
$ cd linux-5.9.16
$ qemu-system-arm -M vexpress-a15 -m 512M -dtb arch/arm/boot/dts/vexpress-v2p-ca15_a7.dtb -kernel arch/arm/boot/zImage -nographic
```
We got the result like below, however it is stopping because there is not root filesystem "Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)" 
```
.....
enirq: Setting trigger mode 4 for irq 41 failed (gic_set_type+0x0/0x94)
drm-clcd-pl111 1c1f0000.clcd: pl111_amba_probe failed irq -22
drm-clcd-pl111: probe of 1c1f0000.clcd failed with error -22
ALSA device list:
  #0: ARM AC'97 Interface PL041 rev0 at 0x1c040000, irq 29
genirq: Setting trigger mode 4 for irq 34 failed (gic_set_type+0x0/0x94)
VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
Please append a correct "root=" boot option; here are the available partitions:
1f00           32768 mtdblock0 
 (driver?)
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.9.16 #1
Hardware name: ARM-Versatile Express
[<8010ebc0>] (unwind_backtrace) from [<8010a834>] (show_stack+0x10/0x14)
[<8010a834>] (show_stack) from [<807815ec>] (dump_stack+0x98/0xac)
[<807815ec>] (dump_stack) from [<8077dc64>] (panic+0xf8/0x2f8)
[<8077dc64>] (panic) from [<80a01518>] (mount_block_root+0x1d0/0x248)
[<80a01518>] (mount_block_root) from [<80a0168c>] (mount_root+0xfc/0x104)
[<80a0168c>] (mount_root) from [<80a017e8>] (prepare_namespace+0x154/0x190)
[<80a017e8>] (prepare_namespace) from [<8078557c>] (kernel_init+0x8/0x118)
[<8078557c>] (kernel_init) from [<80100148>] (ret_from_fork+0x14/0x2c)
Exception stack(0x86893fb0 to 0x86893ff8)
3fa0:                                     00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0) ]---
```
## Cross Compiling mini rootfs using BusyBox for ARM
We already cross compiled the Kernel, now we continue to build a mini rootfs for this lab. Please following the steps are below:

Step 1: Download & compile
```
$ wget https://busybox.net/downloads/busybox-1.32.0.tar.bz2
$ tar xjvf busybox-1.32.0.tar.bz2
$ cd busybox-1.32.0
$ export ARCH=arm
$ export CROSS_COMPILE=arm-buildroot-linux-uclibcgnueabihf-
$ make defconfig && make menuconfig
```
The option to compile Busybox as a static executable, so that we don’t have to copy the dynamic libraries inside the root filesystem. The setting can be found in “Busybox Settings --> Build Options“. Also, select what utilities you want embedded in Busybox.
![busybox config](images/lab2_kernel_3.png)
```
$ make install
.....
  ./_install//usr/sbin/ubirsvol -> ../../bin/busybox
  ./_install//usr/sbin/ubiupdatevol -> ../../bin/busybox
  ./_install//usr/sbin/udhcpd -> ../../bin/busybox
--------------------------------------------------
You will probably need to make your busybox binary
setuid root to ensure all configured applets will
work properly.
--------------------------------------------------
[11:12 PM]vqdo@vietnam:~/work/bbtechlab_training/qemu_labs/busybox-1.32.0$ 
```
When the cross compile finish, the output of folder "_install" is created and it contains a hierachy  of files & directories are known rootfs. It actually are busybox utilies binaries.   
```
[11:12 PM]vqdo@vietnam:~/work/bbtechlab_training/qemu_labs/busybox-1.32.0$ ls -al _install/
total 20
drwxrwxr-x  5 vqdo vqdo 4096 Th01 10 23:12 .
drwxr-xr-x 36 vqdo vqdo 4096 Th01 10 23:12 ..
drwxrwxr-x  2 vqdo vqdo 4096 Th01 10 23:12 bin
lrwxrwxrwx  1 vqdo vqdo   11 Th01 10 23:12 linuxrc -> bin/busybox
drwxrwxr-x  2 vqdo vqdo 4096 Th01 10 23:12 sbin
drwxrwxr-x  4 vqdo vqdo 4096 Th01 10 23:12 usr
```
However, "_install" is generated by busybox is not enough, we need manually to create more specifical files are at least required by Kernel. Example, let's see [linux/main.c](https://github.com/torvalds/linux/blob/master/init/main.c)
```
	if (!try_to_run_init_process("/sbin/init") ||
	    !try_to_run_init_process("/etc/init") ||
	    !try_to_run_init_process("/bin/init") ||
	    !try_to_run_init_process("/bin/sh"))
		return 0;
```
Kernel init process will try to start /sbin/init or /etc/init .... firstly.
```
	$ cd _install
	$ mkdir -p {bin,dev,sbin,etc/init.d,proc,sys/kernel/debug,usr/{bin,sbin},lib,lib64,mnt/root,root}
	$ vim ./etc/init.d/rcS
	mount -t proc none /proc
	mount -t sysfs none /sys
	mount -t debugfs none /sys/kernel/debug
	exec /bin/sh
	$ chmod a+x ./etc/init.d/rcS
```
We copied hello_static application from [lab1_toolchains](lab1_toolchains.md) into _install as well.
```
$ cp hello_static _install/root/
```

Finally, we compress "_install" folder to rootfs formated initramfs by using cpio tool.
```
$ [11:51 PM]vqdo@vietnam:~/work/bbtechlab_training/qemu_labs/busybox-1.32.0/_install$ ls -al
total 52
drwxrwxr-x 13 vqdo vqdo 4096 Th01 10 23:32 .
drwxr-xr-x 36 vqdo vqdo 4096 Th01 10 23:12 ..
drwxrwxr-x  2 vqdo vqdo 4096 Th01 10 23:12 bin
drwxrwxr-x  2 vqdo vqdo 4096 Th01 10 23:32 dev
drwxrwxr-x  3 vqdo vqdo 4096 Th01 10 23:32 etc
drwxrwxr-x  2 vqdo vqdo 4096 Th01 10 23:32 lib
drwxrwxr-x  2 vqdo vqdo 4096 Th01 10 23:32 lib64
lrwxrwxrwx  1 vqdo vqdo   11 Th01 10 23:12 linuxrc -> bin/busybox
drwxrwxr-x  3 vqdo vqdo 4096 Th01 10 23:32 mnt
drwxrwxr-x  2 vqdo vqdo 4096 Th01 10 23:32 proc
drwxrwxr-x  2 vqdo vqdo 4096 Th01 10 23:51 root
drwxrwxr-x  2 vqdo vqdo 4096 Th01 10 23:12 sbin
drwxrwxr-x  3 vqdo vqdo 4096 Th01 10 23:32 sys
drwxrwxr-x  4 vqdo vqdo 4096 Th01 10 23:12 usr
$ find . | cpio -o --format=newc > ../rootfs.img
```
## Loading Linux with BusyBox on ARM QEMU
Create lab2_kernel_run_qemu_arm.sh
```
#!/bin/sh

DTB_TARGET=$1
KER_TARGET=$2
ROO_TARGET=$3

if [ "$#" -ne 3 ]; then
    echo "Usage: lab2_kernel_run_qemu_arm.sh [dtb] [kernel] [rootfs]"
    exit 1
fi

qemu-system-arm -M vexpress-a15 -m 512M \
    -dtb ${DTB_TARGET} \
    -kernel ${KER_TARGET} \
    -initrd ${ROO_TARGET} -nographic \
    -append "root=/dev/ram rdinit=/sbin/init earlyprintk=serial,ttyS0 console=ttyAMA0"
``` 
Run command to load zImage & rootfs on ARM QEMU
```
[12:06 AM]vqdo@vietnam:~/work/bbtechlab_training/qemu_labs$ ./lab2_kernel_run_qemu_arm.sh linux-5.9.16/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dtb linux-5.9.16/arch/arm/boot/zImage busybox-1.32.0/rootfs.img
```
## References
* https://gist.github.com/luk6xff/9f8d2520530a823944355e59343eadc1
* https://kipalog.com/posts/Build-va-chay-mot-ban-Linux-don-gian-tren-QEMU-ARM
* https://jasonblog.github.io/note/arm_emulation/compiling_linux_kernel_for_qemu_arm_emulator.html
* https://balau82.wordpress.com/2010/03/22/compiling-linux-kernel-for-qemu-arm-emulator/
* https://www.centennialsoftwaresolutions.com/post/build-the-linux-kernel-and-busybox-for-arm-and-run-them-on-qemu