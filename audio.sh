#!/bin/sh

name_file="/home/ishmael/.sbar/.name"
tmp_file="/home/ishmael/.sbar/.tmpname"
sbarname="$(cat $name_file)"

# -------------------------------
# Set volume, get ready to update

# Pass +/- as $1 to do the thing, $2 is the amount
if [ "$1" = "mute" ]; then
	amixer set Master mute
	vol="X"

else
	amixer set Master "$2"%"$1" unmute
	# Skip over the mute symbol
	vol=$(amixer sget Master | awk -F"[][]" '/dB/ { print $2 }')
	vol="${vol::-1}%"
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
sed "s/\S\+/$vol/2" "$name_file" > "$tmp_file"
cat "$tmp_file" > "$name_file"

xsetroot -name "$(cat $name_file)"
# RELEASE LOCK
9>&-
rm -rf /tmp/sbarlock
