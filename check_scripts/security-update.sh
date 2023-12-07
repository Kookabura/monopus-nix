#!/bin/bash

sec=0
if [ "$1" = "Centos" ]; then
    sec=$(yum --security check-update 2>/dev/null | grep "security" | tail -n 1 | awk '{print $1}')
    if [ "$sec" = "No" ]; then
        sec=0
    fi
elif [ $1 = "Debian" ] || [ "$1" = "Ubuntu" ]; then
    sec=$(apt list --upgradable 2>/dev/null | grep -c "-security")
fi
echo "$sec" > ../tmp/update-security