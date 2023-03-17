#!/bin/bash

ROFI='rofi -theme ~/.config/rofi/themes/default'

MONITORS=`hyprctl monitors | grep description | grep -oP '\((.*?)\)' | sed 's/[()]//g'`

count=`echo $MONITORS | wc -l`

[[ $count -eq 1 ]] && printf $MONITORS && exit

choice=`echo $MONITORS | $ROFI -dmenu -p "Choose a display"`
printf "$choice"
