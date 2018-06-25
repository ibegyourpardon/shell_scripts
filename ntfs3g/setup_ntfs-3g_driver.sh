#!/bin/sh
#http://www.tuxera.com/community/ntfs-3g-download/
wget https://tuxera.com/opensource/ntfs-3g_ntfsprogs-2016.2.22.tgz
tar zxvf ntfs-3g_ntfsprogs-2016.2.22.tgz
cd ntfs-3g_ntfsprogs-2016.2.22
./configure
make
make install
echo "job is done"
echo "use mount -t ntfs-3g /dev/sda1 /mnt/windows  to use ntfs-3g"
echo "write into fstab like  /dev/sda1 /mnt/windows ntfs-3g defaults 0 0"
