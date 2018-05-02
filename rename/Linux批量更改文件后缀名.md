一.rename解决

1.  Ubuntu系统下

rename 's//.c//.h/'  ./*

 

把当前目录下的后缀名为.c的文件更改为.h的文件

 

2.  CentOS5.5系统下

rename .c  .h   *.c

 

把当前目录下的后缀名为.c的文件更改为.h的文件

 

二.shell 脚本解决

#!/bin/bash

#http://blog.csdn.net/longxibendi
find ./ -name *.c  | while read i
do
        echo "$i";
        mv $i.c  $i.h
done
 

三.find  xargs 解决


 find ./ -name "*.c" | awk -F "." '{print $2}' | xargs -i -t mv ./{}.c  ./{}.h

 

注意，第三种方案是递归的更改，会更改当前目录下及其子目录下所有匹配文件
