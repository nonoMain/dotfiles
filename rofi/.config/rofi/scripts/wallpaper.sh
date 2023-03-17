#!/bin/bash

# needs filepicker.sh and displaypicker.sh

ROFI='rofi -theme ~/.config/rofi/themes/default'

DISPLAY=`~/.config/rofi/scripts/displaypicker.sh`
WALLPAPER=`~/.config/rofi/scripts/filepicker.sh ~/.wallpapers/`

echo "Display: $DISPLAY, Wallpaper: $WALLPAPER"
[[ -z "$DISPLAY" ]] && exit
[[ -z "$WALLPAPER" ]] && exit

hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper "$DISPLAY,$WALLPAPER"
hyprctl hyprpaper unload all
