#!/bin/bash

WORKDIR=$1

help()
{
	echo "Usage: $0 workingdirectory"
        echo "Ensure that workingdirectory is exists and empty!"
	exit 10
}

[[ -z $WORKDIR ]] && help
[[ ! -d $WORKDIR ]] && help
[[ -e "$WORKDIR/ca.key" ]] && help 

openssl genrsa -out "$WORKDIR/ca.key" 4096
