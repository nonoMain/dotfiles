#!/bin/bash

# @requires: pamixer

percentage () {
  local val=$(echo $1 | tr '%' ' ' | awk '{print $1}')
  local icon1=$2
  local icon2=$3
  local icon3=$4
  local icon4=$5
  if [ "$val" -le 15 ]; then
    echo $icon1
  elif [ "$val" -le 30 ]; then
    echo $icon2
  elif [ "$val" -le 60 ]; then
    echo $icon3
  else
    echo $icon4
  fi
}

get_percentage () {
  local muted="$(pamixer --get-mute)"
  if [[ $muted == 'true' ]]; then
    echo "muted"
  else
	echo "$(pamixer --get-volume)"
  fi
}

get_icon () {
  local vol=$(get_percentage)
  if [[ $vol == "muted" ]]; then
    echo "婢"
  else
    echo $(percentage "$vol" " " " " "墳" " ")
  fi
}

get_class () {
  local vol=$(get_percentage)
  if [[ $vol == "muted" ]]; then
    echo "red"
  else
    echo $(percentage "$vol" "red" "magenta" "yellow" "blue")
  fi
}

get_vol () {
  local percent=$(get_percentage)
  echo $percent | tr -d '%'
}

if [[ $1 == "icon" ]]; then
  get_icon
fi

if [[ $1 == "class" ]]; then
  get_class
fi

if [[ $1 == "percentage" ]]; then
  get_percentage
fi

if [[ $1 == "vol" ]]; then
  get_vol
fi

if [[ $1 == "set" ]]; then
  val=$(echo $2 | tr '.' ' ' | awk '{print $1}')
  pamixer --set-volume $val --allow-boost --set-limit 150
fi
