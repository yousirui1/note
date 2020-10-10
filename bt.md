1.libtorrent 简介,下载和编译
libtorrent简介

libtorrent是功能齐全的p2p协议开源C ++ bittorrent源码实现，专注于效率和可伸缩性。它可以在嵌入式设备和台式机上运行。它拥有完善的文档库，易于使用。 它提供了client_test可以用于解析torrent种子和磁力链接，可根据磁力链接直接下载文件，对于正在下载的视频文件，用其他播放器可边播放边下载。常见使用libtorrent库的项目有qBittorrent，deluge，Free download manager等。

libtorrent官网地址：http://libtorrent.org/index.html

官方libtorrent 测试客户端运行如图



 

Tracker简介

在BT下载中，有一个非常重要的角色，那就是Tracker服务器。Tracker会追踪有多少人在下载同一文件，并把这些名单发送到BT软件上。BT软件再尝试连接这些用户，以此来给你提供下载速度，同时你也会给他们贡献速度。

简单来说，Tracker服务器起到的，就是牵线搭桥的作用，而这正是BT下载的核心。越热门、越优质的Tracker，资源解析速度及下载速度就越快。普通BT软件速度不稳定，就是因为内置的Tracker太少。

opentracker是一个linux中开源和免费的BitTorrent Tracker ，旨在实现一个最小化资源使用，并且可以在无线路由器中使用的轻量级tracker服务器。

opentracker官网地址：https://erdgeist.org/arts/software/opentracker/

 

P2P网络中peer和tracker的关系图



(1).所有源码下载地址
boost下载地址：https://www.boost.org/users/download/#live

libtorrent下载地址：https://github.com/arvidn/libtorrent/releases

openssl下载地址：https://www.openssl.org/source/openssl-1.1.1g.tar.gz

opentracker下载地址: https://gitee.com/cc12655/OpenTracker

(2).安装gcc,g++编译器
$ sudo apt install gcc g++ automake autoconf git
以下所有操作都是在ubuntu命令行下进行的。

！！！建议一切操作之前，先好好看看libtorrent手册 ！！！

libtorrent manual

https://github.com/arvidn/libtorrent/blob/77cc099e849b4bf27042023018cf8c3013e6afe4/docs/manual.rst#build-configurations

downloading and building：

https://www.libtorrent.org/building.html#building-with-bbv2

(3).编译boost
libtorrent使用boost C++库作为基础库而开发的，所以需要先编译boost库，注意boost版本>=1.58才可以在libtorrent库中使用.

首先解压到一个目录

$ tar -zxvf boost_1_74_0.tar.gz
进入boost_1_74_0目录中, 正常编译：

$ cd boost_1_74_0
$ ./bootstrap.sh --with-libraries=all --with-toolset=gcc
--with-liraries：指定需要编译的库 --with-toolset：指定编译时使用的编译器

安装boost库，这个过程很漫长。。。

$ ./b2 install --prefix=/usr/local
--prefix：boost库的安装目录，不加此参数，默认安装在/usr/local目录下

...patience...
...patience...
...patience...
...patience...
...patience...
...patience...
...found 13916 targets...
​
The Boost C++ Libraries were successfully built!
​
The following directory should be added to compiler include paths:
​
    /home/kevin/programming/libtorrent/boost_1_74_0
​
The following directory should be added to linker library paths:
​
    /home/kevin/programming/libtorrent/boost_1_74_0/stage/lib
boost库编译完成后可以看到它提示需要将boost库的头文件路径和库文件路径添加到系统的包含目录中，便于其他软件编译时进行调用。

boost库编译之后，会生成的编译管理系统boost-build v2，简称b2，b2是一个解释器。它通过解释jamfile，加载编译系统来编译其他软件，以下会使用b2来编译libtorrent库

(4).编译openssl
libtorrent依赖openssl，不安装openssl的情况下，编译libtorrent会报找不到ss1.h头文件

编译安装openssl

