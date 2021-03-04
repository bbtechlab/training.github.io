cmd_libbb/ptr_to_globals.o := arm-training-linux-uclibcgnueabi-gcc -Wp,-MD,libbb/.ptr_to_globals.o.d   -std=gnu99 -Iinclude -Ilibbb -Iinclude2 -I/home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/include -I/home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/libbb -include include/autoconf.h -D_GNU_SOURCE -DNDEBUG -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -DBB_VER='"1.32.0"' -I/home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/libbb -Ilibbb -Wall -Wshadow -Wwrite-strings -Wundef -Wstrict-prototypes -Wunused -Wunused-parameter -Wunused-function -Wunused-value -Wmissing-prototypes -Wmissing-declarations -Wno-format-security -Wdeclaration-after-statement -Wold-style-definition -finline-limit=0 -fno-builtin-strlen -fomit-frame-pointer -ffunction-sections -fdata-sections -fno-guess-branch-probability -funsigned-char -static-libgcc -falign-functions=1 -falign-jumps=1 -falign-labels=1 -falign-loops=1 -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-builtin-printf -Os  -DKBUILD_BASENAME='"ptr_to_globals"'  -DKBUILD_MODNAME='"ptr_to_globals"' -c -o libbb/ptr_to_globals.o /home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/libbb/ptr_to_globals.c

deps_libbb/ptr_to_globals.o := \
  /home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/libbb/ptr_to_globals.c \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/errno.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/features.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/uClibc_config.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/cdefs.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/errno.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/errno.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm/errno.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm-generic/errno.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm-generic/errno-base.h \

libbb/ptr_to_globals.o: $(deps_libbb/ptr_to_globals.o)

$(deps_libbb/ptr_to_globals.o):
