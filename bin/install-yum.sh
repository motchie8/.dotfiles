#!/bin/bash

# install development tools
sudo yum groupinstall "Development Tools" -y
# install libraries for pyenv and neovim 
sudo yum update -y && sudo yum install git xsel zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel \
openssl-devel xz xz-devel libffi-devel make libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip gettext patch ctags -y

# install pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
echo '
export PATH="$HOME/.pyenv/bin:$PATH"
export PYENV_PATH=$HOME/.pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
' >> ~/.bashrc
source ~/.bashrc

# create envs for neovim by pyenv-virtualenv
pyenv install 2.7.15
pyenv install 3.6.6
pyenv virtualenv 2.7.15 neovim2
pyenv virtualenv 3.6.6 neovim3

# setup python libs for each env
pyenv rehash
source ~/.bash_profile
pyenv activate neovim2
pip install --upgrade pip
pip install pynvim
pip install neovim
pyenv deactivate
pyenv activate neovim3
pip install --upgrade pip
pip install pynvim
pip install neovim
pip install -r ~/.dotfiles/python/requirements.txt
# create symbolic links
ln -s `pyenv which flake8` ~/.pyenv/bin/flake8
#ln -s `pyenv which flake8-import-order` ~/.pyenv/bin/flake8-import-order
ln -s `pyenv which autopep8` ~/.pyenv/bin/autopep8
#ln -s `pyenv which jedi` ~/.pyenv/bin/jedi
ln -s `pyenv which isort` ~/.pyenv/bin/isort

# install neovim
cd ~/.dotfiles
git clone https://github.com/neovim/neovim
cd neovim
make clean
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
sudo ln -s -T /usr/local/bin/nvim /usr/bin/nvim

# setup neovim color schema
cd ~/.dotfiles
git clone https://github.com/cocopon/iceberg.vim

# install gtags
wget http://tamacom.com/global/global-6.6.3.tar.gz
tar xzvf global-6.6.3.tar.gz
cd global-6.6.3/
./configure
make CFLAGS="-std=gnu99"
sudo make install
pip install pygments

# symbolic links
ln -s -T ~/.dotfiles/vim ~/.vim
ln -s -T ~/.dotfiles/.vimrc ~/.vimrc
mkdir -p ~/.config/nvim
ln -s -T ~/.vimrc ~/.config/nvim/init.vim
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
mkdir -p ~/.config/nvim/colors
ln -s -T ~/.dotfiles/iceberg.vim/colors/iceberg.vim ~/.config/nvim/colors/iceberg.vim
ln -s -T ~/.dotfiles/.globalrc ~/.globalrc

source ~/.bashrc

