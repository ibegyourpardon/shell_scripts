#!/bin/bash
############the codes
yum install -y vim 
yum install -y epel-release 
sudo rpm –import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 
yum repolist 
sudo rpm –import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro 
sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm 
yum repolist 
yum update -y 
yum install -y ffmpeg 
ffmpeg -version
