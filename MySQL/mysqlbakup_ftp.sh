#!/bin/bash
###settings####
dbuser=数据库用户
dbpassword=数据库密码
tarfiles_path=http文件目录
ftpserver="server port"
ftpuser=ftp用户
ftppassword=ftp密码
blocksize=10M

###settings end####
count()
{
local i=0
local d
for d in $*
do
count=$[$count+1]
done
echo $count
}
backupdir=/wf_data_backup
tmpbackupdir=/tmp$backupdir
rm -r -f $tmpbackupdir
mkdir $tmpbackupdir
chmod 600 $tmpbackupdir
mysqldump -u$dbuser -p$dbpassword --all-databases | gzip |split -d -b $blocksize - $tmpbackupdir/mysql.sql.gz.
mysqlfiles=`ls -Q $tmpbackupdir/|grep '^"mysql\.sql\.gz\..*'`
touch $tmpbackupdir/count-mysql-`count $mysqlfiles`
cd $tarfiles_path
tar -czf - .|split -d -b $blocksize -  ${tmpbackupdir}/files.tar.gz.
files=`ls -Q $tmpbackupdir/ |grep '^"files\.tar\.gz\..*'`
touch $tmpbackupdir/count-files-`count $files`
remote_path=/`date +%y-%m-%d-%H`
upload ()
{
ftp -n $ftpserver >/dev/null << END
user $ftpuser $ftppassword
binary
hash
mkdir $remote_path
cd $remote_path
lcd $tmpbackupdir
prompt
put $1
bye
END
}

upload count-files-`count $files`
upload count-mysql-`count $mysqlfiles`
for f in ${files[@]}
do
echo upload $f
upload $f
done

for f in ${mysqlfiles[@]}
do
echo upload $f
upload $f
done

rm -f -r $tmpbackupdir
