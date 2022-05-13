
# ~/.bashrc
# File Documentation
# Filename: .bashrc
# Author: nonomain
# last updated: 26/01/22 17:18:28
# Description:
# bash configuration

# colors
DEFAULT="\033[0m"
BLUE="\033[01;34m"
YELLOW="\033[0;33m"
GREEN="\033[0;32m"
RED="\033[0;31m"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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
#MANPAGER="less -R --use-color -Dd+r -Du+b"
export PAGER='less -R --use-color -Dd+r -Du+b'
aur_helper='paru'

## functions

# input:
# msg to print before asking for input
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
ps1_git_branch ()
{
	local branch=$(parse_git_branch)
	if [ ! -z "$branch" ]; then
		printf "( $branch)"
	fi
}

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

# ARCHIVE EXTRACTION
# usage: extract <file>
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
alias tmux='tmux -u' # tell tmux to use utf-8
# colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias tree='tree -AC'
# don't overwrite without notice
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
# shorts
alias cdprev='cd $OLD_PWD'
alias ..='cd ../'
alias ...='cd ../../'

alias ll='ls -alF'
alias la='ls -A'
alias cls='clear'

#util aliases
# cd into nvim swap dircetory
alias cdintonvimswap='cd $HOME/.local/share/nvim/swap/'
# Delete workspace (mainly for java)
alias deleteWorkspace='rm -rf ~/workspace/'
# update all AUR pkgs
alias update-aurs='$aur_helper -Sua --noconfirm'
# check memeory leaks of binary files
alias memcheckbin=valgrind --leak-check=summary

# Activate tmux on start
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
# 	exec tmux -u
# fi

# PS1

PS_USER="${DEFAULT}\u"
PS_HOST="${DEFAULT}\h"
PS_INFO="${PS_USER}${RED}@${PS_HOST}"

PS_DIR="${BLUE}\W"
PS_DIR_ARROW="${GREEN}→"
PS_GIT_BRANCH="${GREEN}\$(ps1_git_branch)"

PS_FULL="${BLUE}┌[${PS_INFO}${BLUE}] ${PS_DIR_ARROW} ${PS_DIR} ${PS_GIT_BRANCH}\n${BLUE}└$ "

PS1="${PS_FULL}${DEFAULT}"
