#!/bin/bash

ROFI='rofi -theme ~/.config/rofi/themes/default'

cd ~

[[ -d "$1" ]] && cd "$1"

current_path="$PWD"

while [[ true ]]; do
	cd "$current_path"
	input=`ls -a --group-directories-first --color=never --indicator-style=slash | $ROFI -dmenu -p "File > "`
	[[ -d "$input" ]] && current_path="$PWD/$input"
	[[ -f "$input" ]] && printf "$current_path/$input" && exit
	[[ -z "$input" ]] && printf "" && exit
done
