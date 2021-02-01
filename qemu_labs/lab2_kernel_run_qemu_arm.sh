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
