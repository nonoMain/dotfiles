#!/bin/bash

ROFI='rofi -theme ~/.config/rofi/themes/default'

INPUT=`pactl list sinks | grep -ie "Description:" | cut -d: -f2 | $ROFI -dmenu -p "Audio out sink > "`
desc=`echo "$INPUT" | xargs`

device=$(pactl list sinks | grep -C2 "Description: $desc" | grep Name | cut -d: -f2 | xargs)
# Try to set the default to the device chosen
if pactl set-default-sink "$device"; then
	# if it worked, alert the user
	notify-send -t 2000 -r 2 -u low "Activated: $desc"
else
	# didn't work, critically alert the user
	notify-send -t 2000 -r 2 -u critical "Error activating $desc"
fi
