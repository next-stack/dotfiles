#!/bin/bash

usage() {
  echo "=========================== Manual ============================"
  echo "Usage;"
  echo "       tunnel -s <server name> -p <port number>	: Tunnel to the given server with the given port number"
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
  echo "Fancypants	512G	1.7T		32	no"
  echo "Featherweight	256G	1.5T		32	no"
  echo "Fluttershy	192G	1.7T		32	no"
  echo "Pipsqueak	256G	1.7T		32	no"
  echo "Rarity		256G	3.5T		40	no"
  echo "Scootaloo	256G	3.5T		40	no"
  echo "Thunderlane	128G	1.6T		32	1 NVIDIA Tesla M40"
  echo "Twist		128G	1.7T		32	no"
  exit
}

[ $# -eq 0 ] && {
  usage
}

if [ $1 == "--servers" ]; then
  servers
elif [ $1 == "-a" ]; then
  SERVER="applejack"
  PORT=$2
elif [ $1 == "-f" ]; then
  SERVER="fluttershy"
  PORT=$2
else
  while getopts ":s:p:" o; do
    case "${o}" in
      s)
      SERVER=${OPTARG}
      ;;
      p)
      PORT=${OPTARG}
      ;;
      *)
      usage
      ;;
    esac
  done
fi
shift $((OPTIND-1))

if [ -z "${PORT}" ] || [ -z "${SERVER}" ]; then
  usage
fi

echo "Tunneling to server" ${SERVER} "with the port number" ${PORT}
ssh -L ${PORT}:localhost:${PORT} ebasar@${SERVER}.science.ru.nl
