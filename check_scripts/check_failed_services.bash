#!/bin/bash

if [ -f /bin/systemctl ]; then
	failed=$(/bin/systemctl --failed --no-legend)
	failed=${failed/ */}		# Strip everything after first space
	failed=${failed/.service/}	# Strip .service suffix

	if [ "$failed" != "" ]; then
		#echo "Failed units: ${failed[@]} || ${#failed[@]}"
		echo "check_failed_services.critical::services==$failed | services=${#failed[@]};;;"
		exit 2
	else
		echo "check_failed_services.ok::services==services==$failed | services=${#failed[@]};;;"
		exit 0
	fi
else
	echo "check_failed_services.unknown::services==services==$failed | services=${#failed[@]};;;"
	exit 3
fi