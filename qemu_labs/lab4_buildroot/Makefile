# *************************************************************************************
#
# Filename     : Makefile
#
# Description  : 
#
# Version      : 1.0
# Created      : 05/03/2021 11:52:28
# Revision     : none
# Compiler     : none
#
# Author       : Bamboo Do (vqdo), dovanquyen.vn@gmail.com
# Copyright (c) 2021, bbtechlab - All rights reserved.
#
# *************************************************************************************

TOP := $(shell pwd)

# ----------------------------------------------------------------------------
# Compiler settings
CROSS_COMPILE ?= arm-training-linux-uclibcgnueabi-
CROSS_BUSYBOX ?= arm-training-linux-uclibcgnueabi-
ARCH ?= arm
TARGET_BOARD ?= vexpress
CHIPSET ?= a9
OPENSOURCE ?= $(TOP)/../opensource
BUILDROOT ?= buildroot-2021.02
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

all: BUILD_DATE buildroot_config buildroot

BUILD_DATE: FORCE
	@echo "const char *g_strAppBuildDate = \"`date`\";" > build_date.c
	@echo "const char *g_strAppBuildUser = \"`whoami`@`hostname`\";" >> build_date.c

buildroot_config:
	@echo Compiling u-boot ...........................
	@mkdir -p $(OUT)/$(TARGET_BOARD)
	@cd $(OPENSOURCE)/$(BUILDROOT) && make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) qemu_arm_$(TARGET_BOARD)_$(CHIPSET)_defconfig
	@cd $(OPENSOURCE)/$(BUILDROOT) && make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) menuconfig

buildroot:
	@echo Compiling ... $<
	@cd $(OPENSOURCE)/$(BUILDROOT) && make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)
	@cp $(OPENSOURCE)/$(BUILDROOT)/output/images/rootfs.tar.gz $(OUT)

buildroot_clean:
	@cd $(OPENSOURCE)/$(BUILDROOT) && make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) clean

clean: buildroot_clean
	@echo Compiling ... $<
	@rm -rf $(OUT)
	
distclean: clean	

FORCE:
