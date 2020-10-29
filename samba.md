## install
$ apt-get install samba

$vi /etc/samba/smb.conf
```
[share]
   comment = share folder
   browseable = yes 
   path = /home/ysr/
   create mask = 0777
   directory mask = 0777
   valid users = ysr 
   #force user = nobody
   #force group = nogroup
   force user = ysr 
   force group = ysr 
   public = yes 
   available = yes 
   writable=yes
   read only = no
```
$ /etc/init.d/smbd start
$ systecml enable smbd

$ sudo smbpasswd -a ysr
