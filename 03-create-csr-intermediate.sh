#!/bin/bash

CONFIG=$1
WORKDIR=$2

help()
{
	echo "This tool is for generating Intermediate CA Certificate."
	echo "Usage: $0 configfile workingdirectory"
        echo "Ensure to specify the configfile, see example-server.conf"
        echo "Ensure that workingdirectory is exists and empty!"
	exit 10
}

[[ -z $WORKDIR || -z $CONFIG ]] && help
[[ ! -d $WORKDIR ]] && help
[[ -e "$WORKDIR/intermediate-ca.crt" ]] && help 

openssl genrsa -out "$WORKDIR/intermediate-ca.key" 4096

openssl req -new -config "$CONFIG" -key "$WORKDIR/intermediate-ca.key" -out "$WORKDIR/intermediate-ca.csr"
