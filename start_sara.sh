#!/bin/bash

OIFS=$IFS
IFS=" "
EXTDIS="HDMI-0"

TAGS="123456789"
LEFTSYM="<"
RIGHTSYM=">"
BARFG="#ffffff"
BARBG="#000000"
BARFONT="Noto Sans:size=10"

XSETRFILE="home/ishmael/.sbar/.name"
INFF="/tmp/saralemon.fifo"
[[ -p $INFF ]] || mkfifo -m 600 "$INFF"

# Pass MONLINE, TAGS, LEFTSYM, RIGHTSYM
MakeTagStr () {
	local MONLINE="$1"
	local TAGS="$2"
	local LEFTSYM="$3"
	local RIGHTSYM="$4"

	local TAGSTR=""

	# 0:00000000:00000000:[]= -> 00000000:00000000:[]=
	MONLINE="$(cut -d':' -f2-4 <<<"$MONLINE")"
	local ISDESKOCC="$(cut -d':' -f1 <<<"$MONLINE")"
	local ISDESKSEL="$(cut -d':' -f2 <<<"$MONLINE")"
	local LAYOUTSYM="$(cut -d':' -f3 <<<"$MONLINE")"

	for (( i=0; i<${#ISDESKOCC}; i++ )); do
		if [ ${ISDESKSEL:$i:1} -eq 1 ]; then
			TAGSTR="${TAGSTR} $LEFTSYM${TAGS:$i:1}$RIGHTSYM "
		elif [ ${ISDESKOCC:$i:1} -eq 1 ]; then
			TAGSTR="${TAGSTR}   ${TAGS:$i:1}   "
		fi
	done
	TAGSTR="${TAGSTR}  $LAYOUTSYM"

	echo "$TAGSTR"
}

while read line; do
	MULTI=$(xrandr -q | grep "$EXTDIS" | awk -F" " '{ print $2 }')
	BARSTATS="$(cat "$XSETRFILE")"

	# monitor 0 (lemonbar says it's 1)
	MONLINE0="$(cut -d' ' -f1 <<<"$line")"
	TAGSTR0="$(MakeTagStr $MONLINE0 $TAGS $LEFTSYM $RIGHTSYM)"

	if [ "$MULTI" = "connected" ]; then
		BARW=3840
		# monitor 1 (lemonbar says it's 0)
		MONLINE1="$(cut -d' ' -f2 <<<"$line")"
		TAGSTR1="$(MakeTagStr $MONLINE1 $TAGS $LEFTSYM $RIGHTSYM)"
		printf "%s\n" "%{S0}%{l}$TAGSTR1%{r}$BARSTATS%{S1}%{l}$TAGSTR0%{r}$BARSTATS"
	else
		BARW=1920
		printf "%s\n" "%{l}$TAGSTR0%{r}$BARSTATS"
	fi
done < "$INFF" | lemonbar -g "$BARW"x18+0+0 -d -f "$BARFONT" -p -B "$BARBG" -F "$BARFG" &

# pull information from saranobar
sara > "$INFF"

IFS=$OIFS
