#!/bin/bash

process="$1"
pidstat=$(/usr/bin/pidstat -u -I -C "$process" 120 1 | grep -v "^$" | grep -v "Average" | tail -n +3)
if [ "$(echo "$pidstat" | head -n1 | wc -w)" -eq 10 ]; then #remove AM or PM from pidstat
  pidstat=$(echo "$pidstat" | awk 'length($8) < 6 {print $8}')
else
  pidstat=$(echo "$pidstat" | awk 'length($8) < 6 {print $7}')
fi
echo "$pidstat" > "/opt/monopus/tmp/${process}_2min_stat.txt"