#!/bin/bash

source $(dirname $0)/config.sh

TUNADDR=`ip addr | grep tun0 | grep inet | awk '{gsub(/,/,""); print $2}'`
ICON='^i(/home/odin/.xmonad/dzen2/games.xbm)'
vpnstatus="VPN On"

if [[ $TUNADDR != "" ]]; then
	echo "$ICON ^fg($foreground)$vpnstatus"
fi