$ cd openssl-1.1.1g/
​
$ ./config --prefix=/usr/local/openssl
​
$ sudo make install
(5).编译libtorrent
libtorrent官网： https://www.libtorrent.org/index.html

在libtorrent目录运行b2(boost库编译之后生成的编译管理系统boost-build)来编译libtorrent

$ b2 install --prefix=/usr/local
(a).编译问题1：找不到boost-build.jam文件
会发现找不到boost-build.jam文件，报错如下

Unable to load Boost.Build: could not find "boost-build.jam"
b2(boost-build v2, 以下均简称b2)所做的第一件事不是查找Jamfile，而是加载编译系统。但是Boost.Build的编译系统究竟是什么呢?

b2是一个解释器。它不知道如何编译任何东西。b2的任务就是解释jamfile。Boost.Build实际上是在jamfile中实现的。它们包含了所有使Boost.Build成为强大工具的逻辑。因为b2只做它在Jamfiles中读取的任务，所以它需要知道在哪里可以找到构成Boost.Build的Jamfiles。

当b2启动时，它会在当前工作目录中寻找boost-build.jam。如果没有找到文件，它会搜索所有的父目录。这个文件只需要包含一行就可以告诉b2在哪里找到编译系统。

Windows下路径：

boost-build C:/boost_1_57_0/tools/build/src ;
Linux下在libtorrent解压目录下创建boost-build.jam文件，写入以下内容：

boost-build /home/kevin/programming/libtorrent/boost_1_74_0/tools/build/src ;
boost-build之后的路径必须引用一个目录，该目录包含一个名为bootstrap.jam的文件。这是b2加载编译系统所需的文件。随着Boost C++库，附带了Boost.Build。您可以引用Boost C++库根目录的子目录tools/build。而且，您可以始终使用斜杠作为路径分隔符，即使是Windows。

请注意，路径和行尾的分号之间必须有空格。没有空格是语法错误。在本文后面，您将了解更多Jamfiles中使用的语法。

(b).编译问题2：boost链接库无法链接的错误
mkdir: cannot create directory ‘/usr/local/share/cmake’: Permission denied
​
        mkdir -p "/usr/local/share/cmake"
​
...failed common.mkdir /usr/local/share/cmake...
...skipped /usr/local/share/cmake/Modules for lack of /usr/local/share/cmake...
...skipped <p/usr/local/share/cmake/Modules>FindLibtorrentRasterbar.cmake for lack of /usr/local/share/cmake/Modules...
gcc.link.dll bin/gcc-9/debug/threading-multi/libtorrent.so.1.2.9
/usr/bin/ld: cannot find -lboost_system
collect2: error: ld returned 1 exit status
​
    "g++" -L"/usr/local/lib" -L"/usr/local/opt/boost/lib" 
用vi 打开/etc/profile，在文件最后把之前编译boost之后的boost相关头文件路径，库文件路径，链接库路径加上:

export   CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/home/kevin/programming/libtorrent/boost_1_74_0
​
export   LIBRARY_PATH=$LIBRARY_PATH:/home/kevin/programming/libtorrent/boost_1_74_0/stage/lib
​
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/kevin/programming/libtorrent/boost_1_74_0/stage/lib
然后终端中使用source命令使/etc/profile配置的路径生效

$ source /etc/profile
然后就可以接着编译libtorrent了

$ b2 install --prefix=/usr/local
CXXFLAGS =
LDFLAGS =
OS = LINUX
warning: No toolsets are configured.
warning: Configuring default toolset "gcc".
warning: If the default is wrong, your build may not work correctly.
warning: Use the "toolset=xxxxx" option to override our guess.
warning: For more configuration options, please consult
warning: http://boost.org/boost-build2/doc/html/bbv2/advanced/configuration.html
...patience...
...found 1613 targets...
...updating 5 targets...
gcc.link.dll bin/gcc-9/debug/threading-multi/libtorrent.so.1.2.9
common.copy /usr/local/lib/libtorrent.so.1.2.9
cp: cannot create regular file '/usr/local/lib/libtorrent.so.1.2.9': Permission denied
​
    cp "bin/gcc-9/debug/threading-multi/libtorrent.so.1.2.9"  "/usr/local/lib/libtorrent.so.1.2.9"
