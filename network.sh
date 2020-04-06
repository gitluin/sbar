#!/bin/bash

# TODO: Remove bashisms
NETSTATE="$(cat "/sys/class/net/wlp2s0/operstate")"

if [ $NETSTATE = "up" ]; then
	# bssid comes first, fuhgettaboudit
	WPASTR=($(sudo wpa_cli -i wlp2s0 status | grep ssid))
	NETNAME="${WPASTR[1]}"
	NETNAME="${NETNAME:5}"

	for (( i=2; i<${#WPASTR[@]}; i++)); do
		NETNAME="${NETNAME}_${WPASTR[$i]}"
	done
else
	NETNAME="down"
fi

#"VOL: $VOL | o $BRIGHT% | $NETNAME | $BATSYM $BAT%"
/usr/local/bin/sbar_update.sh "$NETNAME" 7
