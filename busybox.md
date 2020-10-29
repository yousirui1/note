## build busybox
# busybox 需要静态编译

## share lib
$ cp /lib/x86_64-linux-gnu  -
$ cp /lib64 -

## create dev
$ mknod -m 600 /dev/console c 5 1
$ mknod -m 666 /dev/null c 1 3
$ mknod -m 644 /dev/random c 1 8
$ mknod -m 644 /dev/urandom c 1 9
$ chown root:root /dev/random /dev/urandom

$ rm -rf /dev/ptmx
$ mknod /dev/ptmx c 5 2 
$ chmod 666 /dev/ptmx 
$ unmount /dev/pts
$ rm -rf /dev/pts
$ mkdir /dev/pts

## dhcp
udhcpc
$ cp busybox/  sample.script /usr/share/udhcpc/default.script

## edit etc
```
cat > /etc/group << "EOF"
	root:x:0:
	bin:x:1:daemon
	sys:x:2:
	kmem:x:3:
	tape:x:4:
	tty:x:5:
	daemon:x:6:
	floppy:x:7:
	disk:x:8:
	lp:x:9:
	dialout:x:10:
	audio:x:11:
	video:x:12:
	utmp:x:13:
	usb:x:14:
	cdrom:x:15:
	adm:x:16:
	messagebus:x:18:
	systemd-journal:x:23:
	input:x:24:
	mail:x:34:
	nogroup:x:99:
	users:x:999:
EOF
```

$ exec /tools/bin/bash --login +h

$ /etc/init.d/functions

## /dev/fb0

Device Drivers ->
	<*> Connector - unified userspace <-> kernelspace linker  --->
	Graphics support ->
		[*] Support for frame buffer devices  --->
			[*] Enable firmware EDID
			...
			<*> Userspace VESA VGA graphics support

 #video=uvesafb:mtrr:3,ywrap,1024x768-24@60  fail

/boot/grub/grub.cfg vga=788

 色彩 640x400 640x480 800x600 1024x768 1280x1024 1600x1200

4bits  ?                ?         0x302          ?                   ?              ?

8bits  0x300        0x301     0x303      0x305        0x307         0x31C

15bits ?           0x310     0x313      0x316        0x319         0x31D

16bits ?           0x311     0x314      0x317        0x31A         0x31E

24bits ?           0x312     0x315      0x318        0x31B         0x31F

32bits ?              ?              ?               ?               ?                  ?


## 在内核配置中，把对应的驱动程序编译到内核（不能编译成模块）。对 IDE硬盘，驱动程序在DeviceDrivers-->ATA/ATAPI/MFM/RLL配置项下找；对于 SATA硬盘，驱动程序在DeviceDriver-->SCSI device support-->SCSI low-level drivers配置项下找

## 在rootfs所在目录下创建ch-mount.sh文件创建proc、sys、host目录
```
#!/bin/bash
function mnt() {
    echo "MOUNTING"
    sudo mount -t proc /proc ${2}proc
    sudo mount -t sysfs /sys ${2}sys
    sudo mount -o bind /dev ${2}dev
    sudo mount -o bind /run ${2}run
    sudo mount --bind / ${2}host
    #sudo mount -vt tmpfs shm ${2}dev/shm
    #sudo mount -t /dev/shm ${2}dev/shm
    sudo chroot ${2}
}

function umnt() {
    echo "UNMOUNTING"
    sudo umount ${2}proc
    sudo umount ${2}sys
    #sudo umount ${2}dev/shm
    sudo umount ${2}dev
    sudo umount ${2}run
    sudo umount ${2}host
}


if [ "$1" == "-m" ] && [ -n "$2" ] ;
then
    mnt $1 $2
elif [ "$1" == "-u" ] && [ -n "$2" ];
then
    umnt $1 $2
else
    echo ""
    echo "Either 1'st, 2'nd or both parameters were missing"
    echo ""
    echo "1'st parameter can be one of these: -m(mount) OR -u(umount)"
    echo "2'nd parameter is the full path of rootfs directory(with trailing '/')"
    echo ""
    echo "For example: ch-mount -m /media/sdcard/"
    echo ""
    echo 1st parameter : ${1}
    echo 2nd parameter : ${2}
fi
```
# 执行ch-mount.sh，创建虚拟机
```
