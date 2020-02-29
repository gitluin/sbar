#!/bin/sh

name_file="/home/ishmael/.sbar/.name"
tmp_file="/home/ishmael/.sbar/.tmpname"
sbarname="$(cat $name_file)"
batcapfile="/sys/class/power_supply/BAT0/capacity"
batstatfile="/sys/class/power_supply/BAT0/status"
batsymfile="/home/ishmael/.sbar/.batsym"

# -------------------------------
# Set battery, get ready to update

sleep 1

batstat=$(cat $batstatfile) 
bat=$(cat $batcapfile)
if [ "$batstat" = "Charging" ]; then
	batsym="CHR:"
elif [ "$batstat" = "Unknown" ]; then
	batsym="CHR:"
else 
	batsym="BAT:"
fi
echo "$batsym" > "$batsymfile"

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
sed "s/\S\+/$batsym/9" "$name_file" > "$tmp_file"
sed "s/\S\+/$bat%/10" "$tmp_file" > "$name_file"

xsetroot -name "$(cat "$name_file")"
# RELEASE LOCK
9>&-
rm -rf /tmp/sbarlock
