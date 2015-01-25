#!/bin/bash

# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

# Set screen timeout
xset dpms 0 0 600

# Start DWM status bar
$HOME/.dwm/dwmstatus.py

# Start Screensaver
xscreensaver -no-splash &

# Start Compositing Manager
compton -b

# Set Wallpaper
feh --bg-fill $HOME/Pictures/Wallpaper/Miku_Hatsune_01.png

# Start Network Manager
nm-applet &

# Start Dropbox
dropboxd &
