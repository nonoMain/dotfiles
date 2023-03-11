#!/bin/bash

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host=`whoami`

# Options
shutdown='⏻'
reboot=''
lock=''
suspend='󰤄'
logout='󰍃'

rofi_cmd() {
	rofi -dmenu \
		-p "Bye $host! Uptime: $uptime" \
		-mesg "Hey $host - Choose your way out:) Uptime: $uptime" \
		-select $lock \
		-theme ~/.config/rofi/themes/powermenu
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

lock_bg () {
	swaylock &
}

wipe_clipboard() {
	rm -rf ~/.cache/cliphist
}

chosen="$(run_rofi)"
case ${chosen} in
	$shutdown)
		# clean the clipboard history on shutdown
		wipe_clipboard
		systemctl poweroff
		;;
	$reboot)
		wipe_clipboard
		systemctl reboot
		;;
	$lock)
		lock_bg
		;;
	$suspend)
		lock_bg
		systemctl suspend
		;;
	$logout)
		hyprctl dispatch exit
		;;
esac
