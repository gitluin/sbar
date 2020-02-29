#!/bin/sh

name_file="/home/ishmael/.sbar/.name"
tmp_file="/home/ishmael/.sbar/.tmpname"
sbarname="$(cat $name_file)"
batcapfile="/sys/class/power_supply/BAT0/capacity"
batsymfile="/home/ishmael/.sbar/.batsym"

# -------------------------------
# Set time, get ready to update

while true; do
	bardate=$(date +'%m-%d-%y')
	bartime=$(date +'%R')

	batsym=$(cat $batsymfile) 
	bat=$(cat $batcapfile)

	# Update network status
	/bin/sbar_network.sh &
	wait

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
	#out=$(sed "s/\S\+/$bardate/12" "$name_file")
	#out=$(echo "$out" | sed "s/\S\+/$bartime/13")
	#cat "$out" > "$tmp_file"
	sed "s/\S\+/$bardate/12" "$name_file" > "$tmp_file"
	sed "s/\S\+/$bartime/13" "$tmp_file" > "$name_file"

	# Update battery - status will update whenever it changes
	sed "s/\S\+/$batsym/9" "$name_file" > "$tmp_file"
	sed "s/\S\+/$bat%/10" "$tmp_file" > "$name_file"

	xsetroot -name "$(cat "$name_file")"

	# RELEASE LOCK
	9>&-
	rm -rf /tmp/sbarlock
	sleep 15
done
