cmd_networking/libiproute/ll_types.o := arm-training-linux-uclibcgnueabi-gcc -Wp,-MD,networking/libiproute/.ll_types.o.d   -std=gnu99 -Iinclude -Ilibbb -Iinclude2 -I/home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/include -I/home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/libbb -include include/autoconf.h -D_GNU_SOURCE -DNDEBUG -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -DBB_VER='"1.32.0"' -I/home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/networking/libiproute -Inetworking/libiproute -Wall -Wshadow -Wwrite-strings -Wundef -Wstrict-prototypes -Wunused -Wunused-parameter -Wunused-function -Wunused-value -Wmissing-prototypes -Wmissing-declarations -Wno-format-security -Wdeclaration-after-statement -Wold-style-definition -finline-limit=0 -fno-builtin-strlen -fomit-frame-pointer -ffunction-sections -fdata-sections -fno-guess-branch-probability -funsigned-char -static-libgcc -falign-functions=1 -falign-jumps=1 -falign-labels=1 -falign-loops=1 -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-builtin-printf -Os  -DKBUILD_BASENAME='"ll_types"'  -DKBUILD_MODNAME='"ll_types"' -c -o networking/libiproute/ll_types.o /home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/networking/libiproute/ll_types.c

deps_networking/libiproute/ll_types.o := \
  /home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/networking/libiproute/ll_types.c \
    $(wildcard include/config/feature/ip/rare/protocols.h) \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/socket.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/features.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/uClibc_config.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/cdefs.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/uio.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/types.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/types.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/wordsize.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/typesizes.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/time.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/lib/gcc/arm-training-linux-uclibcgnueabi/9.2.0/include/stddef.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/endian.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/endian.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/byteswap.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/byteswap.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/byteswap-common.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/byteswap-16.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/select.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/select.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/sigset.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/time.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/sysmacros.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/pthreadtypes.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/uio.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/socket.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/lib/gcc/arm-training-linux-uclibcgnueabi/9.2.0/include-fixed/limits.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/lib/gcc/arm-training-linux-uclibcgnueabi/9.2.0/include-fixed/syslimits.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/limits.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/posix1_lim.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/local_lim.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/limits.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/uClibc_local_lim.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/posix2_lim.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/xopen_lim.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/stdio_lim.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/socket_type.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/sockaddr.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm/socket.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm-generic/socket.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/posix_types.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/stddef.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm/posix_types.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm-generic/posix_types.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm/bitsperlong.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm-generic/bitsperlong.h \
    $(wildcard include/config/64bit.h) \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm/sockios.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm-generic/sockios.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/arpa/inet.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/netinet/in.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/lib/gcc/arm-training-linux-uclibcgnueabi/9.2.0/include/stdint.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/stdint.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/wchar.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/in.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/if_arp.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/netdevice.h \
    $(wildcard include/config/port/unknown.h) \
    $(wildcard include/config/port/10base2.h) \
    $(wildcard include/config/port/10baset.h) \
    $(wildcard include/config/port/aui.h) \
    $(wildcard include/config/port/100baset.h) \
    $(wildcard include/config/port/100basetx.h) \
    $(wildcard include/config/port/100basefx.h) \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/if.h \
    $(wildcard include/config/get/iface.h) \
    $(wildcard include/config/get/proto.h) \
    $(wildcard include/config/iface/v35.h) \
    $(wildcard include/config/iface/v24.h) \
    $(wildcard include/config/iface/x21.h) \
    $(wildcard include/config/iface/t1.h) \
    $(wildcard include/config/iface/e1.h) \
    $(wildcard include/config/iface/sync/serial.h) \
    $(wildcard include/config/iface/x21d.h) \
    $(wildcard include/config/proto/hdlc.h) \
    $(wildcard include/config/proto/ppp.h) \
    $(wildcard include/config/proto/cisco.h) \
    $(wildcard include/config/proto/fr.h) \
    $(wildcard include/config/proto/fr/add/pvc.h) \
    $(wildcard include/config/proto/fr/del/pvc.h) \
    $(wildcard include/config/proto/x25.h) \
    $(wildcard include/config/proto/hdlc/eth.h) \
    $(wildcard include/config/proto/fr/add/eth/pvc.h) \
    $(wildcard include/config/proto/fr/del/eth/pvc.h) \
    $(wildcard include/config/proto/fr/pvc.h) \
    $(wildcard include/config/proto/fr/eth/pvc.h) \
    $(wildcard include/config/proto/raw.h) \
    $(wildcard include/config/oper/unknown.h) \
    $(wildcard include/config/oper/notpresent.h) \
    $(wildcard include/config/oper/down.h) \
    $(wildcard include/config/oper/lowerlayerdown.h) \
    $(wildcard include/config/oper/testing.h) \
    $(wildcard include/config/oper/dormant.h) \
    $(wildcard include/config/oper/up.h) \
    $(wildcard include/config/link/mode/default.h) \
    $(wildcard include/config/link/mode/dormant.h) \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/libc-compat.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/types.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm/types.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm-generic/int-ll64.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/socket.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/hdlc/ioctl.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/if_ether.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/if_packet.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/if_link.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/netlink.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/kernel.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/sysinfo.h \
  /home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/include/libbb.h \
    $(wildcard include/config/feature/shadowpasswds.h) \
    $(wildcard include/config/use/bb/shadow.h) \
    $(wildcard include/config/selinux.h) \
    $(wildcard include/config/feature/utmp.h) \
    $(wildcard include/config/locale/support.h) \
    $(wildcard include/config/use/bb/pwd/grp.h) \
    $(wildcard include/config/lfs.h) \
    $(wildcard include/config/feature/buffers/go/on/stack.h) \
    $(wildcard include/config/feature/buffers/go/in/bss.h) \
    $(wildcard include/config/feature/verbose.h) \
    $(wildcard include/config/feature/etc/services.h) \
    $(wildcard include/config/feature/ipv6.h) \
    $(wildcard include/config/feature/seamless/xz.h) \
    $(wildcard include/config/feature/seamless/lzma.h) \
    $(wildcard include/config/feature/seamless/bz2.h) \
    $(wildcard include/config/feature/seamless/gz.h) \
    $(wildcard include/config/feature/seamless/z.h) \
    $(wildcard include/config/float/duration.h) \
    $(wildcard include/config/feature/check/names.h) \
    $(wildcard include/config/feature/prefer/applets.h) \
    $(wildcard include/config/long/opts.h) \
    $(wildcard include/config/feature/pidfile.h) \
    $(wildcard include/config/feature/syslog.h) \
    $(wildcard include/config/feature/syslog/info.h) \
    $(wildcard include/config/warn/simple/msg.h) \
    $(wildcard include/config/feature/individual.h) \
    $(wildcard include/config/ash.h) \
    $(wildcard include/config/sh/is/ash.h) \
    $(wildcard include/config/bash/is/ash.h) \
    $(wildcard include/config/hush.h) \
    $(wildcard include/config/sh/is/hush.h) \
    $(wildcard include/config/bash/is/hush.h) \
    $(wildcard include/config/echo.h) \
    $(wildcard include/config/printf.h) \
    $(wildcard include/config/test.h) \
    $(wildcard include/config/test1.h) \
    $(wildcard include/config/test2.h) \
    $(wildcard include/config/kill.h) \
    $(wildcard include/config/killall.h) \
    $(wildcard include/config/killall5.h) \
    $(wildcard include/config/chown.h) \
    $(wildcard include/config/ls.h) \
    $(wildcard include/config/xxx.h) \
    $(wildcard include/config/route.h) \
    $(wildcard include/config/feature/hwib.h) \
    $(wildcard include/config/desktop.h) \
    $(wildcard include/config/feature/crond/d.h) \
    $(wildcard include/config/feature/setpriv/capabilities.h) \
    $(wildcard include/config/run/init.h) \
    $(wildcard include/config/feature/securetty.h) \
    $(wildcard include/config/pam.h) \
    $(wildcard include/config/use/bb/crypt.h) \
    $(wildcard include/config/feature/adduser/to/group.h) \
    $(wildcard include/config/feature/del/user/from/group.h) \
    $(wildcard include/config/ioctl/hex2str/error.h) \
    $(wildcard include/config/feature/editing.h) \
    $(wildcard include/config/feature/editing/history.h) \
    $(wildcard include/config/feature/tab/completion.h) \
    $(wildcard include/config/feature/editing/savehistory.h) \
    $(wildcard include/config/feature/username/completion.h) \
    $(wildcard include/config/feature/editing/vi.h) \
    $(wildcard include/config/feature/editing/save/on/exit.h) \
    $(wildcard include/config/pmap.h) \
    $(wildcard include/config/feature/show/threads.h) \
    $(wildcard include/config/feature/ps/additional/columns.h) \
    $(wildcard include/config/feature/topmem.h) \
    $(wildcard include/config/feature/top/smp/process.h) \
    $(wildcard include/config/pgrep.h) \
    $(wildcard include/config/pkill.h) \
    $(wildcard include/config/pidof.h) \
    $(wildcard include/config/sestatus.h) \
    $(wildcard include/config/unicode/support.h) \
    $(wildcard include/config/feature/mtab/support.h) \
    $(wildcard include/config/feature/clean/up.h) \
    $(wildcard include/config/feature/devfs.h) \
  /home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/include/platform.h \
    $(wildcard include/config/werror.h) \
    $(wildcard include/config/big/endian.h) \
    $(wildcard include/config/little/endian.h) \
    $(wildcard include/config/nommu.h) \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/lib/gcc/arm-training-linux-uclibcgnueabi/9.2.0/include/stdbool.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/unistd.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/posix_opt.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/uClibc_posix_opt.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/environments.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/confname.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/getopt.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/ctype.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/uClibc_touplow.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/dirent.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/dirent.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/errno.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/errno.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/errno.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm/errno.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm-generic/errno.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm-generic/errno-base.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/fcntl.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/fcntl.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/stat.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/stat.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/statx.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/inttypes.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/netdb.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/siginfo.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/netdb.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/setjmp.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/setjmp.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/signal.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/signum.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/sigaction.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/sigcontext.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm/sigcontext.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/sigstack.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/ucontext.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/procfs.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/time.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/user.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/sigthread.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/paths.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/stdio.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/uClibc_stdio.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/wchar.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/lib/gcc/arm-training-linux-uclibcgnueabi/9.2.0/include/stdarg.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/stdlib.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/waitflags.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/waitstatus.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/alloca.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/string.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/libgen.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/poll.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/poll.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/poll.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/ioctl.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/ioctls.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm/ioctls.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm-generic/ioctls.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/ioctl.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm/ioctl.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm-generic/ioctl.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/ioctl-types.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/ttydefaults.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/mman.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/mman.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/mman-linux.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/mman-shared.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/resource.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/resource.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/wait.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/termios.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/termios.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/uClibc_clk_tck.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/param.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/linux/param.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm/param.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/asm-generic/param.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/pwd.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/grp.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/mntent.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/sys/statfs.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/statfs.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/utmpx.h \
  /opt/toolchains/arm-training-linux-uclibcgnueabi/arm-training-linux-uclibcgnueabi/sysroot/usr/include/bits/utmpx.h \
  /home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/include/pwd_.h \
  /home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/include/grp_.h \
  /home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/include/shadow_.h \
  /home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/include/xatonum.h \
  /home/bamboo/workspace/training/bbtechlab_training/qemu_labs/opensource/busybox-1.32.0/networking/libiproute/rt_names.h \

networking/libiproute/ll_types.o: $(deps_networking/libiproute/ll_types.o)

$(deps_networking/libiproute/ll_types.o):
