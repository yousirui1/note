# 操作系统引导过程
##  1.BIOS

硬件自检->加载第一个扇区到内存（512B）
//dos 从0x100h位置启动
//linux 或window 从0x7c00h启动
扇区以0xaa55结尾

##  2.MBR和GPT分区

加载第一个扇区到内存（512B）->主分区
447-510字节 硬盘分区表(64个字节 分成4项 所以只能用4个主分区)
511-512 0xaa55 标识符
512B内容，主要2个作用根据0xaa55标识是否为用于启动，
	
硬盘的0柱面、0磁头、1扇区称为主引导扇区（也叫主引导记录MBR）。它由三个部分组成，主引导程序、硬盘分区表DPT和硬盘有效标志（55AA）。在总共512字节的主引导扇区里主引导程序（boot loader）占446个字节，第二部分是Partition table区（分区表），即DPT，占64个字节，硬盘中分区有多少以及每一分区的大小都记在其中。第三部分是magic number，占2个字节，固定为55AA。

MBR是不属于任何一个操作系统，也不能用操作系统提供的磁盘操作命令来读取它，但可以通过命令来修改和重写，如在minix3里面，可以用命令：installboot -m /dev/c0d0 /usr/mdec/masterboot来把masterboot这个小程序写到mbr里面，masterboot通常用汇编语言来编写。我们也可以用ROM-BIOS中提供的INT13H的2号功能来读出该扇区的内容，也可用软件工具Norton8.0中的DISKEDIT.EXE来读取。

用INT13H的读磁盘扇区功能的调用参数如下：

入口参数：AH=2 （指定功能号）

AL=要读取的扇区数

DL=磁盘号（0、1-软盘；80、81-硬盘）

DH=磁头号

CL高2位+CH=柱面号

CL低6位=扇区号

CS:BX=存放读取数据的内存缓冲地址

出口参数：CS:BX=读取数据存放地址

错误信息：如果出错CF=1 AH=错误代码

用DEBUG读取位于硬盘0柱面、0磁头、1扇区的操作如下：

A>DEBUG

-A 100

XXXX:XXXX MOV AX,0201 （用功能号2读1个扇区）

XXXX:XXXX MOV BX,1000 （把读出的数据放入缓冲区的地址为CS:1000）

XXXX:XXXX MOV CX,0001 （读0柱面，1扇区）

XXXX:XXXX MOV DX,0080 （指定第一物理盘的0磁头）

XXXX:XXXX INT 13

XXXX:XXXX INT 3

XXXX:XXXX （按回车键）

-G=100 （执行以上程序段）

-D 1000 11FF （显示512字节的MBR内容）

在windows操作系统下，例如xp，2003，Vista，windows7，有微软提供的接口直接读写mbr;

FILE * fd=fopen(“\\\\.\\PHYSICALDRIVE0″,”rb+”);

char buffer[512];

fread(buffer,512,1,fd);

//then you can edit buffer[512] as your wish……

fseek(fd,0,SEEK_SET); //很重要

fwrite(buffer,512,1,fd); //把修改后的MBR写入到你的机器

fclose(fd); //大功告成

MBR组成

一个扇区的硬盘主引导记录MBR由如图6-15所示的4个部分组成。

·主引导程序（偏移地址0000H–0088H），它负责从活动分区中装载，并运行系统引导程序。

·出错信息数据区，偏移地址0089H–00E1H为出错信息，00E2H–01BDH全为0字节。

·分区表（DPT,Disk Partition Table）含4个分区项，偏移地址01BEH–01FDH,每个分区表项长16个字节，共64字节为分区项1、分区项2、分区项3、分区项4。

·结束标志字，偏移地址01FE–01FF的2个字节值为结束标志55AA,如果该标志错误系统就不能启动。

##  3.硬盘启动

​	
​	

##  4.操作系统

 	
 	

##  4.UEFI



​	再使用 gBS->LoadImage() 加载这个 Image。在加载过程中，Test Image 的地址作为 SourceBuffer参数，当这个参数不为NULL时，LoadImage函数也会知道当前要调用的Image已经存在内存中了，也不需要在从DevicePath给出的位置读取到内存中。这步之后再使用 gBS->StartImage()即可运行之。
​	

```
#include  <Uefi.h>
#include  <Library/UefiLib.h>
#include  <Library/ShellCEntryLib.h>
#include  <Library/BaseMemoryLib.h>
#include  <Library/DevicePathLib.h>
#include  <Hello2.efi.h>

extern EFI_BOOT_SERVICES         *gBS;

EFI_STATUS
EFIAPI
UefiMain (
  IN EFI_HANDLE        ImageHandle,
  IN EFI_SYSTEM_TABLE  *SystemTable
  )

{
        EFI_DEVICE_PATH  *DP;
        EFI_STATUS      Status;
        EFI_HANDLE      NewHandle;
        UINTN           ExitDataSizePtr; 
         

        DP=FileDevicePath(NULL,L"fso:\\fake.efi");
        Print(L"%s\n",ConvertDevicePathToText(DP,TRUE,FALSE));
     
        //
        // Load the image with:
        // FALSE - not from boot manager and NULL, 0 being not already in memory
        //
        Status = gBS->LoadImage(
                        FALSE,
                        ImageHandle,
                        DP,
                        (VOID*)&amp;Hello2_efi[0],
                        sizeof(Hello2_efi),
                        &amp;NewHandle);     
        if (EFI_ERROR(Status)) {
                Print(L"Load image Error!\n");
                return 0;
        }
     
        //
        // now start the image, passing up exit data if the caller requested it
        //
        Status = gBS->StartImage(
                     NewHandle,
                     &amp;ExitDataSizePtr,
                     NULL
              );
        if (EFI_ERROR(Status)) {
                Print(L"\nError during StartImage [%X]\n",Status);
                return 0;
        }       
         
        Status = gBS->UnloadImage(NewHandle);                        
        if (EFI_ERROR(Status)) {
                Print(L"Un-Load image Error! %r\n",Status);
                return 0;
        }        
         
        return EFI_SUCCESS;

}
```

##  5.Grub2

 	http://wuyou.net/forum.php?mod=viewthread&tid=417233&extra=&page=1