#!/bin/bash

# toggles (launched and kills) rofi with the different wanted modes

STATE_DIR="/tmp/$USER/rofi/"
STATE_PATH="$STATE_DIR/rofi_toggle_state"

[[ ! -d $STATE_PATH ]] && mkdir -p $STATE_DIR

wanted_mode="$1"

killall rofi
if [[ "$?" == "0" && "$wanted_mode" == "$(cat $STATE_PATH)" ]]; then
	cat /dev/null > $STATE_PATH
else
	printf "$wanted_mode" > $STATE_PATH
	case "$wanted_mode" in
		R) # normal mode
			rofi -show drun -show-icons -theme ~/.config/rofi/themes/default
			;;
		W) # window mode
			rofi -show window -theme ~/.config/rofi/themes/default
			;;
		E) # Emoji mode
			rofi -show emoji -theme ~/.config/rofi/themes/default
			;;
		C) # command (run) mode
			rofi -show run -theme ~/.config/rofi/themes/default
			;;
		S) # spellcheck mode
			~/.config/rofi/scripts/spellcheck.sh
			;;
		A) # audio mode
			~/.config/rofi/scripts/audio.sh
			;;
		V) # clipboard mode
			~/.config/rofi/scripts/clipboard.sh S
			;;
		Vd) # clipboard delete mode
			~/.config/rofi/scripts/clipboard.sh D
			;;
		P) # powermenu mode
			~/.config/rofi/scripts/powermenu.sh
			;;
		B) # Background (wallpaper) mode
			~/.config/rofi/scripts/wallpaper.sh
			;;
	esac
fi
