
# ~/.bashrc

# colors \[\033[COLORm\]
NC="\[\033[0m\]"
BLUE="\[\033[0;34m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
RED="\[\033[0;31m\]"

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

source ~/.useful_functions

## Alias
# tools
alias e='$EDITOR'
alias tmux='tmux -u' # tell tmux to use utf-8
alias btop='btop --utf-force' # tell btop to use utf-8
alias lg='lazygit'
# colors
alias grep='grep --color=auto'
alias tree='tree -AC'
# don't overwrite without notice
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# ls
alias ll='ls -alF'
alias ls='ls --color=auto'
alias la='ls -A'
# lsd
if does_command_exist "lsd"; then
	alias ll='lsd -alF'
fi

# shorts
alias cdprev='cd $OLD_PWD'
alias ..='cd ../'
alias ...='cd ../../'

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

ps1_git_branch ()
{
	local branch=$(parse_git_branch)
	if [ ! -z "$branch" ]; then
		printf "( $branch)"
	fi
}

ps1_add_title ()
{
	export PS1="$PS1${BLUE}[${NC}$1${BLUE}]${NC} "
}

PS_USER="${NC}\u"
PS_HOST="${NC}\h"
PS_INFO="${PS_USER}${RED}@${PS_HOST}"

PS_DIR="${BLUE}\w"
PS_DIR_ARROW="${GREEN}→"
PS_GIT_BRANCH="${GREEN}\$(ps1_git_branch)"

# l is ┌
# m is └
PS_SYM1='\[\e(0\]l\[\e(B\]'
PS_SYM2='\[\e(0\]m\[\e(B\]'


PS_FULL="${BLUE}${PS_SYM1}[${PS_INFO}${BLUE}] ${PS_DIR_ARROW} ${PS_DIR} ${PS_GIT_BRANCH}\n${BLUE}${PS_SYM2}$ "
PS1="${PS_FULL}${NC}"

