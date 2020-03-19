sbar
-----
This is a collection of shell scripts that `xsetroot -name` with various information that I want in my status bar. It was written for use with [sara](https://github.com/gitluin/sara), but will work with dwm or any other `xsetroot -name` supporting program.

To start, I symlink the files from this directory to my custom `/ibin` directory (which is added to `$PATH`) with the prefix `sbar_` and then add `/ibin/start_sbar.sh &` to my `~/.xinitrc` **before** the `exec sara` line. Make sure you change the directory names, etc. to match your system.

Place `battery.rules` in `/etc/udev/rules.d/`. Then, run `sudo udevadm control --reload` to ensure the rules take effect at the moment, or you could reboot. Per the [ArchWiki](https://wiki.archlinux.org/index.php/Udev): "However, the rules are not re-triggered automatically on already existing devices", and last I checked the battery is already existing.

If you are using the most recent version of `sara` (3.0+), you will be without a bar! In `config.h`, adjust the `barpx` variable to the size that you want, and then replace any call in `~/.xinitrc` to `exec sara` with a call to the `start_sara.sh` script. This creates an instance of [lemonbar with Xft support](https://github.com/krypt-n/bar) that is identical to the bar that was originally in v1.0.

`lemonbar` has a **lot** of customization options, so go hog-wild here. At the very least, make sure the height of the bar matches the `barpx` you allotted for it! The script has what's probably crude support for multihead, and you might have to muck about with it to get it to work. It incorporates the other `sbar_` scripts outputs (`~/.sbar/.name` by default). Make sure you comb through the shell script to verify that everything matches your system if you decide to go this route - I've only tested it on my machine.

## Why It's Cool
In the non-`lemonbar` use case, only time, network status, and battery level are updated every 15 seconds. Volume and battery status are updated when they are updated - push notifications effectively. Less system usage than ``while(); do ... sleep(2) done``.
