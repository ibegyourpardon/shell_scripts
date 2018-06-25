#!/bin/bash
yum groupinstall "development tools"
yum install -y gcc gcc-c++ autoconf libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libpng libpng-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses curl curl-devel openssl-devel gdbm-devel db4-devel libXpm-devel libX11-devel gd-devel gmp-devel readline-devel libxslt-devel expat-devel xmlrpc-c xmlrpc-c-devel


wget


./configure  \
    --prefix=/usr/local/php  \
    --enable-fpm  \
    --with-curl  \
    --with-openssl  \
    --enable-mbregex  \
    --with-mysql  \
    --with-mysqli  \
    --with-mysql-sock  \
    --enable-pdo  \
    --with-pdo-mysql  \
    --with-pdo-pgsql  \
    --without-pdo-sqlite  \
    --enable-mysqlnd  \
    --with-gd  \
    --enable-gd-native-ttf  \
    --enable-exif  \
    --with-jpeg-dir=/usr/local/jpeg  \
    --with-png-dir=/usr/local/png  \
    --with-freetype-dir=/usr/local/freetype  \
    --enable-gd-jis-conv  \
    --with-gettext  \
    --with-zlib  \
    --enable-zip  \
    --with-bz2  \
    --disable-fileinfo  \
    --enable-xmlreader  \
    --enable-xmlwriter  \
    --with-xmlrpc  \
    --enable-exif  \
    --enable-mbstring  \
    --enable-inline-optimization \
    --disable-fileinfo

whereis php
#/usr/local/bin/php
echo $PATH
#/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
export PATH=/usr/local/php/bin:$PATH
echo $PATH
#/usr/local/php/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
php -v
#PHP 5.6.0 (cli) (built: Sep 10 2014 23:54:43)



