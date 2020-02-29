#!/bin/sh

if [ $(pgrep -c "sbar_loop.sh") -ge 1 ]; then
	exit 0
fi

name_file="/home/ishmael/.sbar/.name"
batcapfile="/sys/class/power_supply/BAT0/capacity"
batstatfile="/sys/class/power_supply/BAT0/status"
batsymfile="/home/ishmael/.sbar/.batsym"
netstate=$(cat "/sys/class/net/wlp2s0/operstate")

# Clear out any stale locks
9>&-
sudo rm -rf /tmp/sbarlock

# -------------------------------------------
# Initialize xsetroot

# Symbols, mate
# Extra ones are for 100%
brightsyms=( o D O O )

# Initialize audio
volstate=$(amixer sget Master | awk -F"[][]" '/dB/ { print $6 }')
if [ "$volstate" = "off" ]; then
	vol="X"
else
	vol=$(amixer sget Master | awk -F"[][]" '/dB/ { print $2 }')
	vol="${vol::-1}%"
fi

# Initialize brightness
bright=$(light -G)
bright=${bright%.*}
i=$(( $bright/33 ))
brightsym="${brightsyms[$i]}"

# Initialize network
if [ $netstate = "up" ]; then
	# bssid comes first, fuhgettaboudit
	netname=($(sudo wpa_cli -i wlp2s0 status | grep ssid))
	netname=${netname[1]}
	netname=${netname:5}
else
	netname="down"
fi

# Initialize battery 
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

# Initialize time
dtime=$(date +'%m-%d-%y %R')

out="VOL: $vol | $brightsym $bright% | $netname | $batsym $bat% | $dtime"
echo "$out" > "$name_file"

xsetroot -name "$out"
exec /bin/sbar_loop.sh
