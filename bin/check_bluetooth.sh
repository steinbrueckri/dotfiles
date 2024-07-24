#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <Device Name>"
    exit 1
fi

DEVICE_NAME="$1"

# Check if the device is connected
# TODO: maybe find a better way for the path of jq
if system_profiler SPBluetoothDataType -json | /opt/homebrew/bin/jq -e --arg DEVICE_NAME "$DEVICE_NAME" '.SPBluetoothDataType[] | .device_connected[]? | has($DEVICE_NAME)' > /dev/null; then
    echo "connected"
else
    echo "disconnected"
fi
