#!/bin/bash
#disable the fastest mirror plugin which didn't work that well
sed -i 's/enabled=1/enabled=0/g' /etc/yum/pluginconf.d/fastestmirror.conf
