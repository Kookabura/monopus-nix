#!/bin/bash

process="$1"
pidstat=$(/usr/bin/pidstat -u -I -C "$process" 120 1 | grep -v "^$" | grep -v "Average" | tail -n +3)
echo "$pidstat" > "/tmp/${process}_2min_stat.txt"