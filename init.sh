#!/bin/sh

test "$(pgrep -c "sbar_loop.sh")" -ge 1 && exit 1

NAMEFILE="/home/ishmael/.sbar/.name"

# Clear out any stale locks
sudo rm -rf /tmp/sbarlock

echo "VOL: NA | o NA% | NA | NA NA%" > "$NAMEFILE"

/usr/local/bin/sbar_audio.sh "" ""
/usr/local/bin/sbar_bright.sh "" ""
/usr/local/bin/sbar_battery.sh

exec /usr/local/bin/sbar_loop.sh
