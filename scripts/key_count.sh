#!/bin/bash

# Check if required arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <password> <ip> <port>"
    exit 1
fi

PASSWORD="$1"
IP="$2"
PORT="$3"
TOTAL_KEY_COUNT=0

# Get list of master nodes
MASTER_NODES=$(redis-cli -a "$PASSWORD" -h "$IP" -p "$PORT" cluster nodes | grep 'master' | awk '{print $2}')

# Loop through master nodes and get key count
for NODE in $MASTER_NODES; do
    HOST=$(echo "$NODE" | cut -d ':' -f 1)
    PORT=$(echo "$NODE" | cut -d ':' -f 2)
    KEY_COUNT=$(redis-cli -a "$PASSWORD" -h "$HOST" -p "$PORT" dbsize)
    TOTAL_KEY_COUNT=$((TOTAL_KEY_COUNT + KEY_COUNT))
    echo "Master Node: $HOST:$PORT, Key Count: $KEY_COUNT"
done

echo "Total Key Count across all master nodes: $TOTAL_KEY_COUNT"

