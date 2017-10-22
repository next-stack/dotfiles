#!/bin/bash

BASEDIR="$(pwd)"

# Git
sudo ln -sfn $BASEDIR/git/gitconfig $HOME/.gitconfig

# Shell
sudo ln -sfn $BASEDIR/shell/bashrc $HOME/.bashrc
sudo ln -sfn $BASEDIR/shell/bash_profile $HOME/.bash_profile
sudo ln -sfn $BASEDIR/shell/bash_aliases $HOME/.bash_aliases
sudo ln -sfn $BASEDIR/shell/bash_logout $HOME/.bash_logout

# Custom Scripts
sudo ln -sfn $BASEDIR/scripts/tunnel.sh /usr/bin/tunnel
sudo ln -sfn $BASEDIR/scripts/srunl.sh /usr/bin/srunl

# Icons
sudo ln -sfn $BASEDIR/icons/ $HOME/.icons

# Guake
sudo ln -sfn $BASEDIR/guake/ $HOME/.gconf/apps/guake

# Atom
sudo ln -sfn $BASEDIR/atom/ $HOME/.atom

# Autostart
sudo rm -rf $HOME/.config/autostart/
sudo ln -sfn $BASEDIR/autostart/ $HOME/.config/autostart

# Pidgin
sudo ln -sfn $BASEDIR/pidgin-purple/ $HOME/.purple

# Numlockx
sudo ln -sfn $BASEDIR/numlockx/numlockx /etc/default/numlockx

# Download VPN settings for science.ru.nl servers
if [ ! -d ./vpn ]; then
  mkdir ./vpn
fi
wget https://gitlab.science.ru.nl/cncz/openvpn/raw/master/openvpn-science.ovpn -P vpn/
