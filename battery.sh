#!/bin/sh

BATSTATFILE="/sys/class/power_supply/BAT0/status"
BATCAPFILE="/sys/class/power_supply/BAT0/capacity"

# Let udev breathe
sleep 1

BATSTAT="$(cat $BATSTATFILE)"
BAT="$(cat $BATCAPFILE)"

test $BAT -gt 100 && BAT=100

BATSYM="BAT:"
test "$BATSTAT" = "Charging" || test "$BATSTAT" = "Unknown" && BATSYM="CHR:"
test "$BATSTAT" = "Full" && BATSYM="CHR:"

#"VOL: $VOL | o $BRIGHT% | $NETNAME | $BATSYM $BAT%"
# Sudo is necessary when this is run from udev
sudo /usr/local/bin/sbar_update.sh "$BATSYM" 9 "$BAT%" 10
