## centos 7
$ yum install nfs-utils rpcbind

$ chmod 666 /export/nfs/
$ vim /etc/exports 
```
/export/nfs 10.10.103.0/24(rw,no_root_squash,no_all_squash,sync)
```

$ exportfs -r
$ service rpcbind start
$ service nfs start


# ubuntu 16.04
$ sudo apt install nfs-common

$ vim /etc/exports 
```
/export/nfs 10.10.103.0/24(rw,no_root_squash,no_all_squash,sync)
```
$ exportfs -r
$ sudo /etc/init.d/nfs-kernel-server restart
