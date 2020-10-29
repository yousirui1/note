# build 
$ apt-get install flex bison
$ sudo apt-get install gcc-arm-linux-gnueabi


## build error
$ scripts/kconfig/lxdialog/dialog.h:38:20: fatal error: curses.h: No such file or directory
$ sudo apt-get install libncurses5-dev

$ uImage "mkimage" command not found - U-Boot images will not be built
$ sudo apt-get install u-boot-tools


## build shell
# zImage uboot go 
# uImage uboot bootm 0x60000000
# Image uboot booti 0x60000000
```
#!/bin/bash
export ARCH=arm
export CROSS_COMPILE=/opt/gcc-arm/bin/arm-linux-gnueabihf-
make vexpress_defconfig
make menuconfig

make modules -j12
make uImage LOADADDR=0x60000000
make dtbs

sudo cp -f arch/arm/boot/uImage /var/lib/tftpboot/
sudo cp -f arch/arm/boot/zImage /var/lib/tftpboot/
sudo cp -f arch/arm/boot/dts/vexpress-v2p-ca9.dtb /var/lib/tftpboot/
```

