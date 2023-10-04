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

openssl req -verbose -config "$CONFIG" -new -key "$WORKDIR/ca.key" -sha512 -out "$WORKDIR/ca.csr"

openssl ca -config "$CONFIG" -notext -out "$WORKDIR/ca.crt" -keyfile "$WORKDIR/ca.key" -verbose -selfsign -md sha512 -infiles "$WORKDIR/ca.csr"

#openssl req -x509 -new -config "$CONFIG" -days 3650 -nodes -key "$WORKDIR/ca.key" -sha512 -verbose -out "$WORKDIR/ca.crt"
