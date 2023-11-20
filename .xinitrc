#!/bin/bash
export XDG_CONFIG_HOME=/home/john/.config
export SXHKD_SHELL='/usr/bin/sh'
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        #[ -x "$f"] && "$f"
	"$f"
    done
fi
#vmware-user-suid-wrapper &
#exec emacs
exec bspwm
~/.config/polybar/launch.sh

#exec i3
#exec xmonad
#exec awesome
