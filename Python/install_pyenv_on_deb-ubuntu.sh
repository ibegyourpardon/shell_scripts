#!/bin/bash
#author:ibegyourpardon
# pyenv on your centos
#dependencies
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev
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
