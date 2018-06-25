#!/bin/bash

echo "============================nginx install================================="
yum -y install pcre-devel openssl-devel
wget http://nginx.org/download/nginx-1.11.10.tar.gz
tar zxvf nginx-1.11.10.tar.gz
cd nginx-1.11.10

./configure --user=www \
            --group=www \
            --prefix=/usr/local/nginx \
            --with-http_stub_status_module \
            --with-http_ssl_module \
            --with-http_gzip_static_module \
            --with-http_spdy_module \
            --with-http_v2_module \
            --with-http_gzip_static_module \
            --with-ipv6 \
            --with-http_sub_module \
            --with-syslog \
            --with-http_sysguard_module \
            --with-http_realip_module


make && make install



rm -f /usr/local/nginx/conf/nginx.conf
cd $cur_dir
cp conf/nginx.conf /usr/local/nginx/conf/nginx.conf

sed -i 's/www.lnmp.org/'$domain'/g' /usr/local/nginx/conf/nginx.conf

rm -f /usr/local/nginx/conf/fcgi.conf
cp conf/fcgi.conf /usr/local/nginx/conf/fcgi.conf

echo "============================nginx install completed================================="