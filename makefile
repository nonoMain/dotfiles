# This makefile will run stow on all directories and make will change all the current files to the ones in this repo

.PHONY: all
all:
	stow */ --adopt --target=${HOME}
	git reset --hard
