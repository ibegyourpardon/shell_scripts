#!/bin/bash
yum install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm 
rpm -qa | grep mysql
rpm -qa | grep mariadb
read -p "This script will install percona server 5.6 on this machine.Make sure you have uninstalled mysql or mariadb"
yum install Percona-Server-client-56 Percona-Server-server-56
#mysql_install_db --user=mysql --datadir=/usr/local/mysql/var
#start percona
#mysqld_safe --user=mysql --datadir=/usr/local/mysql/var --defaults-file=/etc/my.cnf
chown -hR mysql:mysql /usr/local/mysql/var

