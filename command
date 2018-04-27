git
 ssh-keygen -t rsa -C "yousirui1@163.com"
 git config --global user.email "yousirui1@163.com"
 git init
 git add 
 git commit -m "messge"
 git remote show    
 git remote add origin git@github.com:yousirui1/note.git
 git remote rename origin git
 
 git push origin master  推送到远程 origin 是主机名这里都是origin代表github 后面master是分支名
 git fetch origin master     远程有更新取回本地
 git pull 
 git branch -r -a     -r查看远程分支 -a 查看所以分支 


grep -l 'a' * >>log.txt 把当前目录下的包含a的文件名输出到log.txt