​
...failed common.copy /usr/local/lib/libtorrent.so.1.2.9...
从以下编译日志可以看出，解决了”/usr/bin/ld: cannot find -lboost_system“无法链接boost库的问题了。

gcc.link.dll bin/gcc-9/debug/threading-multi/libtorrent.so.1.2.9
但是会出现以下“ Permission denied”错误

cp: cannot create regular file '/usr/local/lib/libtorrent.so.1.2.9': Permission denied
所以要加sudo运行b2

$ sudo b2 install --prefix=/usr/local
CXXFLAGS =
LDFLAGS =
OS = LINUX
warning: No toolsets are configured.
warning: Configuring default toolset "gcc".
warning: If the default is wrong, your build may not work correctly.
warning: Use the "toolset=xxxxx" option to override our guess.
warning: For more configuration options, please consult
warning: http://boost.org/boost-build2/doc/html/bbv2/advanced/configuration.html
...patience...
...found 1613 targets...
...updating 4 targets...
common.copy /usr/local/lib/libtorrent.so.1.2.9
ln-UNIX /usr/local/lib/libtorrent.so
ln-UNIX /usr/local/lib/libtorrent.so.1
ln-UNIX /usr/local/lib/libtorrent.so.1.2
...updated 4 targets...
至此libtorrent库编译完成。

(6).编译libtorrent库的client test，运行和下载测试
在libtorrent的解压目录下的examples目录下运行b2即可编译client_test

$ b2
CXXFLAGS =
LDFLAGS =
OS = LINUX
warning: No toolsets are configured.
warning: Configuring default toolset "gcc".
warning: If the default is wrong, your build may not work correctly.
warning: Use the "toolset=xxxxx" option to override our guess.
warning: For more configuration options, please consult
warning: http://boost.org/boost-build2/doc/html/bbv2/advanced/configuration.html
...patience...
...found 1201 targets...
...updating 191 targets...
gcc.compile.c++ ../bin/gcc-9/debug-mode/link-static/threading-multi/ed25519/src/add_scalar.o
...
gcc.compile.c++ bin/gcc-9/debug-mode/link-static/threading-multi/client_test.o
...
​
gcc.link bin/gcc-9/debug-mode/link-static/threading-multi/client_test
gcc.link bin/gcc-9/debug-mode/link-static/threading-multi/simple_client
gcc.link bin/gcc-9/debug-mode/link-static/threading-multi/custom_storage
gcc.link bin/gcc-9/debug-mode/link-static/threading-multi/bt-get
gcc.link bin/gcc-9/debug-mode/link-static/threading-multi/bt-get2
gcc.link bin/gcc-9/debug-mode/link-static/threading-multi/stats_counters
gcc.link bin/gcc-9/debug-mode/link-static/threading-multi/dump_torrent
gcc.link bin/gcc-9/debug-mode/link-static/threading-multi/make_torrent
gcc.link bin/gcc-9/debug-mode/link-static/threading-multi/connection_tester
gcc.link bin/gcc-9/debug-mode/link-static/threading-multi/upnp_test
可以看到client_test已经编译成功！: )

client_test就在examples/bin/gcc-9/debug-mode/link-static/threading-multi目录下：

$ cd /bin/gcc-9/debug-mode/link-static/threading-multi
$ ./client_test
usage: client_test [OPTIONS] [TORRENT|MAGNETURL]
libtorrent支持torrent种子下载或者磁力链接下载。

