#!/usr/bin/env bash
# locale
LC_ALL="C.UTF-8"
TZ=:/etc/localtime

Help()
{
    echo "This script launch Eww or a window in daemon mode & it can toggle or kill it all too."
    echo
    echo "Syntax: ./eww.sh [-h] [-w \"<window_title>\"] [-k]"
    echo "options:"
    echo "-h                     Print this Help"
    echo "-w \"<window_title>\"  Fixed terminal title"
    echo "-k                     kill the daemon"
    echo
}

while getopts ":hw:k" option; do
    case $option in
        h ) Help
            exit 0 ;;
        w ) _windowTitle="${OPTARG}" ;;
        k ) eww kill
            killall eww
            exit 0 ;;
        \?) echo -e "Unknown option: -$OPTARG \n" >&2; Help; exit 1;;
        : ) echo -e "Missing argument for -$OPTARG \n" >&2; Help; exit 1;;
        * ) echo -e "Unimplemented option: -$option \n" >&2; Help; exit 1;;
    esac
done

if [[ -z $_windowTitle ]]; then
    echo -e "Error: option -w is mandatory. \n" >&2; Help; exit 1
fi

if pgrep -f "eww open $_windowTitle"; then
    # Eww window is running outside of a daemon
    killall eww
    eww daemon
    sleep 2
    eww open $_windowTitle
elif pgrep -f "eww daemon"; then
    # Eww Daemon is running
    if [[ "$(eww state)" == "" ]]; then
        # no window running currently
        eww open $_windowTitle
    else
        eww close-all
    fi
else
    # Eww Daemon not running
    killall eww
    eww daemon
    sleep 2
    eww open $_windowTitle
fi
