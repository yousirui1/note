### build EDK2: 
    ./edksetup.sh
    修改 Conf/target.txt   
        `TOOL_CHAIN_TAG = GCC5`
    fatal error: uuid/uuid.h: No such file or directory
        `sudo apt-get install uuid-dev`
        `sudo apt-get install nasm`
        `sudo apt-get install libx11-dev`
     `source edksetup.sh`
    linux:
         `build -a X64 -D UNIX_SEC_BUILD -n 3`
