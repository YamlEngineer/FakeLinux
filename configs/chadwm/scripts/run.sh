#!/bin/sh

xrdb merge ~/.Xresources 
feh --bg-fill -z ~/Pictures/.wallpapers/ &
xset r rate 200 50 &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

~/.config/chadwm/scripts/bar.sh &
while type dwm >/dev/null; do dwm && continue || break; done
