sudo yum install yum-cron
##for centos 7
$ sudo systemctl enable yum-cron.service 
$ sudo systemctl start yum-cron.service 
$ sudo systemctl status yum-cron.service
##for centos 6
$ sudo chkconfig yum-cron on 
$ sudo service yum-cron start
##vi /etc/yum/yum-cron.conf 和 /etc/yum/yum-cron-hourly.conf

apply_updates = yes

#可选
email_from = root@localhost

#####!!!如果不想更新内核kernel
#for 7 add

exclude=kernel*

#for 6  add

YUM_PARAMETER=kernel*

