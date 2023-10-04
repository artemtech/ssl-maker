#!/bin/bash

CONFIG=$1
WORKDIR=$2
CADIR=$3

help()
{
	echo "Usage: $0 serverconfigfile serverdirectory cadirectory"
        echo "Ensure that config file is exists, see example-server.conf"
        echo "Ensure that serverdirectory is exists"
        echo "Ensure your ca directory is valid"
	exit 10
}

[[ -z $WORKDIR || -z $CONFIG || -z $CADIR ]] && help
[[ ! -e "$CONFIG" ]] && help 
[[ ! -e "$CADIR/ca.key" || ! -e "$CADIR/ca.crt" || ! -e "$CADIR/serial" ]] && help 

openssl x509 -req -days 365 -in "$WORKDIR/server.csr" -extfile "$CONFIG" -extensions v3_req -CA "$CADIR/ca.crt" -CAkey "$CADIR/ca.key" -CAserial "$CADIR/serial" -CAcreateserial -out "$WORKDIR/server.crt"

# concat server + ca to bundle pem
cat $WORKDIR/server.crt $CADIR/ca.crt >> $WORKDIR/server-bundle.pem
