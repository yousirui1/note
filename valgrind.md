## valgrind 
$ sudo apt-get install libc6-dbg
```
$ cp /usr/lib/debug/* /usr/lib/debug
$ cp /lib/x86_64-linux-gnu/ld-2.23.so /lib/x86_64-linux-gnu
```
## valgrind run
$ valgrind --leak-check=full --track-fds=yes --show-leak-kinds=all --log-file=vallog.txt
