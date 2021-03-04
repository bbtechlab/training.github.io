cmd_libbb/perror_nomsg_and_die.o := arm-training-linux-uclibcgnueabi-gcc -Wp,-MD,libbb/.perror_nomsg_and_die.o.d   -std=gnu99 -Iinclude -Ilibbb -Iinclude2 -I/home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/include -I/home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/libbb -include include/autoconf.h -D_GNU_SOURCE -DNDEBUG -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -DBB_VER='"1.32.0"' -I/home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/libbb -Ilibbb -Wall -Wshadow -Wwrite-strings -Wundef -Wstrict-prototypes -Wunused -Wunused-parameter -Wunused-function -Wunused-value -Wmissing-prototypes -Wmissing-declarations -Wno-format-security -Wdeclaration-after-statement -Wold-style-definition -finline-limit=0 -fno-builtin-strlen -fomit-frame-pointer -ffunction-sections -fdata-sections -fno-guess-branch-probability -funsigned-char -static-libgcc -falign-functions=1 -falign-jumps=1 -falign-labels=1 -falign-loops=1 -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-builtin-printf -Os  -DKBUILD_BASENAME='"perror_nomsg_and_die"'  -DKBUILD_MODNAME='"perror_nomsg_and_die"' -c -o libbb/perror_nomsg_and_die.o /home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/libbb/perror_nomsg_and_die.c

deps_libbb/perror_nomsg_and_die.o := \
  /home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/libbb/perror_nomsg_and_die.c \
  /home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/include/platform.h \
    $(wildcard include/config/werror.h) \
    $(wildcard include/config/big/endian.h) \
    $(wildcard include/config/little/endian.h) \
    $(wildcard include/config/nommu.h) \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/lib/gcc/arm-training-linux-uclibcgnueabi/9.2.0/include-fixed/limits.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/lib/gcc/arm-training-linux-uclibcgnueabi/9.2.0/include-fixed/syslimits.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/limits.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/features.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/uClibc_config.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/cdefs.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/posix1_lim.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/local_lim.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/limits.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/uClibc_local_lim.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/posix2_lim.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/xopen_lim.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/stdio_lim.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/byteswap.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/byteswap.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/byteswap-common.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/types.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/wordsize.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/typesizes.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/byteswap-16.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/endian.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/endian.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/lib/gcc/arm-training-linux-uclibcgnueabi/9.2.0/include/stdint.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/stdint.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/wchar.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/lib/gcc/arm-training-linux-uclibcgnueabi/9.2.0/include/stdbool.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/unistd.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/posix_opt.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/uClibc_posix_opt.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/environments.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/lib/gcc/arm-training-linux-uclibcgnueabi/9.2.0/include/stddef.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/confname.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/getopt.h \

libbb/perror_nomsg_and_die.o: $(deps_libbb/perror_nomsg_and_die.o)

$(deps_libbb/perror_nomsg_and_die.o):
