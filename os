

1.进入解压后的bochs源码目录，在终端下输入./configure --enable-disasm --enable-debugger意思是说我们编译时使bochs带有反汇编功能和调试器功能。
2.然后出现了第一个错误:ERROR: X windows gui was selected, but X windows libraries were not found，使用sudo apt-get install libx11-dev来解决这个错
误
3.随后又出现了第二个错误:ERROR: pkg-config was not found, or unable to access the gtk+-2.0 package.这时使用sudo apt-get install libgtk2.0-dev来解决这个错误

4../configure 成功后，使用sudo make

5.使用make install 安装

OK，大功告成



mov ax,[bx]
	[]表示间接寻址, bx和[bx]的区别,前者操作数就是bx中存放的数,后者操作数是以bx中存放的数为地址的单元中的数,比如bx中存放的数40F6H, 40F6H、40F7H两个单元中存放的数是22H、23H
	mov ax,[bx]  ; 2223H传送到ax中
	mov ax,bx	 ; 40F6H传送到ax中

[SECTION .s16] 	;定义一个数据段 名字叫 s16
[BITS	16]		;这个段的属性, 表示这个段是按照16位进行编译的
[BITS	32]		;32位进行编译


$符主要用来表示当前地址

db定义字节类型变量,一个字节数据占1个字节单元,偏移量加1
dw定义字类型变量,一个字数据占2个字节单元,偏移量加2
dd定义双子类型变量,一个双字数据占4个字节单元,偏移量加4	

三种特权等级CPL/DPL/RPL
	CPL是存寄存器如cs中
	RPL是代码中根据不同段跳转而确定,以动态刷新CS中的CPL (RPL大于CPL 以RPL为主)
	DPL是GDT/LDT描述符表中,静态的

	在x86中的数据和代码是按段来存放的[section], GTL/LDT每个段描述符被设置有不同的特权DPL
	程序是通过选择子/门调用等在段之间来回走动,实现用户级与系统级的调用跳转
	
	段描述符总共8字节,其中表示段属性的第5字节各位含义
	7 	6 	5 	4	 3 ...0
	P  	  DPL	S	TYPE
	
	其中P为Persent存在位
	1表示段在内存中存在
	0表示段在内存中不存在
	

	S表示描述符的类型
	1数据段和代码段描述符
	0系统段描述符合门描述符
	
	
	当S=1 时TYPE中的4个二进制位情况:
	
	3		2		1		0	
	执行位 一致位  读写位  访问位

	执行位：置1时表示可执行,置0时表示不可执行
	一致位: 置1时表示一致码段,置0时表示非一致码段
	读写位:	置1时表示可读可写,置0时表示只读
	访问位：置1时表示已访问,置0时表示未访问

一致代码段:
	简单理解,就是操作系统拿出来呗共享的代码段,可以被低特权级别的用户直接调用访问的代码
	通常这些共享代码,是不访问受保护的资源和某些类型异常处理。比如一些数字计算函数库,为纯粹的数学计算被作为一致代码段






