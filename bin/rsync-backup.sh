#!/usr/bin/env sh

PROG=$0
RSYNC="/usr/local/bin/rsync"
DST="/Volumes/SSD"
SRC="$HOME"

echo "Running..."

if mount | grep "on $DST" > /dev/null; then
    echo "mounted"
else
    echo "not mounted"
    exit 255
fi

# rsync options
# -v increase verbosity
# -a turns on archive mode (recursive copy + retain attributes)
# -x don't cross device boundaries (ignore mounted volumes)
# -E preserve executability
# -S handle spare files efficiently
# --delete delete deletes any files that have been deleted locally
# --exclude-from reference a list of files to exclude

if [ ! -r "$SRC" ]; then
 MESSAGE="Source $SRC not readable - Cannot start the sync process"
 /usr/bin/logger -t "$PROG" "$MESSAGE"
 echo "$MESSAGE"
 exit;
fi

if [ ! -w "$DST" ]; then
 MESSAGE="Destination $DST not writeable - Cannot start the sync process"
 /usr/bin/logger -t "$PROG" "$MESSAGE"
 echo "$MESSAGE"
 exit;
fi

/usr/bin/logger -t "$PROG" "Start rsync"

"$RSYNC" -vaE -S --progress --human-readable --force --delete --exclude-from="$HOME/bin/rsync_excludes.txt" "$SRC" "$DST"

/usr/bin/logger -t "$PROG" "End rsync"
