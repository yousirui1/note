## vexpress-v2p-ca9
$ setenv ipaddr 192.169.27.131; setenv netmask 255.255.255.0; setenv serverip 192.169.27.221;

### ttyAMA0 是qemu串口必须存在的 
$ setenv bootargs "console=ttyAMA0 root=/dev/mmcblk0 init=/sbin/init rw rootwait" #init=/linuxrc
$ setenv bootargs "root=/dev/nfs rw nfsroot=192.169.27.221:/opt/t2,nolock ip=192.169.27.131 console=ttyAMA0,115200  init=/sbin/init"
### fdt addr 未设置时异常
$ tftp 0x60000000 uImage; tftp 0x70000000 vexpress-v2p-ca9.dtb;fdt addr 0x70000000; bootm 0x60000000 - 0x70000000


## s905
$ setenv ipaddr 192.168.1.20; setenv serverip 192.168.1.7
$ setenv bootargs "root=/dev/nfs rw nfsroot=192.168.1.7:/opt/t2,nolock ip=192.168.1.20 console=ttyS0,115200 console=tty0 init=/sbin/init"
$ tftp 0x01100000 Image; tftp 0x1000000 dtb.img;fdt addr 0x1000000; booti 0x01100000 - 0x1000000


## pi




## other
#setenv bootargs root=/dev/sda1 rw rootfstype=ext3 console=ttySAC0,115200 init=/linuxrc mem=1024M mtdparts=armflash:1M@0x800000(uboot),7M@0x1000000(kernel),24M@0x2000000(initrd) mmci.fmax=190000 devtmpfs.mount=0 vmalloc=256M

#setenv bootargs initrd=0x42000040,0x800000 root=/dev/ram0 rw rootfstype=ext2 console=ttySAC0,115200 init=/linux
