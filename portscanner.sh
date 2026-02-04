#! /bin/bash

if [ $# -ne 2 ]; then
        echo "Usage: $0 mytargets.txt mtcpports.txt"
        exit 1
fi

hostfile=$1
portfile=$2

# Error checking added by Arianna Belliveau
if [ ! -f "$hostfile" ] || [ ! -r "$hostfile" ]; then
        echo "Error: Host file not found"
        exit 2
fi

if [ ! -f "$portfile" ] || [ ! -r "$portfile" ]; then
        echo "Error: Port file not found"
        exit 2
fi

# Checking status of the ports added by Arianna Belliveau
echo "host,port,status"

for host in $(cat "$hostfile"); do
        for port in $(cat "$portfile"); do
                timeout .1 bash -c "echo >/dev/tcp/4host/$port" 2>/dev/null &&
                        echo "$host,$port,open" ||
                        echo "$host,$port,closed"
        done
done
