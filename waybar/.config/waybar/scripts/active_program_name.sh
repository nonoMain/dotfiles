PROG=`hyprctl activewindow | grep -oP 'class: \K[^\s]+'`
case "$PROG" in
	*wezterm) # wezterm has a weird name by default..
		printf "WezTerm";
		;;
	*)
		printf "$PROG";
		;;
esac
