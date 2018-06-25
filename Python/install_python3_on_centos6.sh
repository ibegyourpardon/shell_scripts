#!/bin/bash
#author: ibegyourpardon@github
#install dependencies
yum -y install sqlite-devel openssl-devel wget make automake gcc gcc-c++ kernel-devel zlib zlib-devel openssl openssl-devel readline readline-devel

#download python
wget http://file.mageface.com/download/python/python/Python-3.5.1.tgz
wget http://file.mageface.com/download/python/setuptools/setuptools-21.0.0.tar.gz
wget http://file.mageface.com/download/python/pip/pip-8.1.1.tar.gz

#install python
tar zxvf Python-3.5.1.tgz
cd Python-3.5.1
./configure
make
make install

#替换系统默认的python同时保持 yum 能正常使用
rm -f /usr/bin/python
ln -s /usr/local/bin/python3.5 /usr/bin/python
sed -i s/python/python2.6/g /usr/bin/yum
sed -i s/python2.6/python2.6/g /usr/bin/yum

# install setup tools
cd ../
tar zxvf setuptools-21.0.0.tar.gz
cd setuptools-21.0.0
/usr/local/bin/python3.5 setup.py install

#install pip
cd ../
tar zxvf setuptools-21.0.0.tar.gz
cd setuptools-21.0.0
/usr/local/bin/python3.5 setup.py install
