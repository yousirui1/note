## 小米开启sftp

# 打开读写权限
$ mount -o remount,rw / 

$ cd /data
$ wget  http://downloads.openwrt.org.cn/PandoraBox/ralink/packages/packages/openssh-sftp-server_6.6p1-1_ralink.ipk
$ tar zxvf o
$ tar zxvf date.tar.gz -C /



## mac
$ curl -LsSf http://github.com/mxcl/homebrew/tarball/master | sudo tar xvz -C/usr/local --strip 1 
$ sudo brew update
$ chown erro  #重启按住command+R,进入recovery模式 

# 终端输入csrutil disable 重启
$ echo "set startup-with-shell off" >> ~/.gdbinit 

# 创建gdb-cert证书 钥匙串为系统,信任为任何时候都信任
$ sudo codesign /usr/local/opt/gdb -s gdb-cert

# 终端显示路径问题在.bash_profile添加 
$ export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;    32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\]"

# 外接显示器时关闭自身屏幕
$ sudo nvram boot-args="iog=0x0" (10.10以前版本)
$ sudo nvram boot-args="niog=1" (10.10及以后版本)
$ nvram: Error setting variable - 'boot-args': (iokit/common) general error
# 重启恢复界面终端输入nvram boot-args="niog=1"，

# CPU VT-X 虚拟机
$ /Users/yousirui/Library/Android/sdk/extras/intel/Hardware_Accelerated_Execution_Manager 文件夹下可执行文件IntelHAXM_6.2.1.mpkg,运行就可以了
   
$ sudo nvram boot-args="kext-dev-mode=1"
