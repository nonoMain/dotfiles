#!/bin/bash

count=`paru -Qu | wc -l`
[[ $count -gt 0 ]] && echo " $count" || echo ""
