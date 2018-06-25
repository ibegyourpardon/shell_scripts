#!/bin/bash
#author: ibegyourpardon
# install mongodb on ubuntu 14.04
#user must be root
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" >> /etc/apt/sources.list
apt-get update
apt-get -y install mongodb-10gen
