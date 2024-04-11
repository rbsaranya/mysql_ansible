#!/bin/bash

# Check if required arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0  <ip> <port>"
    exit 1
fi

#PASSWORD="$1"
IP="$1"
PORT="$2"
TOTAL_KEY_COUNT=0

# Get list of master nodes
MASTER_NODES=$(redis-cli  -h "$IP" -p "$PORT" cluster nodes | grep 'master' | awk '{print $2}')

# Loop through master nodes and get key count
for NODE in $MASTER_NODES; do
    HOST=$(echo "$NODE" | cut -d ':' -f 1)
    PORT=$(echo "$NODE" | cut -d ':' -f 2)
    KEY_COUNT=$(redis-cli  -h "$HOST" -p "$PORT" info keyspace)
   # TOTAL_KEY_COUNT=$((TOTAL_KEY_COUNT + KEY_COUNT))
    echo "Master Node: $HOST:$PORT, Key Count: $KEY_COUNT"
done

#echo "Total Key Count across all master nodes: $TOTAL_KEY_COUNT"

