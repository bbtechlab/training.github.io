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
Please refer to [lab3_uboot](lab3_uboot.md) to complete setup the environment between ARM QEMU and Virtual Host Machine.

Copy the rootfs,tar to nfsroot and verify the booting system
* Got U_BOOT from [lab3_uboot](lab3_uboot.md)
* Got Kernel & DTB from [lab2_kernel](lab2_kernel.md)
```
$ cd ~/workspace/nfsroot/qemu_arm/
$ tar -xvf ~/workspace/study/bbtechlab_training/qemu_labs/lab4_buildroot/vexpress/rootfs.tar
$ cd ~/workspace/study/bbtechlab_training/qemu_labs/lab3_uboot/
$ ./lab3_uboot_run.sh 
```
## References,
* [Bootlin QEMU labs](https://github.com/bootlin/training-materials)
* [Installing and Configuring TFTP Server on Ubuntu](https://linuxhint.com/install_tftp_server_ubuntu/)
* https://wiki.qemu.org/Documentation/Networking/NAT
