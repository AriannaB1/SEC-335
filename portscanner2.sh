  GNU nano 8.3                                                          portscanner2.sh                                                                    
#! /bin/bash

# Check if the correct number of arguments is passed
if [ $# -ne 2 ]; then
    echo "Usage: $0 <network_prefix> <port>"
    exit 1
fi

network_prefix=$1
port=$2

# Validate the port (should be a number between 1 and 65535)
if ! [[ "$port" =~ ^[0-9]+$ ]] || [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]; then
    echo "Error: Invalid port number. Please provide a valid port between 1 and 65535."
    exit 2
fi

# Validate the network prefix (should be in the format X.X.X, where X is a number)
if ! [[ "$network_prefix" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Error: Invalid network prefix. Please provide a valid network prefix like 10.0.5."
    exit 3
fi

# Scan each host in the range .1 through .254
echo "host,port,status"

for i in {1..254}; do
    ip="$network_prefix.$i"
    
    # Timeout set to 0.1s to quickly check if port is open
    timeout 0.1 bash -c "echo >/dev/tcp/$ip/$port" 2>/dev/null && \
        echo "$ip,$port,open" || \
        echo "$ip,$port,closed"
done
