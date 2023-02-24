#!/bin/bash

# toggles (launched and kills) rofi with the different wanted modes

STATE_DIR="/tmp/$USER/rofi/"
STATE_PATH="$STATE_DIR/rofi_toggle_state"

[[ ! -d $STATE_PATH ]] && mkdir -p $STATE_DIR

wanted_mode="$1"

killall rofi
if [[ "$wanted_mode" == "$(cat $STATE_PATH)" ]]; then # launch the wanted mode
	cat /dev/null > $STATE_PATH
else
	printf "$wanted_mode" > $STATE_PATH
	case "$wanted_mode" in
		R) # normal mode
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
		L) # launcher mode
			pgrep -x rofi
			[[ $? -eq 1 ]] && rofi -show drun -theme ~/.config/rofi/themes/default
			;;
	esac
fi
