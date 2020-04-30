#!/bin/sh

NAMEFILE="/home/ishmael/.sbar/.name"
TMPFILE="/home/ishmael/.sbar/.tmpname"
LOCKFILE="/tmp/sbarlock"

test $(expr $# % 2) -ne 0 \
	&& echo "Need value-position pairs!" \
	&& exit 1

# Get lock
COUNT=0
while ! mkdir "$LOCKFILE" && test $COUNT -lt 9; do
	COUNT=$(( $COUNT+1 ))
	sleep 1
done

FROMFNAME="$NAMEFILE"
TOFNAME="$TMPFILE"

SHFTCT=2
VAL="$1"; shift; POS="$1"
while ! test -z "$VAL" && ! test -z "$POS"; do
	cat "$FROMFNAME" | awk -v x=$POS -v y=$VAL -F" | " '{ $x=y; print }' > "$TOFNAME"

	TMPFNAME="$FROMFNAME"
	FROMFNAME="$TOFNAME"
	TOFNAME="$TMPFNAME"

	# Don't overshift
	test ! $SHFTCT -lt $(expr $# + 1 ) && break
	shift; VAL="$1";
	shift; POS="$1";
done

# If we ended on $TMPFILE, update $NAMEFILE
test "$FROMFNAME" = "$TMPFILE" && cat "$TMPFILE" > "$NAMEFILE"

xsetroot -name "$(cat $NAMEFILE)"

# Release lock
rm -rf "$LOCKFILE"
