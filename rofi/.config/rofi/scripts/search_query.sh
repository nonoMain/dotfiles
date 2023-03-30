#!/bin/bash

ROFI='rofi -theme ~/.config/rofi/themes/default'

declare -A URLS

URLS=(
  ["google"]="https://www.google.com/search?q="
  ["github"]="https://github.com/search?q="
  ["youtube"]="https://www.youtube.com/results?search_query="
)

# List for rofi
gen_list() {
    for i in "${!URLS[@]}"
    do
      echo "$i"
    done
}

platform=$( (gen_list) | $ROFI -dmenu -matching fuzzy -no-custom -location 0 -p "Search > " )

if [[ -n "$platform" ]]; then
query=$( (echo ) | $ROFI  -dmenu -matching fuzzy -location 0 -p "Query > " )

if [[ -n "$query" ]]; then
  url=${URLS[$platform]}$query
  xdg-open "$url"
else
  exit
fi

else
exit
fi
