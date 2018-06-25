#!/bin/sh
echo input the the database dir \(for example /var/lib/mysql/blog     /usr/local/mysql/var/bbs\):
read databasedir
cd $databasedir
#list
ls -lh | grep "frm" | awk '{print $9}' > /tmp/myisam2innodb.txt
#add end
sed -e 's/\.frm/\ type=innodb;/g' /tmp/myisam2innodb.txt > /tmp/myisam2innodb.sql
#add head
sed -i 's/^/alter\ table\ /' /tmp/myisam2innodb.sql
#echo mysqlusername
#read mysqlusername
#echo mysqlpassword
#read mysqlpassword
#echo databasename
#read databasename
#mysqldump -u$mysqlusername -p$mysqlpassword $databasename < /tmp/myisam2innodb.sql
echo use source /tmp/myisam2innodb.sql to myisam2innodb
#rm -rf /tmp/myisam2innodb.sql
rm -rf /tmp/myisam2innodb.txt

