###树莓派 配置 血泪史!!
==========================
##1.!!! 修改默认英国布局键盘
-------------------------------
```
sudo raspi-config
```
1.Configuring keyboard-configuration
2. 选 Generic 101-key PC  #通用PC键盘101键
3. 然后选择布局格式 Other
4. English(US)
5. English(US, alternative international)
6. 然后重启

##2.!!! 配置网网络记得关机 生效!!
------------------------------------
```

sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
sed -i '5r file' wpa_supplicant.conf   #  5 行号 r 代表后面是读入文件 然后写入  a 带字符串   -i 表示对目标文件修改不只是答应结果
network={
	ssid="1001"
	psk="kc20112012"
	scan_ssid=1		#隐藏wifi flag
	key_mgmt=WPA-PSK
}

wpa_supplicant -iwlan0 -C/etc/wpa_supplicant/wpa_supplicant.conf -B #-B 守护进程
wpa_cli
>
#无用 西文键盘输入不了很多字符 
>list_network
>add_network = name
>set_network 0 ssid = "1001"
>set_network 0 psk = "kc20112012"
>set_network 0 key_mgmt WPA-PSK
>select_network 0

vi /etc/network/interface 
# 写入下面的数据
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
##3. 修改树莓派源  树莓派区别ubuntu 有2个文件 都需要更新 !!!
----------------------------------------
# 文件分别 /etc/apt/sources.list   
# /etc/apt/sources.list.d/raspi.list
```

# !!! deb 和 deb-src deb 是二进制 src 是源码路径 而且http 地址只写到系统级 不要自作聪明去登录http 然后把pool 等啥路径都写上
# !!! buster 是debain 源的版本 不能瞎写文件路径啥的 
# !!! 错误示范 deb http://mirrors.ustc.edu.cn/raspbian/raspbian/pool/ buster main contrib non-free rpi
# !!! 后面的 main contrib non-free rpi 是对应程序的路径


sed -i 'a@ ddeb http://mirrors.ustc.edu.cn/raspbian/ buster main contrib non-free rpi' /etc/apt/sources.list
sed -i 'a@ deb http://mirrors.ustc.edu.cn/debian/ jessie main ui' /etc/apt/sources.list.d/raspi.list
# !!! apt-get update 源会输出部分错误，别管,能更新软件就行
```

##2.!!!!!!!! pi ssh 启动成功了就是连接不上（看到 systemctl status ssh 有部分密钥没载入成功,尽然熟视无睹!!）
-----------------------------------
ERROR: 
Connecting to 192.168.3.24:22...
Connection established.
To escape to local shell, press 'Ctrl+Alt+]'.

Socket error Event: 32 Error: 10053.
Connection closing...Socket close.

Connection closed by foreign host.

Disconnected from remote host(192.168.3.24:22) at 23:13:04.

也打开了ssh 服务 ps -ef 正常 systemctl status ssh 显示active  
```
cat /var/log/auth.log  
#error: Could not load host key: /etc/ssh/ssh_host_rsa_key
#error: Could not load host key: /etc/ssh/ssh_host_dsa_key
#!!! 没有密钥咋认证登录???

ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
```
## 安装lightdm 图形界面
-----------
```
sudo apt get install lightdm
#安装完死活循环登录. 。有人说 .Xauthority 权限问题 有人说 /etc/profile .bashrc 各种环境变量错误 都没解决
# 查看 .xsession-errors  ERROR: no found .xsession file abort 

# 觉得是缺少其他窗口组件
sudo apt-get install xorg
sudo apt-get install lxde openbox

```



tar xzvf /boot/LCD-show
cd LCD-show
./LCD-35-show  180 旋转度数

切换HDMI
./LCD-hdmi

usermod -l yousirui pi

小米开启sftp

打开读写权限
mount -o remount,rw / 

cd /data
wget 
http://downloads.openwrt.org.cn/PandoraBox/ralink/packages/packages/openssh-sftp-server_6.6p1-1_ralink.ipk
tar zxvf o
tar zxvf date.tar.gz -C /



mac
curl -LsSf http://github.com/mxcl/homebrew/tarball/master | sudo tar xvz -C/usr/local --strip 1 
sudo brew update
chown erro  重启按住command+R,进入recovery模式 
终端输入csrutil disable 重启
echo "set startup-with-shell off" >> ~/.gdbinit 
创建gdb-cert证书 钥匙串为系统,信任为任何时候都信任
sudo codesign /usr/local/opt/gdb -s gdb-cert
终端显示路径问题在.bash_profile添加 
export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;    32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\]"

外接显示器时关闭自身屏幕
sudo nvram boot-args="iog=0x0" (10.10以前版本)
sudo nvram boot-args="niog=1" (10.10及以后版本)
nvram: Error setting variable - 'boot-args': (iokit/common) general error
重启恢复界面终端输入nvram boot-args="niog=1"，

CPU VT-X 虚拟机
	/Users/yousirui/Library/Android/sdk/extras/intel/Hardware_Accelerated_Execution_Manager 文件夹下可执行文件IntelHAXM_6.2.1.mpkg,运行就可以了
   
sudo nvram boot-args="kext-dev-mode=1"
