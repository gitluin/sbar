#!/bin/bash

#"VOL: $VOL | o $BRIGHT% | $NETNAME | $BATSYM $BAT%"
while true; do
	/usr/local/bin/sbar_battery.sh
	/usr/local/bin/sbar_network.sh

	sleep 15
done
