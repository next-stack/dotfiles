#!/bin/bash

printerror () {
    echo "======================== ERROR ========================" >&2
    echo "$1" >&2
    echo "=======================================================" >&2
}

echo
echo "---------------------------------------------------------------------------"
echo "Updating Aptitude package manager..."
echo "---------------------------------------------------------------------------"
sudo apt-get update

SYSTEMPKGS="$(cat system-packages.txt)"

for package in $SYSTEMPKGS; do

  echo
  echo "---------------------------------------------------------------------------"
  echo "Installing $package"
  echo "---------------------------------------------------------------------------"

  if ! sudo apt-get -qq install $package; then

    if [[ $package = "tlp" ]]; then
      sudo apt-get remove laptop-mode-tools
      sudo add-apt-repository -y ppa:linrunner/tlp
      sudo apt-get update

    elif [[ $package = "spotify-client" ]]; then
      # source: https://www.spotify.com/nl/download/linux/
      sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410
      echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
      sudo apt-get update

    elif [[ $package = "skypeforlinux" ]]; then
      # source: https://askubuntu.com/questions/887389/how-to-install-skype-for-linux-in-ubuntu-16-04-via-console-only/964195
      sudo apt-get install -y apt-transport-https
      curl https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add -
      echo "deb https://repo.skype.com/deb stable main" | sudo tee /etc/apt/sources.list.d/skypeforlinux.list
      sudo apt-get update

    fi

    sudo apt-get install -y $package || printerror "Unable to install $package"

  else
    echo "Already installed"

  fi

done

DEBPKGS=$HOME/Downloads/deb_packages

if [ ! -d $DEBPKGS ]; then
  mkdir $DEBPKGS
fi

echo
echo "---------------------------------------------------------------------------"
echo "Downloading Google Chrome (See https://www.google.com/chrome/browser/desktop/index.html)"
echo "---------------------------------------------------------------------------"
if [ ! -f $DEBPKGS/google-chrome.deb ]; then
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O $DEBPKGS/google-chrome.deb || printerror "Unable to download Google Chrome"
else
  echo "Already downloaded"
fi

echo
echo "---------------------------------------------------------------------------"
echo "Downloading Atom (See https://atom.io/)"
echo "---------------------------------------------------------------------------"
if [ ! -f $DEBPKGS/atom.deb ]; then
  wget https://atom.io/download/deb -O $DEBPKGS/atom.deb || printerror "Unable to download Atom"
else
  echo "Already downloaded"
fi

echo
echo "---------------------------------------------------------------------------"
echo "Downloading WhatsApp-Desktop (See https://github.com/Enrico204/Whatsapp-Desktop)"
echo "---------------------------------------------------------------------------"
if [ ! -f $DEBPKGS/whatsapp-desktop.deb ]; then
  wget https://github.com/Enrico204/Whatsapp-Desktop/releases/download/v0.3.13/whatsapp-desktop_0.3.13-1_amd64.deb -O $DEBPKGS/whatsapp-desktop.deb || printerror "Unable to download Whatsapp-Desktop"
else
  echo "Already downloaded"
fi

echo
echo "---------------------------------------------------------------------------"
echo "Downloading Slack (See https://slack.com/downloads/linux)"
echo "---------------------------------------------------------------------------"
if [ ! -f $DEBPKGS/slack-desktop.deb ]; then
  wget https://downloads.slack-edge.com/linux_releases/slack-desktop-2.8.2-amd64.deb -O $DEBPKGS/slack-desktop.deb || printerror "Unable to download Slack"
else
  echo "Already downloaded"
fi

echo
echo "---------------------------------------------------------------------------"
echo "Downloading Keybase (See https://keybase.io/docs/the_app/install_linux)"
echo "---------------------------------------------------------------------------"
if [ ! -f $DEBPKGS/keybase.deb ]; then
  wget https://prerelease.keybase.io/keybase_amd64.deb -O $DEBPKGS/keybase.deb || printerror "Unable to download Keybase"
else
  echo "Already downloaded"
fi

echo
echo "---------------------------------------------------------------------------"
echo "Installing downloaded .deb packages under $DEBPKGS/"
echo "---------------------------------------------------------------------------"
sudo dpkg -i $DEBPKGS/*.deb || printerror "Unable to install dowloaded .deb packages"

echo
echo "---------------------------------------------------------------------------"
echo "Installing the missing dependencies (if there is any)"
echo "---------------------------------------------------------------------------"
sudo apt-get install -f

echo
while true; do
  read -p "Do you want to remove the downloaded .deb packages? [Y/n]: " yn
  case $yn in
    [Nn]* ) break;;
    * ) rm -rf $DEBPKGS; break;;
  esac
done

echo
echo "---------------------------------------------------------------------------"
echo "Bootstrapping"
echo "---------------------------------------------------------------------------"
bash bootstrap.sh
