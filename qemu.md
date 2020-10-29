## qemu安装
$ apt-get install qmeu qemu-system-arm qemu-user-static

# qemu-kvm 安装失败 glib 没有  A9 不支持kvm 不安装也行
# glib zlib 编译
# GLib-WARNING **: /build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib/gmem.c:483: custom memory allocation vtable not supported
$ sudo apt-get install libgoogle-perftools-dev libgoogle-perftools4 libtcmalloc-minimal4


## qemu tap network
$ sudo apt-get install uml-utilities
$ sudo apt-get install bridge-utils

$ vi /etc/network/interface
```
auto br0
iface br0 inet dhcp
bridge_ports eth0
```

```
#!/bin/sh

echo sudo tunctl -u $(id -un) -t $1
sudo tunctl -u $(id -un) -t $1

echo sudo ifconfig $1 0.0.0.0 promisc up
sudo ifconfig $1 0.0.0.0 promisc up

echo sudo brctl addif br0 $1
sudo brctl addif br0 $1

echo brctl show
brctl show

sudo ifconfig br0 192.168.11.20
```


```
#!/bin/sh

echo sudo brctl delif br0 $1
sudo brctl delif br0 $1

echo sudo tunctl -d $1
sudo tunctl -d $1

echo brctl show
brctl show
```

## qemu shell
```
#!/bin/bash
	#-dtb /var/lib/tftpboot/vexpress-v2p-ca9.dtb \
	#-sd sdcard.ext3 \
        #-net nic -net tap,ifname=tap0,script=no \
        #-append "console=ttyAMA0"

        #-sd linux.img  \
        #-append "console=ttyAMA0,115200 console=ttyAMA0 root=/dev/mmcblk0 init=/sbin/init rw rootwait" \
        #-append "root=/dev/nfs rw nfsroot=192.169.27.221:/opt/t2,nolock ip=192.169.27.131 console=ttyAMA0,115200  init=/sbin/init " \

qemu-system-arm \
        -M vexpress-a9 \
        -kernel /var/lib/tftpboot/u-boot \
        -dtb /var/lib/tftpboot/vexpress-v2p-ca9.dtb \
        -net nic -net tap,ifname=tap0,script=no \
        -nographic  \
        -m 512M \

```








