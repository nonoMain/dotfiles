#!/bin/bash

# toggles (launched and kills) rofi with the different wanted modes

wanted_mode="$1"

if [[ "$wanted_mode" == "L" ]]; then
	pgrep -x rofi
	[[ $? -eq 1 ]] && rofi -show drun -theme ~/.config/rofi/themes/default || killall rofi
else
	killall rofi
	case "$wanted_mode" in
		R|L) # normal mode
			rofi -show drun -theme ~/.config/rofi/themes/default
			;;
		W) # window mode
			rofi -show window -theme ~/.config/rofi/themes/default
			;;
		E) # Emoji mode
			rofi -show emoji -theme ~/.config/rofi/themes/default
			;;
		C) # command / run mode
			rofi -show run -theme ~/.config/rofi/themes/default
			;;
		F) # filebrowser mode
			rofi -show filebrowser -theme ~/.config/rofi/themes/default
			;;
	esac
fi
