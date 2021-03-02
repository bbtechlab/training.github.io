# Building a cross-compiling ARM toolchain

The compiler toolchains are part of the basic tool sets (compiler, linker, assembler, etc.) that produce machine code for a CPU instruction set (x86, ARM, etc.) from your programming code.

When working with embedded system, we need a cross compiler toolchain. it is used to compile your programs on your host machine's CPU such as x86 laptop/ or desktop computer for a target's CPU architecture. For example, if you have a cross toolchain for ARM, you will compile your programms on Laptop and then run it on target ARM device.    

* You can refer to [toolchains](https://elinux.org/Toolchains) in detail.
* There are severals to get a toolchains: pre-compiled toolchains (CodeSourcery, Bootlin, Liano)  or build your own toolchain by using [buildroot](https://buildroot.org/), [crosstool-ng](https://crosstool-ng.github.io/docs/introduction/), etc... 
    * [Crosstool-NG](https://crosstool-ng.github.io/docs/introduction/) is a tool that builds cross toolchains, it build the standard libraries.
    * [Buildroot](https://buildroot.org/), it is not only build a cross toolchains but also an complete root filesystem(kernel, bootloader, rootfs, etc.). Not like Crosstool-NG, it will include all the shared libraries are needed into the root filesystem.

With this lab, I describe steps by steps to build a toolchain using the [Crosstool-NG](https://crosstool-ng.github.io/docs/introduction/).

## Prerequisite

Host environment is required for this lab consists of
* Host machine is Ubuntu 16_O4_05LTS_x64, below is my hostname
```
[02:44 PM]bamboo@bbtechlab~/workspace/bbtechlab_training/qemu_labs
$ cat /proc/version
Linux version 4.15.0-112-generic (buildd@lcy01-amd64-021) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.12)) #113~16.04.1-Ubuntu SMP Fri Jul 10 04:37:08 UTC 2020
```
* $ sudo apt install qemu-user qemu-system-arm build-essential git autoconf bison flex texinfo help2man gawk libtool-bin libncurses5-dev

## Steps by steps to build a cross-compile toolchain for ARM 

We will build a cross-compile toolchain for ARM Versatile Express that is suppoerted by QEMU ARM emulator.
```
[12:02 AM]vqdo@vietnam:~$ qemu-system-arm -machine help
Supported machines are:
versatileab          ARM Versatile/AB (ARM926EJ-S)
versatilepb          ARM Versatile/PB (ARM926EJ-S)
lm3s811evb           Stellaris LM3S811EVB
z2                   Zipit Z2 (PXA27x)
connex               Gumstix Connex (PXA255)
sx1                  Siemens SX1 (OMAP310) V2
realview-eb          ARM RealView Emulation Baseboard (ARM926EJ-S)
cubieboard           cubietech cubieboard
vexpress-a9          ARM Versatile Express for Cortex-A9
lm3s6965evb          Stellaris LM3S6965EVB
realview-pbx-a9      ARM RealView Platform Baseboard Explore for Cortex-A9
musicpal             Marvell 88w8618 / MusicPal (ARM926EJ-S)
mainstone            Mainstone II (PXA27x)
terrier              Terrier PDA (PXA270)
n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)
xilinx-zynq-a9       Xilinx Zynq Platform Baseboard for Cortex-A9
nuri                 Samsung NURI board (Exynos4210)
realview-eb-mpcore   ARM RealView Emulation Baseboard (ARM11MPCore)
verdex               Gumstix Verdex (PXA270)
spitz                Spitz PDA (PXA270)
canon-a1100          Canon PowerShot A1100 IS
akita                Akita PDA (PXA270)
smdkc210             Samsung SMDKC210 board (Exynos4210)
integratorcp         ARM Integrator/CP (ARM926EJ-S)
sx1-v1               Siemens SX1 (OMAP310) V1
kzm                  ARM KZM Emulation Baseboard (ARM1136)
highbank             Calxeda Highbank (ECX-1000)
n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
collie               Collie PDA (SA-1110)
realview-pb-a8       ARM RealView Platform Baseboard for Cortex-A8
vexpress-a15         ARM Versatile Express for Cortex-A15
none                 empty machine
cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)
tosa                 Tosa PDA (PXA255)
midway               Calxeda Midway (ECX-2000)
virt                 ARM Virtual Machine
borzoi               Borzoi PDA (PXA270)
```

### Download
Let’s download the sources of Crosstool-ng
```
$ git clone https://github.com/crosstool-ng/crosstool-ng.git
$ cd crosstool-ng/
$ git checkout 5659366b
```
### Building and installing Crosstool-ng
Firstly, generate ct-ng utility
```
$ ./bootstrap
$ ./configure --enable-local
$ make
$ ./ct-ng help # get Crosstool-ng help by running
```
Secondary, need customize cross toolchain for ARM target
```
$ ./ct-ng menuconfig
```
In Path and misc options:
* Change Maximum log level to see to DEBUG (look for LOG_DEBUG in the interface, using
the / key) so that we can have more details on what happened during the build in case
something went wrong.

In Target options:
* Target Architecture (ARM)

In Operating System:
* Set Target OS to Linux
* Version of linux (5.5.5)
* Check installed headers

In Toolchain options:
* Set Tuple's vendor string (TARGET_VENDOR) to training.
* Set Tuple's alias (TARGET_ALIAS) to arm-linux. This way, we will be able to use the compiler as arm-linux-gcc instead of arm-training-linux-uclibcgnueabi-gcc

In C-library:
* If not set yet, set C library to uClibc (LIBC_UCLIBC)
* Keep the default version that is proposed
* If needed, enable Add support for IPv6 (LIBC_UCLIBC_IPV6)2, Add support for WCHAR
(LIBC_UCLIBC_WCHAR) and Support stack smashing protection (SSP) (LIBC_UCLIBC_HAS_
SSP)

In C compiler:
* Make sure that C++ (CC_LANG_CXX) is enabled

### Compile 
```
$ ./ct-ng build
$ ls -al ${HOME}/x-tools/
total 36
drwxr-xr-x  9 vqdo vqdo 4096 Jan  9 00:39 .
drwxrwxr-x  6 vqdo vqdo 4096 Jan  9 01:03 ..
drwxr-xr-x  6 vqdo vqdo 4096 Jan  9 00:55 arm-buildroot-linux-uclibcgnueabihf
drwxr-xr-x  2 vqdo vqdo 4096 Jan  9 01:03 bin
drwxr-xr-x  3 vqdo vqdo 4096 Jan  9 01:03 etc
drwxr-xr-x 10 vqdo vqdo 4096 Jan  9 01:03 include
drwxr-xr-x  4 vqdo vqdo 4096 Jan  9 00:58 lib
lrwxrwxrwx  1 vqdo vqdo    3 Jan  9 00:24 lib64 -> lib
drwxr-xr-x  3 vqdo vqdo 4096 Jan  9 00:39 libexec
drwxr-xr-x 14 vqdo vqdo 4096 Jan  9 01:03 share
lrwxrwxrwx  1 vqdo vqdo    1 Jan  9 00:24 usr -> .
```
### Known issues

Maybe you got the failure of downloading a source chive on the Internet, you will need work-around, for example in my cases: I have faced to download isl-0.22 pakage,
```
[DEBUG]    ==> Return status 4
[DEBUG]    Not at this location: "http://isl.gforge.inria.fr/isl-0.22.tar.gz"
[ERROR]    isl: download failed
[ERROR]  
[ERROR]  >>
[ERROR]  >>  Build failed in step 'Retrieving needed toolchain components' tarballs'
[ERROR]  >>        called in step '(top-level)'
[ERROR]  >>
[ERROR]  >>  Error happened in: CT_Abort[scripts/functions@487]
[ERROR]  >>        called from: CT_DoFetch[scripts/functions@2125]
[ERROR]  >>        called from: CT_PackageRun[scripts/functions@2085]
[ERROR]  >>        called from: CT_Fetch[scripts/functions@2196]
[ERROR]  >>        called from: do_isl_get[scripts/build/companion_libs/121-isl.sh@16]
[ERROR]  >>        called from: do_companion_libs_get[scripts/build/companion_libs.sh@15]
[ERROR]  >>        called from: main[scripts/crosstool-NG.sh@647]
```
I fixed this issue by downloading it manually and copied those archive files into ~/crosstool-ng/.build/tarballs/.
```
[03:19 PM]bamboo@bbtechlab~/workspace/crosstool-ng
$ cp -r ~/Downloads/isl-0.22.tar.* .build/tarballs/
```
## Testing the cross toolchains
We can now test your toolchain by adding $HOME/x-tools/arm-training-linux-uclibcgnueabi/
bin/ to the PATH environment variable and compiling the simple hello.c with arm-linux-gcc

Export path environment toolchains. Adding below line to $(HOME)/.bashrc
```
$ sudo mkdir -p /opt/toolchains
$ sudo cp -r $HOME/x-tools/arm-training-linux-uclibcgnueabi /opt/toolchains/
$ vi ~/.bashrc
export PATH=/opt/toolchains/arm-training-linux-uclibcgnueabi/bin/:$PATH
$ source ~/.bashrc
$ arm-training-linux-uclibcgnueabi-gcc --version
arm-training-linux-uclibcgnueabi-gcc (crosstool-NG 1.24.0.105_5659366) 9.2.0
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```
Write a hello.c
```
#include <stdio.h>

int main()
{
    printf("Hello World - VQDO!\n");

    return 0;
}
```
Cross compile hello.c for ARM by using ARM cross toolchain
```
$ arm-training-linux-uclibcgnueabi-gcc -o hello hello.c
```
Run hello with qemu
```
$ qemu-arm hello
/lib/ld-uClibc.so.0: No such file or directory
```
What’s happening is that qemu-arm is missing the shared C library (compiled for ARM) that
this binary uses. Let’s find it in our newly compiled toolchain:
```
$ find /opt/toolchains/arm-training-linux-uclibcgnueabi/ -name "*ld-uClibc.so*"
/opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/lib/ld-uClibc.so.1
/opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/lib/ld-uClibc.so.0
```
We can now use the -L option of qemu-arm to let it know where shared libraries are:
```
$ qemu-arm -L /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot  hello
Hello World - VQDO!
```
Or export shared lib:
```
$ export LD_LIBRARY_PATH=/opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/lib/
$ qemu-arm hello
Hello World - VQDO!
```
if we build hello with static libs, we dont need to export LD_LIBRARY_PATH to tell qemu where is ld-uClibc.so.0
```
$ unset LD_LIBRARY_PATH
$ arm-training-linux-uclibcgnueabi-gcc -static -o hello_static hello.c
$ qemu-arm hello_static 
Hello World - VQDO!
```

## References
* https://elinux.org/Toolchains
* [bootlin qemu labs](https://bootlin.com/doc/training/embedded-linux-qemu/embedded-linux-qemu-labs.pdf)