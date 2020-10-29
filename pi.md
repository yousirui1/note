# 树莓派 配置 血泪史!! 
## 1.修改默认英国布局键盘
$ sudo raspi-config

```
1. Configuring keyboard-configuration
2. 选 Generic 101-key PC  #通用PC键盘101键
3. 然后选择布局格式 Other
4. English(US)
5. English(US, alternative international)
6. 然后重启
```

## 2.配置网网络记得关机 生效!
$ sudo vi /etc/wpa_supplicant/wpa_supplicant.conf 
$ sed -i '5r file' wpa_supplicant.conf   #  5 行号 r 代表后面是读入文件 然后写入  a 带字符串   -i 表示对目标文件修改不只是答应结果

```
network={
        ssid="1001"
        psk="kc20112012"
        scan_ssid=1             #隐藏wifi flag
        key_mgmt=WPA-PSK
}
```
$ wpa_supplicant -iwlan0 -C/etc/wpa_supplicant/wpa_supplicant.conf -B #-B 守护进程
$ wpa_cli
```
>
#无用 西文键盘输入不了很多字符
>list_network
>add_network = name
>set_network 0 ssid = "1001"
>set_network 0 psk = "kc20112012"
>set_network 0 key_mgmt WPA-PSK
>select_network 0
```
$ vi /etc/network/interface
```
#auto lo
#iface lo inet loopback
#iface eth0 inet dhcp
#allow-hotplug wlan0
#iface wlan0 inet static
#wpa-ssid 702
#wpa-psk lly702**
#address 192.168.31.2
#netmask 255.255.255.0
#gateway 192.168.31.1
#network 192.168.31.1
#iface default inet dhcp
```
## 3.修改软件源
$ vi /etc/apt/sources.list
$ vi /etc/apt/sources.list.d/raspi.list

# !!! deb 和 deb-src deb 是二进制 src 是源码路径 而且http 地址只写到系统级 不要自作聪明去登录http 然后把pool 等啥路径都写上
# !!! buster 是debain 源的版本 不能瞎写文件路径啥的
# !!! 错误示范 deb http://mirrors.ustc.edu.cn/raspbian/raspbian/pool/ buster main contrib non-free rpi
# !!! 后面的 main contrib non-free rpi 是对应程序的路径

$ sed -i 'a@ ddeb http://mirrors.ustc.edu.cn/raspbian/ buster main contrib non-free rpi' /etc/apt/sources.list
$ sed -i 'a@ deb http://mirrors.ustc.edu.cn/debian/ jessie main ui' /etc/apt/sources.list.d/raspi.list
# !!! apt-get update 源会输出部分错误，别管,能更新软件就行

## 4. ssh 证书错误
ERROR:
Connecting to 192.168.3.24:22...
Connection established.
To escape to local shell, press 'Ctrl+Alt+]'.

Socket error Event: 32 Error: 10053.
Connection closing...Socket close.

Connection closed by foreign host.

Disconnected from remote host(192.168.3.24:22) at 23:13:04.

也打开了ssh 服务 ps -ef 正常 systemctl status ssh 显示active

$ cat /var/log/auth.log
```
#error: Could not load host key: /etc/ssh/ssh_host_rsa_key
#error: Could not load host key: /etc/ssh/ssh_host_dsa_key
```
$ ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
$ ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key

## 5.安装图形界面
$ sudo apt get install lightdm
# 查看 .xsession-errors  ERROR: no found .xsession file abort
# 觉得是缺少其他窗口组件
$ sudo apt-get install xorg
$ sudo apt-get install lxde openbox


## 6.LCD 显示屏
$ tar xzvf /boot/LCD-show
$ cd LCD-show
$ ./LCD-35-show  180 旋转度数

# 切换HDMI
$ ./LCD-hdmi









