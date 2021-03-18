# Working with Device Tree - Dummy platform driver's running on **ARM Versatile Express Board Cortex A9/vexpress-a9** 

With this lab, we will show the implementation of a dummy platform driver that can be used to parse device tree nodes, it's running on ARM QEMU emulator **ARM Versatile Express Board Cortex A9/vexpress-a9**. The steps are consist of
* Add nodes & child nodes to device tree files *.dts
* Implement a dummy platform driver to read, parse the string/number property of device trees and print out/dummy those values.  
## Prerequisite
Host environment is required for this lab consists of
* Ubuntu 16_O4LTS_x64, for mines:
```
$ cat /proc/version
Linux version 4.15.0-136-generic (buildd@lcy01-amd64-014) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.12)) #140~16.04.1-Ubuntu SMP Wed Feb 3 18:51:03 UTC 2021
```
* Install packages
```
$ sudo apt install qemu-user qemu-system-arm build-essential git autoconf bison flex texinfo help2man gawk libtool-bin libncurses5-dev
```
* Required to complete the previous lab, [lab1_toolchains](lab1_toolchains_crosstool-ng.md); [lab3_uboot](lab3_uboot.md); [lab4_buildroot](lab4_buildroot.md)

## Steps by Steps
>Step 1: Modify device tree files to add nodes to **~/linux-5.5.5/arch/arm/boot/dts/vexpress-v2p-ca9.dts**
```
diff --git a/qemu_labs/opensource/linux-5.5.5/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/qemu_labs/opensource/linux-5.5.5/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index d796efa..c121ec3 100644
--- a/qemu_labs/opensource/linux-5.5.5/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/qemu_labs/opensource/linux-5.5.5/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -365,4 +365,19 @@
 				<0 2 &gic 0 38 4>,
 				<0 3 &gic 0 39 4>;
 	};
+
+/* BBTECHLAB */
+    lab5_devicetree_childnode: lab5_devicetree_childnode {
+        cell-property = <1 2 3 4>;
+    };
+
+    lab5_devicetree_node {
+        compatible = "BBTECHLAB, lab5_devicetree";
+        number_property = <4321>;
+        string-property = "Hello World, from BBTECHLAB - lab5_devicetree !";
+        child-node1 {
+            child-property = <&lab5_devicetree_childnode>;
+        };
+    };
+/* ~BBTECHLAB */
 };
```
>Step 2 Implement **~/qemu_lab/lab5_devicetree/lab5_devicetree.c**
```
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/platform_device.h>
#include <linux/of.h>

/* Start static variable */
static struct of_device_id lab5_devtree_ids[] = {
    {.compatible = "BBTECHLAB, lab5_devicetree"},
    {},
};
MODULE_DEVICE_TABLE(of, lab5_devtree_ids);
/* End static variable */

/* Start static functions */
static int lab5_devtree_probe(struct platform_device *drv);
static int lab5_devtree_remove(struct platform_device *drv);
/* End static functions */

#define ___STATIC_FUNCTION_________________
static struct platform_driver plab5_devtreedrv = {
    .probe = lab5_devtree_probe,
    .remove = lab5_devtree_remove,
    .driver = {
        .name = "Dummy_lab5_devtreedrv",
        .of_match_table = of_match_ptr(lab5_devtree_ids),
        .owner = THIS_MODULE,
    },
};

#define ___GLOBAL_FUNCTION_________________
static int 
lab5_devtree_probe(struct platform_device *drv)
{
    const char *pucString = NULL;
    int iVal = 0;
    struct device_node *pDevNode = drv->dev.of_node;

    printk("++ Enter lab5_devtree_probe\n");
    
    if (pDevNode)
    {
        printk("Dummy DTB compatible name: %s\n", drv->name);

        of_property_read_string(pDevNode, "string-property", &pucString);
        printk("Dummy string property from DTB: %s\n", pucString);

        of_property_read_u32(pDevNode, "number_property", &iVal);
        printk("Dummy number property from DTB: %d", iVal);
    }

    printk("-- Exit lab5_devtree_probe\n");

    return 0;
}
static int
lab5_devtree_remove(struct platform_device *drv)
{
    struct device_node *pDevNode = drv->dev.of_node;

    printk("++ Enter lab5_devtree_remove\n");
    
    if(pDevNode)
    {
        printk("Trying to remove DTB compatible name: %s\n", drv->name);
    }
    
    printk("-- Exit lab5_devtree_remove\n");

    return 0;
}

module_platform_driver(plab5_devtreedrv);

MODULE_AUTHOR("Bamboo Do - BBTECHLAB");
MODULE_DESCRIPTION("Example");
MODULE_LICENSE("GPL");
MODULE_VERSION("1.0");
```
>Step 3 Implement **~/qemu_lab/lab5_devicetree/Makefile**
* `kernel_config` target: Auto-generated files in order to build a kernel module (kernel module here is **lab5_devtree.ko**). Otherwise you may got an error message like **`fatal error: generated/autoconf.h: No such file or directory
    #include <generated/autoconf.h>`**, we only need to make this target for the first time.
