#!/bin/bash
#author:ibegyourpardon
# pyenv on your centos
#dependencies
yum install zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel
####
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
####
echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
####
exec $SHELL
##
echo 'pyenv install --list'
echo 'pyenv install xxxx'
echo 'pyenv global xxxx'
