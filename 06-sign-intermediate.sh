#!/bin/bash

CONFIG=$1
CADIR=$2
WORKDIR=$3

help()
{
	echo "Usage: $0 ca_configfile cadirectory intermdiate-directory"
        echo "Ensure that ca config file is exists, see example-ca.conf"
        echo "Ensure your ca directory is valid"
        echo "Ensure that intermediate_directory is exists"
	exit 10
}

[[ -z $WORKDIR || -z $CONFIG || -z $CADIR ]] && help
[[ ! -e "$CONFIG" ]] && help 
[[ ! -e "$CADIR/ca.key" || ! -e "$CADIR/ca.crt" || ! -e "$CADIR/serial" ]] && help 

mkdir -p $WORKDIR/{private,crl,newcerts}
touch $WORKDIR/{index.txt,serial}
echo 1000 > $WORKDIR/serial
echo 1000 > $WORKDIR/crlnumber
openssl ca -days 1825 -in "$WORKDIR/intermediate-ca.csr" -config "$CONFIG" \
	-extensions v3_intermediate_ca -notext -out "$WORKDIR/intermediate-ca.crt"

