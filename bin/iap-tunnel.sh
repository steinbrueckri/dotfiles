#!/usr/bin/env bash

set -e

# check if tunnel already exist
PID=$(ps aux | grep -v grep | grep "2222:ing04manubn01p.media-saturn.com:22" | awk '{print $2}' | tr '\n' ' ')

if [ "$1" = "kill" ]; then
  if [ -z "$PID" ]; then
    echo "🙃 nothing to kill $PID"
  else
    echo "❌ kill tunnel with the folling PIDs $PID"
    kill $PID
  fi
  exit 0
fi

if [ -z "$PID" ]; then
  echo "🙄 tunnel is not established yet."
  gcloud compute ssh gcp04manans01p --tunnel-through-iap --zone=europe-west4-b --project=mms-cif-config-mgmt-p-1000 -- -NL 2222:ing04manubn01p.media-saturn.com:22 -NL 2223:gcp04manans01p:22 &
  echo "😴 wait until tunnel is established."
  while ! nc -z localhost 2222; do
    sleep 0.5 # wait 5 milisecond before check again
    echo "🔂 wait until the tunnel is established."
  done
  echo "✅ tunnel is established."
else
  echo "✅ tunnel is already established."
fi

# requited
nc "$1" "$2"
