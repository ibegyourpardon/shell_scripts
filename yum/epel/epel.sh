#!/bin/bash
##   2017-03-16
## https://github.com/ibegyourpardon/sa_tools
##email: yiziyint@gmail.com
##ibegyourpardon
##CentOS 6 & 7

#http://mirrors.sohu.com/fedora-epel/
rpm -Uvh http://mirrors.sohu.com/fedora-epel/epel-release-latest-6.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6

rpm -Uvh http://mirrors.sohu.com/fedora-epel/epel-release-latest-7.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7


#http://download.fedoraproject.org/pub/epel/
rpm -Uvh http://ftp.riken.jp/Linux/fedora/epel//epel-release-latest-6.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6

rpm -Uvh http://ftp.riken.jp/Linux/fedora/epel//epel-release-latest-7.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7


#http://mirrors.aliyun.com/epel/
rpm -Uvh http://mirrors.aliyun.com/epel/epel-release-latest-6.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6

rpm -Uvh http://mirrors.aliyun.com/epel/epel-release-latest-7.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
