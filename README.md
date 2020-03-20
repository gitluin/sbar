sbar
-----
This is a collection of shell scripts that `xsetroot -name` with various information that I want in my status bar. It was originally written for use with [sara v1.0-v2.0](https://github.com/gitluin/sara), but will work with dwm or any other `xsetroot -name` supporting program.

To start, I symlink the files from this directory to my custom `/ibin` directory (which is added to `$PATH`) with the prefix `sbar_` and then add `/ibin/start_sbar.sh &` to my `~/.xinitrc` **before** the `exec sara` line. Make sure you change the directory names, etc. to match your system.

Place `battery.rules` in `/etc/udev/rules.d/`. Then, run `sudo udevadm control --reload` to ensure the rules take effect at the moment, or you could reboot. Per the [ArchWiki](https://wiki.archlinux.org/index.php/Udev): "However, the rules are not re-triggered automatically on already existing devices", and last I checked the battery is already existing.

If you are running `sara v3.0+`, use [this repository](https://github.com/gitluin/sbar-lemon)!

## Why It's Cool
Only time, network status, and battery level are updated every 15 seconds. Volume and battery status are updated when they are updated - push notifications effectively. Less system usage!
