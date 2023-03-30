#!/bin/bash

ROFI='rofi -theme ~/.config/rofi/themes/default'

INPUT=`echo "" | $ROFI -dmenu -p "Spell Check > "`
SPCHECK=`echo "$INPUT" | aspell -a`

SUGGESTIONS=`echo "$SPCHECK" | grep '^\*'`
if [ -n "$SUGGESTIONS" ]; then
    CHOICE=`echo "Spelling is correct" | $ROFI -dmenu -p ""`
    test -n "$CHOICE" && echo -n "$INPUT" | wl-copy
    exit 0
fi
SUGGESTIONS=`echo "$SPCHECK" | grep '^#'`
if [ -n "$SUGGESTIONS" ]; then
    echo "No Matches" | $ROFI -dmenu -p "" -no-fixed-num-lines -lines 0
    exit 1
fi
SUGGESTIONS=`echo "$SPCHECK" | grep '^&'`
if [ -n "$SUGGESTIONS" ]; then
    # Got a bunch of matches
    SUGGESTIONS=`echo "$SUGGESTIONS" | python -c 'import sys; x = sys.stdin.read(); print("\n".join([s.strip() for s in x.split(":")[1].split(",")]))'`
    CHOICE=`echo "$SUGGESTIONS" | $ROFI -dmenu -p "Suggestion to Clipboard: "`
    test -n "$CHOICE" && echo -n "$CHOICE" | wl-copy
    exit 0
fi

echo "An error occured: "
echo "  INPUT:       $INPUT"
echo "  SPCHECK:     $SPCHECK"
echo "  SUGGESTIONS: $SUGGESTIONS"
exit 1

