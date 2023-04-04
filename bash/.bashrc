
# ~/.bashrc

## colors
if [[ -z $NO_COLOR ]]; then
	NC='\[\e[0m\]' # No Color
	BOLD='\[\e[1m\]'
	# Text colors
	RED='\[\e[31m\]'
	GREEN='\[\e[32m\]'
	YELLOW='\[\e[33m\]'
	BLUE='\[\e[34m\]'
	PURPLE='\[\e[35m\]'
	CYAN='\[\e[36m\]'
	WHITE='\[\e[37m\]'
	GREY='\[\e[90m\]'
	BLACK='\[\e[30m\]'
	# Background colors
	B_RED='\[\e[41m\]'
	B_GREEN='\[\e[42m\]'
	B_YELLOW='\[\e[43m\]'
	B_BLUE='\[\e[44m\]'
	B_PURPLE='\[\e[45m\]'
	B_CYAN='\[\e[46m\]'
	B_WHITE='\[\e[47m\]'
	B_GREY='\[\e[100m\]'
	B_BLACK='\[\e[40m\]'
else
	RED=''
	GREEN=''
	YELLOW=''
	BLUE=''
	PURPLE=''
	CYAN=''
	WHITE=''
	B_RED=''
	B_GREEN=''
	B_YELLOW=''
	B_BLUE=''
	B_PURPLE=''
	B_CYAN=''
	B_WHITE=''
	NC=''
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

## Settings
#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

## Env variables
case "$TERM" in
*)
	POTENTIAL_TERM=${TERM}-256color
	POTENTIAL_TERMINFO=${TERM:0:1}/$POTENTIAL_TERM

	BOX_TERMINFO_DIR=/usr/share/terminfo
	[[ -f $BOX_TERMINFO_DIR/$POTENTIAL_TERMINFO ]] && \
		export TERM=$POTENTIAL_TERM

	HOME_TERMINFO_DIR=$HOME/.terminfo
	[[ -f $HOME_TERMINFO_DIR/$POTENTIAL_TERMINFO ]] && \
		export TERM=$POTENTIAL_TERM
	;;
esac

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less -R --use-color -Dd+r -Du+b'
export aur_helper='paru'

## functions
does_command_exist ()
{
	hash "$1" > /dev/null 2>&1
}

press_to_confirm ()
{
	echo
	read -n 1 -s -r -p "$1"
	echo
}

return_proc_title ()
{
	ps -o comm $$ | tail -1
}

parse_git_branch ()
{
	#git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
	local branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
	# check if branch is an empty string
	if [ ! -z "$branch" ]; then
		printf "$branch"
	fi
}

# Goes up a specified number of directories  (i.e. up 4)
up ()
{
	local d=""
	limit=$1
	for ((i=1 ; i <= limit ; i++))
		do
			d=$d/..
		done
	d=$(echo $d | sed 's/^\///')
	if [ -z "$d" ]; then
		d=..
	fi
	cd $d
}

# IP address lookup
alias whatismyip="whatsmyip"
function whatsmyip ()
{
	# Dumps a list of all IP addresses for every device
	# /sbin/ifconfig |grep -B1 "inet addr" |awk '{ if ( $1 == "inet" ) { print $2 } else if ( $2 == "Link" ) { printf "%s:" ,$1 } }' |awk -F: '{ print $1 ": " $3 }';

	# Internal IP Lookup
	echo -n "Internal IP: " ; /sbin/ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'

	# External IP Lookup
	echo -n "External IP: " ; wget http://smart-ip.net/myip -O - -q
}

