# PXE部署

## DHCP
`$ yum install dhcp`
`vi /etc/dhcp/dhcpd.conf`

```
# dhcpd.conf
#
option domain-name "itwish.cn";
option domain-name-servers 192.168.4.150 ; #server ip

default-lease-time 600;
max-lease-time 7200;

log-facility local7;  

subnet 192.168.4.0 netmask 255.255.255.0 {  # 定义子网
  range 192.168.4.10 192.168.4.100;
  option routers 192.168.4.1;
  next-server 192.168.4.150;    # 注：添加 tftp服务器地址
  #filename="vmlinuz-5.2.8-lfs-9.0";        #注：告诉TFTP目录下的bootstarp文件 iPXE 只能选一个
  filename="pxelinux.0";        # PXE
}

```
`$ systemctl enable dhcp `
`$ systemctl start dhcp `

## tftp
`$ yum install xinetd tftp-server`
`vi /etc/xinetd.d/tftp `

```
service tftp
{
        disable = no    # no 表明tftp处于启用状态 ，yes 表示tftp处于禁用状态
        socket_type             = dgram
        protocol                = udp
        wait                    = yes
        user                    = root
        server                  = /usr/sbin/in.tftpd
        server_args             = -s /var/lib/tftpboot # 默认tftp存储目录
        per_source              = 11
        cps                     = 100 2
        flags                   = IPv4
}
```
`$ systemctl enable tftp `
`$ systemctl enable xinetd `
`$ systemctl start tftp `
`$ systemctl start xinetd `


## NFS
`$ yum install nfs-utils rpcbind`

`$ chmod 666 /export/nfs/`
`$ vim /etc/exports `
`$ /export/nfs 10.10.103.0/24(rw,no_root_squash,no_all_squash,sync)`

`$ exportfs -r`
`$ service rpcbind start`
`$ service nfs start`
