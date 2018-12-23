#!/bin/bash

printerror () {
    echo "======================== ERROR ========================" >&2
    echo "$1" >&2
    echo "=======================================================" >&2
}

printlog () {
    echo
    echo "---------------------------------------------------------------------------" >&2
    echo "$1"
    echo "---------------------------------------------------------------------------" >&2
}

BASEDIR="$(pwd)"
REVOLTDIR=$HOME/Games/Re-Volt

SYSTEMPKGS="$(cat $BASEDIR/requirements.txt)"

printlog "Installing required system packages"
for package in $SYSTEMPKGS; do
  echo $package...
  sudo apt-get install -y $package || printerror "Unable to install $package"
done

if [ ! -d $REVOLTDIR ]; then
  mkdir $REVOLTDIR
fi

printlog "Downloading the installation script"
if [ ! -f $REVOLTDIR/install_rvgl.py ]; then
  wget https://gitlab.com/yethiel/install_rvgl/raw/master/install_rvgl.py -O $REVOLTDIR/install_rvgl.py || printerror "Unable to download the script!"
fi

# shellcheck source=$HOME/.env/bin/activate
. $HOME/.env/bin/activate

printlog "Initiating installation script"
python $REVOLTDIR/install_rvgl.py