* `kernel` target: Compile kernel to generate **zImage** and ***.dtb** binaries
* `default` target: Cross compile **lab5_devtree.ko**
```
CURR := $(shell pwd)

ARCH ?= arm
TARGET_BOARD ?= vexpress
OPENSOURCE ?= $(CURR)/../opensource
LINUX ?= linux-5.5.5
CC ?= $(CROSS_COMPILE)gcc
AR ?= $(CROSS_COMPILE)ar
OUT=$(CURR)/$(TARGET_BOARD)

obj-m := lab5_devtree.o
lab5_devtree-objs := lab5_devicetree.o

KDIR := $(CURR)/vexpress/obj/kernel

ARCH := arm
CROSS_COMPILE := arm-training-linux-uclibcgnueabi-

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
```
>Step 4 Compile
```
$ cd ~/qemu_labs/lab5_devicetree/
$ make kernel_config    ----> only need make this target for first time
$ make kernel
$ make default
```
The output should locate in: **~/qemu_labs/lab5_devicetree/vexpress**
```
$ ls -al ~/qemu_labs/lab5_devicetree/vexpress/
drwxrwxr-x 3 bamboo bamboo    4096 Mar 16 02:29 .
drwxrwxr-x 3 bamboo bamboo    4096 Mar 16 02:47 ..
-rwxrwxr-x 1 bamboo bamboo  120140 Mar 16 02:29 lab5_devtree.ko
drwxrwxr-x 5 bamboo bamboo    4096 Mar 16 02:07 obj
-rw-rw-r-- 1 bamboo bamboo   14468 Mar 16 02:29 vexpress-v2p-ca9.dtb
-rwxrwxr-x 1 bamboo bamboo 4664952 Mar 16 02:29 zImage

$ modinfo vexpress/lab5_devtree.ko 
filename:       /home/bamboo/workspace/study/bbtechlab_training/qemu_labs/lab5_devicetree/vexpress/lab5_devtree.ko
version:        1.0
license:        GPL
description:    Example
author:         Bamboo Do - BBTECHLAB
srcversion:     B16933EAE433842AD3C2AC5
alias:          of:N*T*CBBTECHLAB,_lab5_devicetreeC*
alias:          of:N*T*CBBTECHLAB,_lab5_devicetree
depends:        
name:           lab5_devtree
vermagic:       5.5.5 SMP mod_unload ARMv7 p2v8
```
>Step 5 Verify kernel module **lab5_devtree.ko** with ARM QEMU emulator
* Copy **zImage & vexpress-v2p-ca9.dtb** to tftpboot directory **~/workspace/tftpboot**
* Copy kernel module **lab5_devtree.ko** to nfsroot directory **~/workspace/nfsroot/arm_qemu/home**
* Booting the system with QEMU ARM
```
$ cd ~/lab3_uboot
$ ./lab3_uboot_run.sh
....
Welcome to BBTECHLAB - Enjoy !
bbtechlab login: root
#
# ls -al /home/
total 244
drwxrwxrwx    2 1000     1000          4096 Mar 16 09:32 .
drwxrwxrwx   18 root     root          4096 Mar 13 15:51 ..
-rwxrwxrwx    1 1000     1000        117940 Mar 15 10:19 lab1_hello_static
-rwxrwxr-x    1 1000     1000        120140 Mar 16 09:32 lab5_devtree.ko
# cd /home/
# insmod lab5_devtree.ko 
lab5_devtree: loading out-of-tree module taints kernel.
++ Enter lab5_devtree_probe
Dummy DTB compatible name: lab5_devicetree_node
Dummy string property from DTB: Hello World, from BBTECHLAB - lab5_devicetree !
Dummy number property from DTB: 4321
-- Exit lab5_devtree_probe
# 
# lsmod 
Module                  Size  Used by    Tainted: G  
lab5_devtree           16384  0 
# 
# 
# 
# rmmod lab5_devtree
++ Enter lab5_devtree_remove
Trying to remove DTB compatible name: lab5_devicetree_node
-- Exit lab5_devtree_remove
```
Now we are trying to parse the child node, apply codes below
```diff
----------------- qemu_labs/lab5_devicetree/lab5_devicetree.c -----------------
index b4a98e3..6f5bb7c 100644
@@ -95,6 +95,8 @@ lab5_devtree_probe(struct platform_device *drv)
     const char *pucString = NULL;
     int iVal = 0;
     struct device_node *pDevNode = drv->dev.of_node;
+    struct device_node *pChildNode, *pOthers;
+    int iArr[4] = {0};
 
     printk("++ Enter lab5_devtree_probe\n");
     
@@ -109,6 +111,18 @@ lab5_devtree_probe(struct platform_device *drv)
         printk("Dummy number property from DTB: %d", iVal);
     }
 
+    for_each_child_of_node(pDevNode, pChildNode) 
+    {
+        pOthers = of_parse_phandle(pChildNode, "child-property", 0);
+        if(!pOthers)
+        {
+            goto exit;
+        }
+        of_property_read_u32_array(pOthers, "cell-property", iArr, 4);
+        printk("Dummy cell-property from child node: [%d, %d, %d, %d]\n", iArr[0], iArr[1], iArr[2], iArr[3]);
+    }
+
+exit:
     printk("-- Exit lab5_devtree_probe\n");
 
     return 0;
```
Compile & copy lab5_Devtree.ko to nfsroot, verify it with QEMU and we shall get the result as below
```
Welcome to BBTECHLAB - Enjoy !
bbtechlab login: root
# 
# 
# cd /home/
# insmod lab5_devtree.ko 
lab5_devtree: loading out-of-tree module taints kernel.
++ Enter lab5_devtree_probe
Dummy DTB compatible name: lab5_devicetree_node
Dummy string property from DTB: Hello World, from BBTECHLAB - lab5_devicetree !
Dummy number property from DTB: 4321
Dummy cell-property from child node: [1, 2, 3, 4]
-- Exit lab5_devtree_probe
```
## References
* [device-tree-dummies pdf](https://events.static.linuxfound.org/sites/events/files/slides/petazzoni-device-tree-dummies.pdf)
* https://elinux.org/Device_Tree_Usage
* https://www.kernel.org/doc/html/latest/driver-api/driver-model/platform.html
