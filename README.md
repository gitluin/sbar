sbar
-----
This is a collection of shell scripts that xsetroot -name with various information that I want in my status bar. It was written for use with [sara](github.com/gitluin/sara), but will work with dwm or any other xsetroot -name supporting program.

To start, I symlink the files from this directory to /bin with the prefix sbar\_ and then add "/bin/start\_sbar.sh &" to my .xinitrc.

## Why It's Cool
Only time, network status, and battery level are updated every 15 seconds. Volume and battery status are updated when they are updated - push notifications effectively. Less system usage than while(){ ... sleep(2) }.
