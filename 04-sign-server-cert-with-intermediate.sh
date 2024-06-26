#!/bin/bash

CONFIG=$1
WORKDIR=$2
CADIR=$3

help()
{
	echo "Usage: $0 server-configfile server-directory intermediate-ca-directory"
        echo "Ensure that config file is exists, see example-server.conf"
        echo "Ensure that serverdirectory is exists"
        echo "Ensure your intermediate ca directory is valid"
	exit 10
}

[[ -z $WORKDIR || -z $CONFIG || -z $CADIR ]] && help
[[ ! -e "$CONFIG" ]] && help 
[[ ! -e "$CADIR/intermediate-ca.key" || ! -e "$CADIR/intermediate-ca.crt" || ! -e "$CADIR/serial" ]] && help 

days=$(grep days $CONFIG | awk -F '=' '{print $2}')
openssl x509 -req -days $days -in "$WORKDIR/server.csr" -extfile "$CONFIG" -extensions v3_req -CA "$CADIR/intermediate-ca.crt" -CAkey "$CADIR/intermediate-ca.key" -CAserial "$CADIR/serial" -CAcreateserial -out "$WORKDIR/server.crt"

