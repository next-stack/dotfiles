#!/bin/bash

usage() {
  echo "=========================== Manual ============================"
  echo "Usage;"
  echo "       chats -r : Run the chat programs"
  echo "       chats -k : Kill all the chat programs"
  echo "==============================================================="
  exit
}

[ $# -eq 0 ] && {
  usage
}

if [ $1 == "-r" ]; then
  skypeforlinux &> /dev/null
  pidgin &
  slack --disable-gpu -u &> /dev/null

elif [ $1 == "-k" ]; then
  killall -9 skypeforlinux
  killall -9 pidgin
  killall -9 slack

else
  usage

fi
