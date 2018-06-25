#!/bin/bash
#only works on x64 centos
yum install lm_sensors -y
sh -c "yes|sensors-detect"
modprobe i2c-dev
modprobe coretemp
#
echo "use sensors to check"
