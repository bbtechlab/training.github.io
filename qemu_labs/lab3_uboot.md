# Cross Compiling Bootloader - U-Boot for QEMU ARM emulator
We need to complete [lab1_toolchains](lab1_toolchains_crosstool-ng.md) to generate the ARM cross toolchain which uses for compling kernel in this lab.

For this lab, we will decrible steps by steps to cross compile U-BOOT for ARM Versatile Express Cortex-A9 that is supported by QEMU ARM Emulator.
* Download U-Boot v2020.10 here,https://github.com/u-boot/u-boot/releases

## Prerequisite

Host environment is required for this lab consists of
* Ubuntu 16_O4LTS_x64, for mines:
```
$ cat /proc/version
Linux version 4.15.0-136-generic (buildd@lcy01-amd64-014) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.12)) #140~16.04.1-Ubuntu SMP Wed Feb 3 18:51:03 UTC 2021
```
* $ sudo apt install qemu-user qemu-system-arm build-essential git autoconf bison flex texinfo help2man gawk libtool-bin libncurses5-dev

## Steps to cross compile U-BOOT for QEMU ARM Coretex A9
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
## Testing U-BOOT with QEMU ARM
```
$ qemu-system-arm -M vexpress-a9 -m 128M -nographic -kernel u-boot
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