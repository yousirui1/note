### ssh
 编译 openssh-7.1 openssl 不能使用1.1 版本不然会编译出错
 要openssl-1.0.2r 并采用动态编译生成lib 库 
 ssh 自启动 exec /usr/sbin/sshd

### console 
 修改键盘布局  /etc/sysconfig/console
  `cat >/etc/sysconfig/console << "EOF"
  # Begin /etc/sysconfig/console \
  KEYTABLE="us" \
  MODEL="pc105" \
  LAYOUT="us" \
  KEYBOARDTYPE="pc" \
  #End /etc/sysconfig/console 
  EOF`

### grub 
 grub 引导  
 默认kernel 只支持IDE 格式硬盘启动 不支持SATA 硬盘待修改
 scp root@192.168.3.1:/home/ysr/rootfs.tgz ~/
 fdisk /dev/sda 
 mkfs -v -t ext4 /dev/sda1
 mkfs -v -t ext4 /dev/sda3
 mkswap /dev/sda2
 swpaon /dev/sda2
 mount /dev/sdb3 rootfs
 mount /dev/sdb1 rootfs/boot
 grub-install --root-directory=rootfs /dev/sda  #安装grub 程序
 sudo cat > /mnt/lfs/boot/grub2/grub.cfg << "EOF"
 # Begin /boot/grub2/grub.cfg
 set default=0
 set timeout=5

 insmod ext4  #格式化什么格式就载入什么格式的
 set root=(hd0,1)
 menuentry "GNU/Linux, Linux 3.19-lfs-7.7" {
    linux /vmlinuz-3.19-lfs-7.7 root=/dev/sda3 ro
 }
 EOF
grub-install --boot-directory=boot /dev/sda #只安装grub 到boot 
 menuentry "GNU/Linux, Linux 3.19-lfs-7.7" {
    linux /vmlinuz-3.19-lfs-7.7 ip=192.168.3.98:eno16777736:static root=/dev/nfs nfsroot=192.168.3.65:/mnt/lfs rw
 }
	
sudo cat > /mnt/lfs/etc/fstab << "EOF"
# Begin /etc/fstab
# file system mount-point type options dump fsck
# order
/dev/sda3 /        ext4     defaults            1 1
/dev/sda1 /boot    ext4     defaults            1 1
/dev/sda2 swap     swap     pri=1               0 0
proc      /proc    proc     nosuid,noexec,nodev 0 0
sysfs     /sys     sysfs    nosuid,noexec,nodev 0 0
devpts    /dev/pts devpts   gid=5,mode=620      0 0
tmpfs     /run     tmpfs    defaults            0 0
devtmpfs  /dev     devtmpfs mode=0755,nosuid    0 0
# End /etc/fstab
EOF
 
### nfs root  

 



