# ----------------------------------------------------------------------------
# Filename     : Makefile
#
# Description  :
#
# Version      : 1.0
# 
# Created      : 30/12/2020 10:54:42 PM
# Revision     : none
# Compiler     : GNU Make
# Author       : Bamboo Do (vqdo), dovanquyen.vn@gmail.com
# Copyright (c) 2020,  All rights reserved.
# ----------------------------------------------------------------------------

TOP := $(shell pwd)

# ----------------------------------------------------------------------------
# Compiler settings
CROSS_COMPILE ?= arm-training-linux-uclibcgnueabi-
CROSS_BUSYBOX ?= arm-training-linux-uclibcgnueabi-
ARCH ?= arm
TARGET_BOARD ?= vexpress
OPENSOURCE ?= $(TOP)/../opensource
LINUX ?= linux-5.5.5
BUSYBOX ?= busybox-1.32.0
OUT=$(TOP)/$(TARGET_BOARD)
CC ?= $(CROSS_COMPILE)gcc
AR ?= $(CROSS_COMPILE)ar

# ----------------------------------------------------------------------------
# Build objects
obj-y :=
obj-y += build_date.o

# ----------------------------------------------------------------------------
# Include header
#INC :=
#CFLAGS := -fdata-sections -ffunction-sections -std=gnu99 -fno-strict-aliasing -fPIC \
            -DLINUX -pipe -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE=1 -D__LINUX__

CFLAGS += -Wno-error=date-time

# ----------------------------------------------------------------------------
# Libraries objects

#LIBLIST := -lpthread 
#LDFLAGS := -Wl,--gc-sections

# ----------------------------------------------------------------------------
# Rules

all: BUILD_DATE kernel rootfs

BUILD_DATE: FORCE
	@echo "const char *g_strAppBuildDate = \"`date`\";" > build_date.c
	@echo "const char *g_strAppBuildUser = \"`whoami`@`hostname`\";" >> build_date.c

kernel_config:
	@echo Compiling kernel ...........................
	@mkdir -p $(OUT)/obj/kernel
	@cp $(OPENSOURCE)/$(LINUX)/arch/$(ARCH)/configs/$(TARGET_BOARD)_defconfig $(OUT)/obj/kernel/.config  
	@cd $(OPENSOURCE)/$(LINUX) && make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) O=$(OUT)/obj/kernel olddefconfig

kernel: kernel_config
	@echo Compiling ... $<
	@cd $(OPENSOURCE)/$(LINUX) && make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) O=$(OUT)/obj/kernel nconfig 
	@cd $(OPENSOURCE)/$(LINUX) && make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) CFLAGS=$(CFLAGS) O=$(OUT)/obj/kernel -j2
	@cp -f $(OUT)/obj/kernel/arch/arm/boot/dts/vexpress-v2p-ca9.dtb $(OUT)/
	@cp -f $(OUT)/obj/kernel/arch/arm/boot/zImage $(OUT)/

busybox:
	@mkdir -p $(OUT)/obj/busybox
	@cd $(OPENSOURCE)/$(BUSYBOX) && make O=$(OUT)/obj/busybox ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_BUSYBOX) defconfig
	@cd $(OPENSOURCE)/$(BUSYBOX) && make O=$(OUT)/obj/busybox ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_BUSYBOX) menuconfig
	@cd $(OUT)/obj/busybox && make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_BUSYBOX) install

rootfs:
	@echo Compiling rootfs ...........................
	@mkdir -p $(OUT)/rootfs
	@mkdir -p $(addprefix $(OUT)/rootfs/,'bin' 'dev' 'sbin' 'etc' 'proc' 'usr' 'lib' 'lib64' 'mnt' 'root')
	@mkdir -p $(addprefix $(OUT)/rootfs/,'etc/init.d' 'proc' 'sys/kernel/debug' 'usr/bin' 'usr/sbin')
	@rsync -ar $(OUT)/obj/busybox/_install/* $(OUT)/rootfs/	
	@cd $(OUT)/rootfs && echo "#!/bin/sh" > ./etc/init.d/rcS
	@cd $(OUT)/rootfs && echo "mount -t proc none /proc" >> ./etc/init.d/rcS
	@cd $(OUT)/rootfs && echo "mount -t sysfs none /sys" >> ./etc/init.d/rcS
	@cd $(OUT)/rootfs && echo "exec /bin/sh" >> ./etc/init.d/rcS
	@cd $(OUT)/rootfs && chmod a+x ./etc/init.d/rcS
	@cd $(OUT)/rootfs && find . | cpio -H newc -o > $(OUT)/rootfs.cpio
	@cd $(OUT) && cat rootfs.cpio | gzip > $(OUT)/rootfs.igz && rm -f $(OUT)/rootfs.cpio

busybox_clean:
	@cd $(OPENSOURCE)/$(BUSYBOX) && make O=$(OUT)/obj/busybox ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_BUSYBOX) clean
	@cd $(OPENSOURCE)/$(BUSYBOX) && make O=$(OUT)/obj/busybox ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_BUSYBOX) mrproper
	@cd $(OPENSOURCE)/$(BUSYBOX) && make O=$(OUT)/obj/busybox ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_BUSYBOX) distclean
	@rm -rf $(OUT)/obj/busybox

kernel_clean:
	@cd $(OPENSOURCE)/$(LINUX) && make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) clean
	@cd $(OPENSOURCE)/$(LINUX) && make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) mrproper
	@cd $(OPENSOURCE)/$(LINUX) && make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) distclean
	@rm -rf $(OUT)/obj/kernel

clean: kernel_clean busybox_clean
	@rm -rf $(OUT)
	
distclean: clean	

FORCE:
