#!/bin/bash
#author: feiandxs
#only works on CentOS 7

#set timezone
Echo_Blue "Setting timezone..."
rm -rf /etc/localtime
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#set ntp
Echo_Blue "[+] Installing ntp..."
yum install -y ntp
ntpdate -u pool.ntp.org
date

#disable selinux
if [ -s /etc/selinux/config ]; then
    sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
fi


#Xen_Hwcap_Setting
if [ -s /etc/ld.so.conf.d/libc6-xen.conf ]; then
    sed -i 's/hwcap 1 nosegneg/hwcap 0 nosegneg/g' /etc/ld.so.conf.d/libc6-xen.conf
fi


#Check_Hosts()

if grep -Eqi '^127.0.0.1[[:space:]]*localhost' /etc/hosts; then
    echo "Hosts: ok."
else
    echo "127.0.0.1 localhost.localdomain localhost" >> /etc/hosts
fi
ping -c1 www.baidu.com
if [ $? -eq 0 ] ; then
    echo "DNS...ok"
else
    echo "DNS...fail"
    echo -e "nameserver 208.67.220.220\nnameserver 114.114.114.114" > /etc/resolv.conf
fi

#RHEL_Modify_Source()

#Echo_Blue "[+] Yum installing dependent packages..."
for packages in iptables rsyslog make cmake gcc gcc-c++ gcc-g77 flex bison file libtool libtool-libs autoconf kernel-devel patch wget libjpeg libjpeg-devel libpng libpng-devel libpng10 libpng10-devel gd gd-devel libxml2 libxml2-devel zlib zlib-devel glib2 glib2-devel unzip tar bzip2 bzip2-devel libevent libevent-devel ncurses ncurses-devel curl curl-devel libcurl libcurl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel vim-minimal gettext gettext-devel ncurses-devel gmp-devel pspell-devel unzip libcap diffutils ca-certificates net-tools libc-client-devel psmisc libXpm-devel git-core c-ares-devel libicu-devel libxslt libxslt-devel;
do yum -y install $packages; done

#download files
wget http://tengine.taobao.org/download/tengine-2.2.0.tar.gz
tar zxvf tengine-2.2.0.tar.gz
cd tengine-2.2.0

groupadd www
useradd -s /sbin/nologin -g www www


./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_v2_module --with-http_gzip_static_module --with-ipv6 --with-http_sub_module
make && make install


#conf
\cp conf/nginx.conf /usr/local/nginx/conf/nginx.conf
\cp conf/rewrite/dabr.conf /usr/local/nginx/conf/dabr.conf
\cp conf/rewrite/discuz.conf /usr/local/nginx/conf/discuz.conf
\cp conf/rewrite/sablog.conf /usr/local/nginx/conf/sablog.conf
\cp conf/rewrite/typecho.conf /usr/local/nginx/conf/typecho.conf
\cp conf/rewrite/typecho2.conf /usr/local/nginx/conf/typecho2.conf
\cp conf/rewrite/wordpress.conf /usr/local/nginx/conf/wordpress.conf
\cp conf/rewrite/discuzx.conf /usr/local/nginx/conf/discuzx.conf
\cp conf/rewrite/none.conf /usr/local/nginx/conf/none.conf
\cp conf/rewrite/wp2.conf /usr/local/nginx/conf/wp2.conf
\cp conf/rewrite/phpwind.conf /usr/local/nginx/conf/phpwind.conf
\cp conf/rewrite/shopex.conf /usr/local/nginx/conf/shopex.conf
\cp conf/rewrite/dedecms.conf /usr/local/nginx/conf/dedecms.conf
\cp conf/rewrite/drupal.conf /usr/local/nginx/conf/drupal.conf
\cp conf/rewrite/ecshop.conf /usr/local/nginx/conf/ecshop.conf
\cp conf/pathinfo.conf /usr/local/nginx/conf/pathinfo.conf
\cp conf/enable-php.conf /usr/local/nginx/conf/enable-php.conf
\cp conf/enable-php-pathinfo.conf /usr/local/nginx/conf/enable-php-pathinfo.conf
\cp conf/proxy-pass-php.conf /usr/local/nginx/conf/proxy-pass-php.conf
\cp conf/enable-ssl-example.conf /usr/local/nginx/conf/enable-ssl-example.conf
\cp conf/enable-php5.2.17.conf /usr/local/nginx/conf/enable-php5.2.17.conf



mkdir -p /home/wwwlogs
chmod 777 /home/wwwlogs
chown -R www:www /home/wwwlogs




\cp init.d/init.d.nginx /etc/init.d/nginx
chmod +x /etc/init.d/nginx
