#!/bin/bash

# Pass -A (up)/-U (down) as $1, amount as $2
light "$1" "$2"

BRIGHT="$(light -G)"
BRIGHT="${BRIGHT%.*}"

#"VOL: $VOL | o $BRIGHT% | $NETNAME | $BATSYM $BAT% | $BARDATE $BARTIME"
/usr/local/bin/sbar_update.sh "$BRIGHT%" 5
