sbar
-----
This is a collection of shell scripts that `xsetroot -name` with various information that I want in my status bar. It was originally written for use with [sara v1.0-v2.0](https://github.com/gitluin/sara), but will work with dwm or any other program that reads the X root window name.

To start, create `~/.sbar/`. Then, symlink the files from this repository to `/usr/local/bin/` with the prefix `sbar_` added to all but `startsbar.sh`. Then add `startsbar.sh &` to `~/.xinitrc` **before** the `exec sara` line. Make sure you change any directory names, etc. to match your system.

Place `battery.rules` in `/etc/udev/rules.d/`. Then, run `sudo udevadm control --reload` to ensure the rules take effect at the moment, or you could reboot. Per the [ArchWiki](https://wiki.archlinux.org/index.php/Udev): "However, the rules are not re-triggered automatically on already existing devices", and last I checked the battery is already existing.

If you are running `sara v3.0+`, use [this repository](https://github.com/gitluin/sbar-lemon)!

## Why It's Cool
Only time, network status, and battery level are updated every 15 seconds. Volume and battery status are updated when they are updated - push notifications effectively. Less system usage!
