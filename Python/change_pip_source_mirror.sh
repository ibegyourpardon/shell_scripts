#!/bin/bash
#author: ibegyourpardon
#快速修改pip源为国内镜像，默认使用豆瓣
cd ~/
mkdir .pip
cat>.pip/pip.conf <<EOF
[global] >> .pip/pip.conf
index-url = http://pypi.douban.com/simple >> .pip/pip.conf
EOF
#pipy国内镜像目前有：
#http://pypi.douban.com/  豆瓣
#http://pypi.hustunique.com/  华中理工大学
#http://pypi.sdutlinux.org/  山东理工大学
#http://pypi.mirrors.ustc.edu.cn/  中国科学技术大学
