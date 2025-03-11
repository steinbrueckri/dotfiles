#!/bin/bash

# Ensure a device name is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <Device Name>"
    exit 1
fi

DEVICE_NAME="$1"

# Check if the device is listed under "device_connected"
if system_profiler SPBluetoothDataType -json | /opt/homebrew/bin/jq '.SPBluetoothDataType[]?.device_connected[]? | keys[]' | grep -q "$DEVICE_NAME"; then
    echo "connected"
else
    echo "disconnected"
fi