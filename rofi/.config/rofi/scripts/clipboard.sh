#!/bin/bash

ROFI='rofi -theme ~/.config/rofi/themes/default'

# select item
[[ "$1" == "S" ]] && \
	cliphist list | $ROFI -dmenu -p "Clipboard entry > " | cliphist decode | wl-copy
# delete item
[[ "$1" == "D" ]] && \
	cliphist list | $ROFI -dmenu -p "Delete an entry > " | cliphist delete