# @brief create a local git repo and push the first commit to new remote
# @param $1 the remote url
# @param $2 the wanted path for the local repo
git_init_local_of_new_remote ()
{
	local usage="Usage: git_init_local_of_new_remote <remote_name> [local-dir-name]"
	if [ $# -eq 0 ]; then
		echo $usage
		return 1
	fi
	local remote_url=$1;
	# check if remote url doesn't end with .git
	if [[ $remote_url != *".git" ]]; then
		echo "remote url must end with .git"
		return 1
	fi
	local remote_name=$(basename $remote_url)
	[ $# -ge 2 ] && local local_dir=$2 || local local_dir=$remote_name

	if [ -d $local_dir ]; then
		echo "dircetory $local_dir already exists"
		echo $usage
		return 1
	fi
	echo "Initializing local repo of remote $remote_name"
	echo "repo will be created in $local_dir"
	press_to_confirm "Press [ANY KEY] to start"

	mkdir -p $local_dir
	cd $local_dir # cd to local repo
	echo "# $remote_name" > README.md
	git init
	git add README.md
	git commit -m "initial commit"
	git branch -M master
	git remote add origin $remote_url
	git push -u origin master
	cd $OLDPWD # go back to previous directory
}

# @brief copy a branch of a git repo as an archive
# @brief without the .git folder
# @param $1 remote name
# @param $2 branch name [default: master]
# @param $3 archive format [default: zip]
git_copy_branch ()
{
	if [ $# -ge 1 ]; then
		local url=$1;
		# remove .git suffix from url if present
		if [[ $url =~ .git$ ]]; then
			url=${url%.*}
		fi
	else
		echo "url is not specified and needed"
		return 1
	fi
	[ $# -ge 2 ] && local branch=$2 || local branch="master"
	[ $# -ge 3 ] && local format=$3 || local format="zip"
	local dest="$(basename $url).$branch.$format"
	local archive_url="$url/archive/$branch.$format"
	local run="wget -O $dest $archive_url"
	echo "copying $branch branch"
	echo "from $url"
	echo "in $format format"
	echo "to $dest"
	echo "by running: $run"
	press_to_confirm "Press [ANY KEY] to start"
	$run
}

# @brief extract archive
# @param $1 archive path
# Extracts any archive(s) (if unp isn't installed)
extract () {
	for archive in "$@"; do
		if [ -f "$archive" ] ; then
			case $archive in
				*.tar.bz2)   tar xvjf $archive    ;;
				*.tar.gz)    tar xvzf $archive    ;;
				*.bz2)       bunzip2 $archive     ;;
				*.rar)       rar x $archive       ;;
				*.xz)        unxz $archive        ;;
				*.gz)        gunzip $archive      ;;
				*.tar)       tar xvf $archive     ;;
				*.tbz2)      tar xvjf $archive    ;;
				*.tgz)       tar xvzf $archive    ;;
				*.zip)       unzip $archive       ;;
				*.Z)         uncompress $archive  ;;
				*.7z)        7z x $archive        ;;
				*)           echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

# Expand the history size
export HISTFILESIZE=10000
export HISTSIZE=500

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend

export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

## Alias
# tools
alias e='$EDITOR'
alias less='less -R --use-color -Dd+r -Du+b'
# colors
alias tree='tree -AC'
# don't overwrite without notice
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

alias dotfiles='cd ~/dotfiles'

alias rewaybar='killall waybar; waybar &'

# shorts
# e.g r ssh will repeat the last command that started with 'ssh'
alias r='fc -s'
# Search command line history
alias h="history | grep "
# Find files in current folder
alias f="find . | grep "

alias grep='grep --color=auto'

# Alias's for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
# ls
alias ll='ls -alF'
alias ls='ls --color=auto'
alias la='ls -A'
# lsd
if does_command_exist "lazygit"; then
	alias lg='lazygit'
fi
if does_command_exist "lsd"; then
	alias ll='lsd -alF'
	alias ls='lsd'
	alias la='lsd -A'
fi
if does_command_exist "figlet"; then
	alias asciiCalendar='watch -n 1 "date '+%D%n%T' | figlet -k"'
fi
if does_command_exist "tty-clock"; then
	alias asciiClock='tty-clock -s -c'
	alias ttyClock='tty-clock -s -c -C'
	alias tty-clock='tty-clock -s -c'
fi

# Add an "alert" alias for long running commands.  e.g: sleep 10; alert
if does_command_exist "dunstify"; then
	alias alert='dunstify --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
else
	alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi

alias cdprev='cd $OLD_PWD'
alias cdintonvimswap='cd $HOME/.local/share/nvim/swap/'
# workspaces (mainly for java)
alias deleteJavaWorkspace='rm -rf ~/workspaces/java'
# packages
alias update-packages='sudo pacman -Syu --noconfirm'
alias update-aurs='$aur_helper -Sua --noconfirm'
alias remove-unneeded-packages='sudo pacman -Rsn $(pacman -Qdtq)'
# check memeory leaks of binary files
if does_command_exist "valgrind"; then
	alias memcheckbin='valgrind --leak-check=summary'
	alias memcheckbinfull='valgrind --leak-check=summary'
else
	alias memcheckbin='echo "To use this alias valgrind must be found available"'
	alias memcheckbinfull='echo "To use this alias valgrind must be found available"'
fi
alias testcolors='curl -s https://raw.githubusercontent.com/JohnMorales/dotfiles/master/colors/24-bit-color.sh | bash'

