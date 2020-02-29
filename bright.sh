#!/bin/sh

name_file="/home/ishmael/.sbar/.name"
tmp_file="/home/ishmael/.sbar/.tmpname"
sbarname="$(cat $name_file)"

# -------------------------------
# Set brightness, get ready to update

# Extra one is for 100%
brightsyms=( o D O O )

# Pass A/U to do the thing
	# up/down
light "$1" "$2"

# Get brightness
bright=$(light -G)
bright=${bright%.*}
i=$(( $bright/33 ))
brightsym="${brightsyms[$i]}"
echo "$brightsym"

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
sed "s/\S\+/$brightsym/4" "$name_file" > "$tmp_file"
sed "s/\S\+/$bright%/5" "$tmp_file" > "$name_file"

xsetroot -name "$(cat "$name_file")"
# RELEASE LOCK
9>&-
rm -rf /tmp/sbarlock
