#!/bin/bash
tar xzf php-5.2.17.tar.gz
cd php-5.2.17
./configure --prefix=/usr/local --with-config-file-path=/usr/local/etc --enable-mbstring --enable-ftp --with-gd --with-jpeg-dir=/usr --with-png-dir=/usr --enable-magic-quotes --with-mysql=/usr/local --with-pear --enable-sockets --with-ttf --with-freetype-dir=/usr --enable-gd-native-ttf --with-zlib --enable-sysvsem --enable-sysvshm --with-libxml-dir=/usr --with-apxs2=/usr/local/apache/bin/apxs --with-curl --with-curlwrappers --with-pdo-mysql
make
make install
make clean
