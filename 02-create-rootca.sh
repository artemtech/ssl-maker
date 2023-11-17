#!/bin/bash

CONFIG=$1
WORKDIR=$2

help()
{
	echo "Usage: $0 configfile workingdirectory"
        echo "Ensure to specify the configfile, see example-ca.conf"
        echo "Ensure that workingdirectory is exists!"
	exit 10
}

[[ -z $WORKDIR || -z $CONFIG ]] && help
[[ ! -d $WORKDIR ]] && help
[[ -e "$WORKDIR/ca.crt" ]] && help 

mkdir -p $WORKDIR/{private,crl,newcerts}
touch $WORKDIR/{index.txt,serial}
echo "1000" > $WORKDIR/serial

openssl req -verbose -config "$CONFIG" -new -x509 -extensions v3_ca -sha512 -key "$WORKDIR/ca.key" -out "$WORKDIR/ca.crt"

