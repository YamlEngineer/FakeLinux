#!/bin/dash

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors
. ~/.config/chadwm/scripts/bar_themes/onedark

cpu() {
	cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

	printf "^c$black^ ^b$green^ CPU"
	printf "^c$white^ ^b$grey^ $cpu_val ^d^%s"
}

temp() {
	printf "^c$red^  $(cat /sys/class/thermal/thermal_zone0/temp | head -c2)"
}

pkg_updates() {
	# updates=$(doas xbps-install -un | wc -l) # void
	updates=$(pacman -Qu | wc -l) # arch , needs pacman contrib
	# updates=$(aptitude search '~U' | wc -l)  # apt (ubuntu,debian etc)
	printf "^c$orange^  $updates"
}

volume() {
	if [ $(pamixer --get-volume-human) = "muted" ]; then
		printf "^c$darkblue^ 婢 meuted"
	else
		printf "^c$darkblue^ 墳 $(pamixer --get-volume)"
	fi
}

battery() {
	get_capacity="$(cat /sys/class/power_supply/BAT*/capacity)"
	case $get_capacity in
	[0-9] | 1[0-9]) printf "^c$red^  $get_capacity" ;;
        2[0-9] | 3[0-9]) printf "^c$orange^  $get_capacity" ;;	
        4[0-9] | 5[0-9]) printf "^c$orange^  $get_capacity" ;;
	6[0-9] | 7[0-9]) printf "^c$green^  $get_capacity" ;;
	8[0-9] | 9[0-9] | 100) printf "^c$blue^  $get_capacity" ;;
	esac
}

brightness() {
	printf "^c$red^  "
	printf "^c$red^$(cat /sys/class/backlight/*/brightness | head -c1)"
}

mem() {
	printf "^c$blue^ "
	printf "^c$blue^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

wlan() {
	case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
	up) printf "^c$green^ 直 $(nmcli dev wifi show | head -n1 | cut -c 7-)  $(ipinfo countryCode)" ;;
	down) printf "^c$green^ 睊 Disconnected" ;;
	esac
}

mpd() {
	SONG=$(mpc -f %title% current)
	if [ -z "$SONG" ]; then
		SONG="Offline"
	else
		if [ ${#SONG} -gt 20 ]; then
			TRIM=${SONG#????????????????????}
			SONG=${SONG%$TRIM}...
		else
			SONG=$SONG
		fi
	fi
	printf "^c$green^  $SONG"
}

storage() {
	printf "^c$darkblue^  $(df -h --output=used,size / | awk 'NR == 2 { print $1"" }')"
}

clock() {
	printf "^c$black^ ^b$darkblue^  "
	printf "^c$black^^b$blue^ $(date '+%H:%M') "
}

while true; do

	[ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
	interval=$((interval + 1))

	sleep 1 && xsetroot -name " $updates $(storage) $(battery) $(brightness) $(cpu) $(mem) $(temp) $(volume) $(wlan) $(clock)"
done
