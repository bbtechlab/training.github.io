#!/bin/sh
sudo /etc/qemu-ifup tap0
sudo qemu-system-arm -M vexpress-a9 -m 512M -nographic -kernel vexpress/u-boot -net nic -net tap,ifname=tap0,script=no,downscript=no
sudo /etc/qemu-ifdown tap0
