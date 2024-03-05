#!/bin/bash

sec=0
if [ "$1" = "Centos" ]; then                # if Centos
    sec=$(yum --security check-update 2>/dev/null | grep "security" | tail -n 1 | awk '{print $1}')
    if [ "$sec" = "No" ]; then
        sec=0
    fi
elif [ "$1" = "Debian" ] || [ "$1" = "Ubuntu" ]; then # if Debian or Ubuntu
    sec=$(apt list --upgradable 2>/dev/null | grep -c "-security")
fi
if [ -z "$sec" ]; then                      # if return empty - error
    sec="error"
fi
echo "$sec" > /opt/monopus/tmp/update-security # save result in tmp-file