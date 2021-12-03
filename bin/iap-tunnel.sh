#!/usr/bin/env bash

# check if tunnel already exist
PID=$(ps aux | grep -v grep | grep "2222:ing04manubn01p.media-saturn.com:22" | awk '{print $2}')

if [ -z "$PID" ]; then
  echo "INFO: tunnel is not established yet."
  gcloud compute ssh gcp04manans01p --tunnel-through-iap --zone=europe-west4-b --project=mms-cif-config-mgmt-p-1000 -- -NL 2222:ing04manubn01p.media-saturn.com:22 &
  echo "INFO: wait until tunnel is established."
  while ! nc -z localhost 2222; do
    sleep 0.1 # wait for 1/10 of the second before check again
    echo "INFO: checking"
  done
  echo "INFO: tunnel is established."
else
  echo "INFO: tunnel is already established."
fi

nc "$1" "$2"
