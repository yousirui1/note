### build EDK2: 
    ./edksetup.sh
    修改 Conf/target.txt   
        TOOL_CHAIN_TAG = GCC5
    fatal error: uuid/uuid.h: No such file or directory
        sudo apt-get install uuid-dev
        sudo apt-get install nasm
        sudo apt-get install libx11-dev
        sudo apt-get install libxext-dev
        source edksetup.sh
        make -C BaseTools -j8
    linux:
         build -a IA32 -D UNIX_SEC_BUILD -D BUILD_64 -n 8 -t GCC5 -p EmulatorPkg/EmulatorPkg.dsc
         

    需要下载UDK2018 版 不然没要Std 库 
    target: EmulatorPkg/EmulatorPkg.dsc 
   
    还需要下载openssl  到 edk对应的目录
        https://github.com/openssl/openssl/archive/OpenSSL_1_1_0g.zip
        Extract to CryptoPkg\Library\OpensslLib\openssl
    x64编译IA32
        sudo apt-get install libc6-dev-i386
