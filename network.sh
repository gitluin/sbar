#!/bin/sh

name_file="/home/ishmael/.sbar/.name"
tmp_file="/home/ishmael/.sbar/.tmpname"
sbarname="$(cat $name_file)"
netstate=$(cat "/sys/class/net/wlp2s0/operstate")

# -------------------------------
# Set network, get ready to update

if [ $netstate = "up" ]; then
	# bssid comes first, fuhgettaboudit
	netname=($(sudo wpa_cli -i wlp2s0 status | grep ssid))

	outname=${netname[1]}
	outname=${outname:5}
	i=2
	if [ ${#netname[@]} -gt 2 ]; then
		outname="${outname} ${netname[$i]}"

		(( i++ ))
	fi
	netname="$outname"
	netname="${netname// /_}"
else
	netname="down"
fi

# -------------------------------
# Update sbar

# Get current xsetroot name
# LOCK OR SOMETHING HERE
exec 9>/tmp/sbarlock
if ! flock -w 5 9 ; then
	echo "Could not get the lock :("
	exit 1
fi

#"VOL: $vol | $brightsym $bright% | $netname | $batsym $bat% | $bardate $bartime"
sed "s/\S\+/$netname/7" "$name_file" > "$tmp_file"
cat "$tmp_file" > "$name_file"

xsetroot -name "$(cat "$name_file")"
# RELEASE LOCK
9>&-
rm -rf /tmp/sbarlock
