#!/bin/bash

BASEDIR="$(pwd)"

echo
echo "--------------------------------------------------------"
echo "Setting up symlinks"
echo "--------------------------------------------------------"

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
sudo ln -sfn $BASEDIR/scripts/chats.sh /usr/bin/chats

# Icons
sudo ln -sfn $BASEDIR/icons/ $HOME/.icons

# Guake
#sudo ln -sfn $BASEDIR/guake/ $HOME/.gconf/apps/guake

# Redshift
sudo ln -sfn $BASEDIR/redshift/redshift.conf $HOME/.config/redshift.conf

# Atom
sudo ln -sfn $BASEDIR/atom/ $HOME/.atom
bash $BASEDIR/scripts/atompkg.sh -i

# Autostart
sudo rm -rf $HOME/.config/autostart/
sudo ln -sfn $BASEDIR/autostart/ $HOME/.config/autostart

# Pidgin
sudo ln -sfn $BASEDIR/pidgin-purple/ $HOME/.purple

# Numlockx
sudo ln -sfn $BASEDIR/numlockx/numlockx /etc/default/numlockx

echo
echo "--------------------------------------------------------"
echo "Creating OpenVPN scripts"
echo "--------------------------------------------------------"
if [ ! -d $BASEDIR/vpn ]; then
  mkdir $BASEDIR/vpn
fi
OVPNFILE=$BASEDIR/vpn/openvpn-science-ru-nl.ovpn
LOGINCONF=$BASEDIR/vpn/openvpn-science-ru-nl.conf
wget https://gitlab.science.ru.nl/cncz/openvpn/raw/master/openvpn-science.ovpn -O $OVPNFILE
if [ ! -f $LOGINCONF ]; then
  echo "< username >@science.ru.nl" >> $LOGINCONF
fi
if [ -f $LOGINCONF ]; then
  echo "" >> $OVPNFILE
  echo "auth-user-pass $LOGINCONF" >> $OVPNFILE
fi

echo
echo "--------------------------------------------------------"
echo "Creating Python virtual environment '.env' into $HOME"
echo "--------------------------------------------------------"
PYTHON=$(which python3)
echo "Using version $($PYTHON --version 2>&1)"
PKGS_PATH=$BASEDIR/python-env/python-packages.txt
echo "Installing Python packages given in $PKGS_PATH"
echo
virtualenv --python=$PYTHON $HOME/.env
source $HOME/.env/bin/activate
pip install --upgrade pip
pip install -r $PKGS_PATH
deactivate