## PS1
PS_PATH_MAX_LENGTH=35
#### symbols
# l is ┌
# m is └
PS_SYMBOL ()
{
	local symbol=$1
	printf '\[\e(0\]%s\[\e(B\]' "$symbol"
}
### PS1 - simple version
# l is ┌
# m is └
ps1_simple ()
{
	local last_return=$?

	local path=${PWD/#$HOME/\~}
	local offset=$(( ${#path} - ${PS_PATH_MAX_LENGTH} ))
	if [ $offset -gt 0 ]; then
		path=${path:$offset:$PS_PATH_MAX_LENGTH}
		path=[..]${path#*/}
	fi

	local ps_line1=""
	local ps_line2=""
	# First line
	ps_line1+="${BLUE}$(PS_SYMBOL 'l')${NC}"
	ps_line1+="${BLUE}[${NC}"
	ps_line1+="${NC}${USER}${RED}@${NC}${HOSTNAME}${NC}"
	ps_line1+="${BLUE}]${NC}"
	ps_line1+=" ${GREEN}→ ${NC}"
	ps_line1+="${BLUE}${path}${NC}"
	if [ ! -z "$(parse_git_branch)" ]; then
		ps_line1+=" "
		ps_line1+="${GREEN}(${NC}"
		ps_line1+="${BOLD}${GREEN} $(parse_git_branch)${NC}"
		ps_line1+="${GREEN})${NC}"
	fi
	# Second line
	ps_line2+="${BLUE}$(PS_SYMBOL 'm')${NC}"
	ps_line2+="${BLUE}[${NC}"
	if [ $last_return -eq 0 ]; then
		ps_line2+="${GREEN}$last_return${NC}"
	else
		ps_line2+="${RED}$last_return${NC}"
	fi
	ps_line2+="${BLUE}]${NC}"
	ps_line2+="${BLUE}\$ ${NC}"

	PS1="${ps_line1}\n${ps_line2}"
}

ps1_fancy ()
{
	local last_return=$?
	local right_arrow_sharp=''
	local left_arrow_sharp=''
	local right_arrow_round=''
	local left_arrow_round=''

	local path=${PWD/#$HOME/\~}
	local offset=$(( ${#path} - ${PS_PATH_MAX_LENGTH} ))
	if [ $offset -gt 0 ]; then
		path=${path:$offset:$PS_PATH_MAX_LENGTH}
		path=[..]${path#*/}
	fi

	local ps_line1=""
	local ps_line2=""
	# First line
	if [ $last_return -eq 0 ]; then
		ps_line1+="${B_BLACK}${GREEN} ✔ ${NC}"
	else
		ps_line1+="${B_BLACK}${RED} ✘:$last_return ${NC}"
	fi
	ps_line1+="${BOLD}${B_BLACK}${WHITE} ${USER} ${NC}"
	case $HOSTNAME in
		*server*)
			ps_line1+="${B_RED}${BLACK}${right_arrow_sharp}${NC}"
			ps_line1+="${BOLD}${B_RED}${WHITE} ${HOSTNAME} ${NC}"
			ps_line1+="${B_BLUE}${RED}${right_arrow_sharp}${NC}"
			;;
		*)
			ps_line1+="${B_GREY}${BLACK}${right_arrow_sharp}${NC}"
			ps_line1+="${BOLD}${B_GREY}${WHITE} ${HOSTNAME} ${NC}"
			ps_line1+="${B_BLUE}${GREY}${right_arrow_sharp}${NC}"
			;;
	esac
	ps_line1+="${BOLD}${B_BLUE}${BLACK} ${path} ${NC}"
	if [ -z "$(parse_git_branch)" ]; then
		ps_line1+="${BLUE}$right_arrow_sharp${NC}"
	else
		ps_line1+="${B_GREEN}${BLUE}$right_arrow_sharp${NC}"
		ps_line1+="${BOLD}${B_GREEN}${BLACK} $(parse_git_branch) ${NC}"
		ps_line1+="${GREEN}$right_arrow_sharp${NC}"
	fi

	# Second line
	ps_line2+="${BOLD}${BLUE}$right_arrow_sharp${NC}"

	PS1="${ps_line1}\n${ps_line2} "
}

if does_command_exist "starship"; then
	eval "$(starship init bash)"
else
	PROMPT_COMMAND='ps1_fancy'
fi

## Other
# support nvm
if [ -f '/usr/share/nvm/init-nvm.sh' ]; then
	source '/usr/share/nvm/init-nvm.sh'
fi

# Activate tmux on start
# if does_command_exist "tmux" && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
# 	tmux; exit
# fi
