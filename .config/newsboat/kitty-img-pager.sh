#!/usr/bin/env bash
# Shows images, scaled to terminal dimensions, via kitty's icat.
# Designed for image-feeds like xkcd.com.
# by Timm Heuss (https://github.com/heussd/) - CC-BY 4.0
#
# Usage:
# 1) Define a new macro in your config:
#    macro i set pager "$PATHTOTHIS/kitty-img-pager"; open; set pager internal
# 2) Now you use this pager in articleview using the hotkey <comma>+<i>

set -o errexit
set -o pipefail
set -o nounset


image=$(grep -E -o "https?://[a-zA-Z0-9./?=_%:-]*" < "${1}" | tail -1)

# FIXME: just exit if no image was found

# Detect terminal dimensions
dims="$(tput cols)x$(tput lines)@0x0"

clear
kitty +kitten icat --clear
# NOTE: for some reason 'icat --hold' dont works on my machine to i hacked it
# with the '&& read' at the end
kitty +kitten icat --scale-up --place "$dims" "$image" && read
clear
