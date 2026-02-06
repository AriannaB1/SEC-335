#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <network_prefix> <dns_server>"
    exit 1
fi

NETWORK=$1
DNS_SERVER=$2

for i in $(seq 1 254); do
    IP="$NETWORK.$i"
    nslookup $IP $DNS_SERVER
done
