#!/bin/bash

CONFIG=$1
WORKDIR=$2

help()
{
	echo "Usage: $0 configfile workingdirectory"
        echo "Ensure to specify the configfile, see example-server.conf"
        echo "Ensure that workingdirectory is exists and empty!"
	exit 10
}

[[ -z $WORKDIR || -z $CONFIG ]] && help
[[ ! -d $WORKDIR ]] && help
[[ -e "$WORKDIR/server.crt" ]] && help 

openssl genrsa -out "$WORKDIR/server.key" 4096

openssl req -new -config "$CONFIG" -key "$WORKDIR/server.key" -out "$WORKDIR/server.csr"
