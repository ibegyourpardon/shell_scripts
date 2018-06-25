#!/bin/sh
echo 使用时要找到 MySQL 要修复的库所在的物理目录，所以这确实是个很蠢的脚本
echo input the the database dir \(for example /var/lib/mysql/blog     /usr/local/mysql/var/bbs\):
read databasedir
cd $databasedir
#list
ls -lh | grep "frm" | awk '{print $9}' > /tmp/repair.txt
#add end
sed -e 's/\.frm/\ use_frm;/g' /tmp/repair.txt > /tmp/repair.sql
#add head
sed -i 's/^/repair\ table\ /' /tmp/repair.sql
echo use source /tmp/repair.sql to repair
rm -rf /tmp/repair.txt
