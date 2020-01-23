#!/bin/bash

# Author: M. Erkan Basar
# Website: http://www.mebasar.com
# Email: erkan@mebasar.com
# GitHub: erkanbasar

# Create a symlink to use it with a single command (as shown in Usage).
# sudo ln -sfn /path/to/folder/tunnel.sh /usr/bin/tunnel

usage() {
  echo "=========================== Manual ============================"
  echo "Usage;"
  echo "       tunnel -s <server name> -p <port number>	: Tunnel to the given server with the given port number"
  echo "       tunnel --username <username>	: Set a (new) username."
  echo "       tunnel --servers			: List the servers"
  echo "Shortcuts;"
  echo "       tunnel -a <port number>	: Tunnel to Applejack server with the given port number"
  echo "       tunnel -f <port number>	: Tunnel to Fluttershy server with the given port number"
  echo "==============================================================="
  exit
}

servers () {
  echo "------------------------------------------------------------------"
  echo "Dedicated Servers"
  echo "------------------------------------------------------------------"
  echo "Address		RAM	Disk Space	CPU	Purpose"
  echo "Spitfire	—	—		—	webserver"
  echo "Derpy		—	—		—	dataserver"
  echo "Applejack	515G	3.5T		32	webserver, special purpose, portal"
  echo "------------------------------------------------------------------"
  echo "Pony-servers (computing nodes)"
  echo "------------------------------------------------------------------"
  echo "Address		RAM	Disk Space	CPU 	GPU"
  echo "Blossomforth	256G	1.5T		32	no"
  echo "Cheerilee	256G	1.7T		32	no"
  echo "Dinky	189G	1.5T		16	no"
  echo "Fancypants	512G	1.7T		32	no"
  echo "Featherweight	256G	1.5T		32	no"
  echo "Fluttershy	252G	1.6T		40	no"
  echo "Pipsqueak	256G	1.7T		32	no"
  echo "Rarity		256G	3.5T		40	no"
  echo "Scootaloo	256G	3.5T		40	no"
  echo "Thunderlane	128G	1.6T		32	2 NVIDIA Tesla M40"
  echo "Twist		128G	1.7T		32	1 NVIDIA Tesla M40"
  exit
}

[ $# -eq 0 ] && {
  usage
}

if [ $1 == "--servers" ]; then
  servers

elif [ $1 == "--username" ]; then
  if [ -L $0 ] ; then
    PWDDIR=$(dirname "$(readlink -f $0)")
  else
    PWDDIR=$(dirname $0)
  fi
  sed -i "s/^USERNAME=.*/USERNAME=$2/" $PWDDIR/tunnel.sh
  echo "Username set to $2"
  exit

elif [ $1 == "-a" ]; then
  SERVER="applejack"
  PORT=$2

elif [ $1 == "-f" ]; then
  SERVER="fluttershy"
  PORT=$2

else
  while getopts ":s:p:" opt; do
    case "$opt" in
      s) SERVER=$OPTARG;;
      p) PORT=$OPTARG;;
      *) usage;;
    esac
  done
fi

shift $((OPTIND-1))

USERNAME=

if [ -z "$USERNAME" ] ; then
  echo "ERROR: Username is not defined. Please set a username first."
  echo "Usage: tunnel --username <username>"
  exit
fi

if [ -z "$PORT" ] || [ -z "$SERVER" ]; then
  usage
fi

echo "Tunneling to server $SERVER through the port $PORT by user $USERNAME"
ssh -L $PORT:localhost:$PORT $USERNAME@$SERVER.science.ru.nl
