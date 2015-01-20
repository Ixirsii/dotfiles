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

# Start Network Manager
nm-applet &

# Start Screensaver
cinnamon-screensaver &

# Start Compositing Manager
compton -b

# Set Wallpaper
feh --bg-scale /home/ryan/Pictures/Pictures/Vocaloid/Miku_Hatsune_01.png

# Start Dropbox
dropboxd &
