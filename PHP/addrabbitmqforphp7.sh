#!/bin/bash

git clone git://github.com/alanxz/rabbitmq-c.git
cd rabbitmq-c
git submodule init
git submodule update
sudo autoreconf -i
./configure --prefix=/usr/local/rabbitmq-c
make
make install


cd ../
git clone https://github.com/pdezwart/php-amqp
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config --with-amqp=/usr/local/rabbitmq-c
make
make install
#
echo "add "
echo "extension=amqp.so"
echo "to php.ini and restart php"