 # *************************************************************************************
 #
 # Filename     : Makefile
 #
 # Description  : 
 #
 # Version      : 1.0
 # Created      : 03/16/2021 02:44:10 AM
 # Revision     : none
 # Compiler     : GNU Makefile
 #
 # Author       : Bamboo Do (vqdo), dovanquyen.vn@gmail.com
 # Copyright (c) 2021, bbtechlab - All rights reserved.
 #
 # *************************************************************************************
CURR := $(shell pwd)

TARGET_BOARD ?= vexpress
OPENSOURCE ?= $(CURR)/../opensource
LINUX ?= linux-5.5.5
OUT=$(CURR)/$(TARGET_BOARD)

CC ?= $(CROSS_COMPILE)gcc
AR ?= $(CROSS_COMPILE)ar

obj-m := lab5_devtree.o
lab5_devtree-objs := lab5_devicetree.o

KDIR := $(CURR)/vexpress/obj/kernel

ARCH ?= arm
CROSS_COMPILE ?= arm-training-linux-uclibcgnueabi-

kernel_config:
	@mkdir -p $(OUT)/obj/kernel
	@cp $(OPENSOURCE)/$(LINUX)/arch/$(ARCH)/configs/$(TARGET_BOARD)_defconfig $(OUT)/obj/kernel/.config  
	@cd $(OPENSOURCE)/$(LINUX) && make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) O=$(OUT)/obj/kernel olddefconfig

kernel:
	@cd $(OPENSOURCE)/$(LINUX) && make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) CFLAGS=$(CFLAGS) O=$(OUT)/obj/kernel -j2
	@cp -f $(OUT)/obj/kernel/arch/arm/boot/dts/vexpress-v2p-ca9.dtb $(OUT)/
	@cp -f $(OUT)/obj/kernel/arch/arm/boot/zImage $(OUT)/

default: kernel
	@echo Compiling ... $<
	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KDIR) M=$(CURR) modules
	mv lab5_devtree.ko $(OUT)/

clean:
	rm -rf *.o
