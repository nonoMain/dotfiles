
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
extract ()
{
	if [ -f "$1" ] ; then
		case $1 in
			*.tar.bz2)   tar xjf $1   ;;
			*.tar.gz)    tar xzf $1   ;;
			*.bz2)       bunzip2 $1   ;;
			*.rar)       unrar x $1   ;;
			*.gz)        gunzip $1    ;;
			*.tar)       tar xf $1    ;;
			*.tbz2)      tar xjf $1   ;;
			*.tgz)       tar xzf $1   ;;
			*.zip)       unzip $1     ;;
			*.Z)         uncompress $1;;
			*.7z)        7z x $1      ;;
			*.deb)       ar x $1      ;;
			*.tar.xz)    tar xf $1    ;;
			*.tar.zst)   unzstd $1    ;;
			*.war)       jar xvf $1   ;;
			*)           echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
	echo "'$1' is not a valid file"
	echo "usage: extract <file>"
	fi
}

## Alias
# tools
alias e='$EDITOR'
alias lg='lazygit'
# colors
alias grep='grep --color=auto'
alias tree='tree -AC'
# don't overwrite without notice
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# shorts
# e.g r ssh will repeat the last command that started with 'ssh'
alias r='fc -s'

alias cdprev='cd $OLD_PWD'
alias ..='cd ../'
alias ...='cd ../../'
alias cls='clear'
# ls
alias ll='ls -alF'
alias ls='ls --color=auto'
alias la='ls -A'
# lsd
if does_command_exist "lsd"; then
	alias ll='lsd -alF'
fi
if does_command_exist "figlet"; then
	alias asciiCalendar='watch -n 1 "date '+%D%n%T' | figlet -k"'
fi

# cd into directories
alias cdintonvimswap='cd $HOME/.local/share/nvim/swap/'
# workspaces (mainly for java)
alias deleteJavaWorkspace='rm -rf ~/workspaces/java'
# packages
alias update-packages='sudo pacman -Syu'
alias update-aurs='$aur_helper -Sua --noconfirm'
alias remove-unneeded-packages='sudo pacman -Rsn $(pacman -Qdtq)'
# check memeory leaks of binary files
if does_command_exist "valgrind"; then
	alias memcheckbin='valgrind --leak-check=summary'
else
	alias memcheckbin='echo "To use this alias valgrind must be found available"'
fi

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
	ps_line1+="${B_GREY}${BLACK}${right_arrow_sharp}${NC}"
	ps_line1+="${BOLD}${B_GREY}${WHITE} ${HOSTNAME} ${NC}"
	ps_line1+="${B_BLUE}${GREY}${right_arrow_sharp}${NC}"
	ps_line1+="${BOLD}${B_BLUE}${BLACK} ${path} ${NC}"
	ps_line1+="${BLUE}$right_arrow_sharp${NC}"
	if [ ! -z "$(parse_git_branch)" ]; then
		ps_line1+=' '
		ps_line1+="${GREEN}$left_arrow_round${NC}"
		ps_line1+="${BOLD}${B_GREEN}${BLACK}$(parse_git_branch)${NC}"
		ps_line1+="${GREEN}$right_arrow_round${NC}"
	fi

	# Second line
	ps_line2+="${BOLD}${BLUE}$right_arrow_sharp${NC}"

	PS1="${ps_line1}\n${ps_line2} "
}

PROMPT_COMMAND='ps1_fancy'

## Other
# support nvm
if [ -f '/usr/share/nvm/init-nvm.sh' ]; then
	source '/usr/share/nvm/init-nvm.sh'
fi

# Activate tmux on start
#if does_command_exist "tmux" && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#	exec tmux -u
#fi
