#!/bin/bash
#3.2.x use python2.6
wget http://yum.baseurl.org/download/3.2/yum-3.2.29.tar.gz
tar xvf yum-3.2.29.tar.gz
cd yum-3.2.29
touch /etc/yum.conf
yummain.py install yum

yum check-update
yum update
yum clean all
