#!/bin/bash
[ $(/usr/local/bin/mysql -umysqluser -pmysqlpwd -h mysqlhost -e "show full processlist" | tee /pathto/plist-`date +%F-%H-%M-%S`.log | wc -l) -lt 10 ] && rm /pathto/plist-`date +%F-%H-%M-%S`.log
