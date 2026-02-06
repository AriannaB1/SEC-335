  GNU nano 8.3                                                          portscanner2.sh                                                                    
#! /bin/bash

# Check if the correct number of arguments is passed
if [ $# -ne 2 ]; then
    echo "Usage: $0 <network_prefix> <port>"
    exit 1
fi

network_prefix=$1
port=$2

# Scan each host in the range .1 through .254
echo "host,port,status"

for i in {1..254}; do
    ip="$network_prefix.$i"
    
    # Timeout set to 0.1s to quickly check if port is open
    timeout 0.1 bash -c "echo >/dev/tcp/$ip/$port" 2>/dev/null && \
        echo "$ip,$port,open" || \
        echo "$ip,$port,closed"
done
