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

printlog "Updating Aptitude package manager..."
sudo apt-get update

BASEDIR="$(pwd)"
SYSTEMPKGS="$(cat setup/apt-packages.txt)"
DEBPKGS="setup/deb-packages.txt"

for package in $SYSTEMPKGS; do

  printlog "Installing $package"

  if ! which $package > /dev/null; then

    if [[ $package = "tlp" ]]; then
      sudo apt-get remove laptop-mode-tools
      sudo add-apt-repository -y ppa:linrunner/tlp
      sudo apt-get update

    elif [[ $package = "spotify-client" ]]; then
      # source: https://www.spotify.com/download/linux/
      curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
      echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
      sudo apt-get update

    elif [[  $package = "timeshift" ]]; then
      sudo add-apt-repository -y ppa:teejee2008/ppa
      sudo apt-get update

    elif [[  $package = "heroku" ]]; then
      curl https://cli-assets.heroku.com/install.sh | sudo sh
      continue

    fi

    sudo apt-get install -y $package || printerror "Unable to install $package"

  else
    echo "Already installed"

  fi

done

DEBPATHS=$HOME/Downloads/deb_packages

if [ ! -d $DEBPATHS ]; then
  mkdir $DEBPATHS
fi

printlog "Downloading .deb packages into $DEBPATHS/"
while IFS=' ' read -r url name
do
    wget $url -O $DEBPATHS/$name || printerror "Unable to download $name"
done < "$DEBPKGS"

printlog "Installing downloaded .deb packages under $DEBPATHS/"
sudo dpkg -i $DEBPATHS/*.deb || printerror "Unable to install dowloaded .deb packages"

printlog "Installing the missing dependencies (if there is any)"
sudo apt-get install -f

echo
while true; do
  read -p "Do you want to remove the downloaded .deb packages? [Y/n]: " yn
  case $yn in
    [Nn]* ) break;;
    * ) rm -rf $DEBPATHS; break;;
  esac
done

printlog "Updating & Upgrading & Autoremoving"
sudo apt-get update
sudo apt-get upgrade
sudo apt-get autoremove

printlog "Bootstrapping"
bash setup/bootstrap.sh

printlog "Creating Python virtual environment '.env' into $HOME"
PYTHON=$(which python3)
echo "Using version $($PYTHON --version 2>&1)"
PKGS_PATH=$BASEDIR/python-env/python-packages.txt
echo "Installing Python packages given in $PKGS_PATH"
echo
virtualenv --system-site-packages --python=$PYTHON $HOME/.env
# shellcheck source=$HOME/.env/bin/activate
source $HOME/.env/bin/activate
pip install --upgrade pip
pip install -r $PKGS_PATH
deactivate

GAMESDIR=$HOME/Games
if [ ! -d $GAMESDIR ]; then
  mkdir $GAMESDIR
fi

echo
while true; do
  read -p "Do you want to install Re-Volt? [Y/n]: " yn
  case $yn in
    [Nn]* ) break;;
    * ) bash $BASEDIR/re-volt/install.sh; break;;
  esac
done
