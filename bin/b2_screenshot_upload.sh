#!/usr/bin/env bash
set -e

eval $(op signin --account pixel-combo.1password.com)

FILE_PATH=$1
B2_BUCKET="steinbrueckri-public-share"
B2_PARAMETER="--noProgress"
KEY_ID="$(op item get 'B2 Masterkey (Privat)' --field keyID)"
APPLICATION_KEY="$(op item get 'B2 Masterkey (Privat)' --field applicationKey)"

b2 authorize-account "$KEY_ID" "$APPLICATION_KEY"

B2_OUTPUT="$(b2 upload-file $B2_PARAMETER $B2_BUCKET "$FILE_PATH" "screenshots/$(basename "$FILE_PATH")")"
B2_URL="$(echo $B2_OUTPUT | grep 'URL by file name: https' | awk '{for(i=1;i<=NF;i++) if($i~/^http[s]?:\/\//){print $i; exit}}')"

echo $B2_URL | pbcopy
