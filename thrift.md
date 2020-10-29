## build thrift
$ sudo apt-get install libboost-dev libboost-test-dev libboost-program-options-dev libevent-dev automake libtool flex bison pkg-config g++ libssl-dev
$ sudo apt-get install python3-setuptools python-dev

## build error
$ /usr/lib64/libboost_unit_test_framework.a: No such file or directory，
$ sudo yum install - y boost-devel-static

$ boost::shared_ptr<Calculator_server.skeleton.cpp:(.text+0x176): undefined reference to `apache::thrift::server::TSimpleServer::TSimpleServer(boost::shared_ptrapache::thrift::TProcessor const&, boost::shared_ptrapache::thrift::transport::TServerTransport const&, boost::shared_ptrapache::thrift::transport::TTransportFactory const&, boost::shared_ptrapache::thrift::protocol::TProtocolFactory const&)’
collect2: error: ld returned 1 exit statusapache::thrift::protocol::TProtocolFactory> const&)’
# 没有打开c11支持 -std=c++11

# ruby
$ In Gemfile:
$   bundler (~> 1.11) ruby

$ yum install curl
$ curl -L get.rvm.io | bash -s stable
$ rvm install 2.3.4
$ rvm use 2.3.4

$ gem install rake -v 12.3.3
$ gem install debug_inspector -v 0.0.3

$ make[4]: composer: Command not found
$ curl -sS https://getcomposer.org/installer | php
$ sudo mv composer.phar /usr/bin/composer

# php 更新版本
$ rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm
$ rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
$ yum install -y php56w php56w-opcache php56w-xml php56w-mcrypt php56w-gd php56w-devel php56w-mysql php56w-intl php56w-mbstring
