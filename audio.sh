#!/bin/sh

# Action		muted			+/- as $1, $2 is the percent amount
test "$1" = "mute" && amixer set Master mute || amixer set Master "$2"%"$1" unmute

# Status		muted			already has % symbol
test "$1" = "mute" && VOL="X" || VOL=$(amixer get Master | awk -F"[][]" '/Left:/ { print $2 }')

#"VOL: $VOL | o $BRIGHT% | $NETNAME | $BATSYM $BAT%"
/usr/local/bin/sbar_update.sh "$VOL" 2
