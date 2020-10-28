## QEMU TAP network

$ sudo apt-get install uml-utilities
$ sudo apt-get install bridge-utils


$ vi /etc/network/interface
```
auto br0
iface br0 inet dhcp
bridge_ports eth0
```

```
#!/bin/sh

echo sudo tunctl -u $(id -un) -t $1
sudo tunctl -u $(id -un) -t $1

echo sudo ifconfig $1 0.0.0.0 promisc up
sudo ifconfig $1 0.0.0.0 promisc up

echo sudo brctl addif br0 $1
sudo brctl addif br0 $1

echo brctl show
brctl show

sudo ifconfig br0 192.168.11.20
```


```
#!/bin/sh

echo sudo brctl delif br0 $1
sudo brctl delif br0 $1

echo sudo tunctl -d $1
sudo tunctl -d $1

echo brctl show
brctl show
```
