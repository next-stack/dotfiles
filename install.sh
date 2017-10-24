#!/bin/bash

echo
echo "------------------------"
echo "Updating Aptitude package manager..."
echo "------------------------"
sudo apt-get update

INSTALL_PKGS="$(cat packages.system)"

for package in $INSTALL_PKGS; do

  echo
  echo "------------------------"
  echo "Installing $package"
  echo "------------------------"

  if ! sudo apt-get -qq install $package; then

    if [[ $package = "spotify-client" ]]; then
        # source: https://www.spotify.com/nl/download/linux/
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410
        echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
        sudo apt-get update
        sudo apt-get install -y spotify-client

    elif [[ $package = "skypeforlinux" ]]; then
        # source: https://askubuntu.com/questions/887389/how-to-install-skype-for-linux-in-ubuntu-16-04-via-console-only/964195
        sudo apt-get install -y apt-transport-https
        curl https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add -
        echo "deb https://repo.skype.com/deb stable main" | sudo tee /etc/apt/sources.list.d/skypeforlinux.list
        sudo apt update
        sudo apt install skypeforlinux

    else
      sudo apt-get install -y $package
    fi

  else
    echo "Already installed"
  fi

done

DEBPKGS=$HOME/Downloads/deb_packages

if [ ! -d $DEBPKGS ]; then
  mkdir $DEBPKGS
fi

echo
echo "------------------------"
echo "Downloading Google Chrome (See https://www.google.com/chrome/browser/desktop/index.html)"
echo "------------------------"
if [ ! -f $DEBPKGS/google-chrome.deb ]; then
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O $DEBPKGS/google-chrome.deb
else
  echo "Already downloaded"
fi

echo
echo "------------------------"
echo "Downloading Atom (See https://atom.io/)"
echo "------------------------"
if [ ! -f $DEBPKGS/atom.deb ]; then
  wget https://atom.io/download/deb -O $DEBPKGS/atom.deb
else
  echo "Already downloaded"
fi

echo
echo "------------------------"
echo "Downloading WhatsApp Desktop (See https://github.com/Enrico204/Whatsapp-Desktop)"
echo "------------------------"
if [ ! -f $DEBPKGS/whatsapp-desktop.deb ]; then
  wget https://github.com/Enrico204/Whatsapp-Desktop/releases/download/v0.3.13/whatsapp-desktop_0.3.13-1_amd64.deb -O $DEBPKGS/whatsapp-desktop.deb
else
  echo "Already downloaded"
fi

echo
echo "------------------------"
echo "Downloading Slack (See https://slack.com/downloads/linux)"
echo "------------------------"
if [ ! -f $DEBPKGS/slack-desktop.deb ]; then
  wget https://downloads.slack-edge.com/linux_releases/slack-desktop-2.8.2-amd64.deb -O $DEBPKGS/slack-desktop.deb
else
  echo "Already downloaded"
fi

echo
echo "------------------------"
echo "Downloading keybase (See https://keybase.io/docs/the_app/install_linux)"
echo "------------------------"
if [ ! -f $DEBPKGS/keybase.deb ]; then
  wget https://prerelease.keybase.io/keybase_amd64.deb -O $DEBPKGS/keybase.deb
else
  echo "Already downloaded"
fi

echo
echo "------------------------"
echo "Installing Downloaded .deb packages under $DEBPKGS/"
echo "------------------------"
sudo dpkg -i $DEBPKGS/*.deb

echo
echo "------------------------"
echo "Installing the missing dependencies (if there is any)"
echo "------------------------"
sudo apt-get install -f
