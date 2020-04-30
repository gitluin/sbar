#!/bin/sh

NETSTATE="$(cat "/sys/class/net/wlp2s0/operstate")"

if [ $NETSTATE = "up" ]; then
	# bssid comes first, fuhgettaboudit
	WPASTR="$(sudo wpa_cli -i wlp2s0 status | grep ssid)"
	NETNAME="$(cut -d$'\n' -f2 <<<$WPASTR)"
	NETNAME="$(cut -d'=' -f2 <<<"$NETNAME")"
	NETNAME="$(echo "$NETNAME" | sed 's/ /_/')"

else
	NETNAME="down"
fi

#"VOL: $VOL | o $BRIGHT% | $NETNAME | $BATSYM $BAT%"
/usr/local/bin/sbar_update.sh "$NETNAME" 7
