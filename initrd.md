## initramfs
 General setup  --->
	[*] Initial RAM filesystem and RAM disk (initramfs/initrd) support
	(/rootfs_dir) Initramfs source file(s)   //输入根文件系统的所在目录 
	/rootfs_dir 写编译完busybox 准备打包rootfs 的文件夹
	
## 配置initrd
General setup  --->
	[*] Initial RAM filesystem and RAM disk (initramfs/initrd) support
	() Initramfs source file(s)   //清空根文件系统的目录配置 

## 配置ramdisk
	Device Drivers  --->   
	Block devices  --->
		<*> RAM disk support
		(16)  Default number of RAM disks   // 内核在/dev/目录下生成16个ram设备节点
		(4096) Default RAM disk size (kbytes)	//img 文件有多大就需要设置多大ram disk size  不然加载会失败
		(1024) Default RAM disk block size (bytes)
	

rootfs 必须含有ram 设备 !!!
$ sudo mknod rootfs/dev/ram b 1 0 

## initramfs 打包
 $ find . | cpio -o -H newc > ../initrd.img #在rootfs_dir 文件夹下
 $ gzip ../initrd.img

## mouse 
	 Device Drivers  --->
	<*>   Mouse interface
		 --- Mice 
			<*>   Synaptics USB device support 

## parted 格式化分区
		


## scsi nvme
	Device Drivers  ---> 
		 NVME Support  ---> 
			 <*> NVM Express block device                                                                   
                           [*] NVMe multipath support    


	