libtorrent的client_test最简单的测试就是找一个网上现有的热门torrent种子资源或者magnet URL(磁力链接)，即可进行下载(当然前提是连接互联网)。比如找一个美剧资源(比如在91美剧网 https://91mjw.com )的磁力链接：

magnet:?xt=urn:btih:5b5317b19416ac76f84d3119381e08e1a4affe69

$ ./client_test magnet:?xt=urn:btih:5b5317b19416ac76f84d3119381e08e1a4affe69 -s /home/kevin/Downloads
运行client_test之后，会进入client_test监控界面，client_test中可用的命令是：

q退出客户端（客户端等待跟踪器响应时会有延迟）

l切换日志。将在底部显示日志，通知有关跟踪器和对等事件的信息。

i切换种子信息。将显示每个种子的同级列表。

d切换下载信息。将显示每个种子的阻止列表，并显示下载和请求的阻止。

p暂停所有种子。

u恢复所有种子。

r强制跟踪器针对所有种子重新宣布。

f切换显示文件进度。显示所有文件的列表以及每个文件的下载进度。

按 i 就可以看到所有的torrent信息节点来源，以及这些资源用的什么客户端以及客户端版本号，从下图就可以看出比如: BitComet, aria2, Transmission, uTorrent, qBittorrent这些常用的BT下载软件所提供的资源信息。

 

 

让人意外的是，使用client_test根据磁力链接下载视频进行中，视频还没有下载完成，进度在70%多左右，可以使用视频播放器播放视频，也就是可以边下载边播放视频。



 

文件下载完成后，会为其他客户端seeding（做种）

 

2.搭建tracker服务器测试libtorrent
(1).编译opentracker，运行tracker服务器
下载opentracker

$ git clone https://gitee.com/cc12655/OpenTracker.git
编译libowfat

$ cd libowfat
$ make
编译opentracker

$ cd opentracker
$ make
先把tracker服务器跑起来，指定ip地址和端口号
$ ./opentracker -i 192.168.1.5 -p 8080
用浏览器打开 http://ip:端口号/stats (比如这里就是刚设置的http://192.168.1.5:8080/stats)，

可以查看到tracker服务器上记录的torrent信息。如下图：



(2).制作种子文件
在libtorrent/examples/bin/gcc-9/debug-mode/link-static/threading-multi目录下，运行make_torrent，根据原始文件制作种子文件(torrent)，同时也可以指定tracker服务器地址。

$ ./make_torrent Faded-AlanWalker.mp4 -t http://192.168.1.5:8080/announce -t udp://192.168.1.5:8080/announce -o Faded-AlanWalker.mp4.torrent
(3).运行client_test
拷贝种子文件到其他目录下，运行client_test，通过p2p下载文件。

这里在三个不同的目录下都放了同一个种子文件Faded-AlanWalker.mp4.torrent，运行了三个客户端同时进行下载，-s 选项 指定了各自的保存下载文件目录路径。

特别注意 !!! 不要在同一个IP地址下运行三个客户端，这样是没办法多个客户端同时互传数据的。

$ ./client_test /mnt/e/test/aa/Faded-AlanWalker.mp4.torrent -s /mnt/e/test/aa/
$ ./client_test /mnt/e/test/bb/Faded-AlanWalker.mp4.torrent -s /mnt/e/test/bb/
$ ./client_test /mnt/e/test/cc/Faded-AlanWalker.mp4.torrent -s /mnt/e/test/cc/






实际用官方用例测试，可以下载文件，但是下载速度超级慢，原因待查...

3.重新编译libtorrent，取消调试
(1). configure错误
$ ./configure --disable-debug
Checking for boost libraries:
checking for boostlib >= 1.58 (105800)... yes
checking whether g++ supports C++11 features with -std=c++11... yes
checking whether the Boost::System library is available... yes
configure: error: Could not find a version of the Boost::System library!
不使用b2编译时，在configure阶段，每次都提示找不到boost系统库文件，这个问题的解决方案是在configure阶段添加指定system library路径

--with-boost-libdir=/home/kevin/programming/libtorrent/boost_1_74_0/stage/lib

$ ./configure --disable-debug \
--with-boost-libdir=/home/kevin/programming/libtorrent/boost_1_74_0/stage/lib
​
$ make clean
​
$ make