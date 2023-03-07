#!/bin/bash
state=0
SBM=0
SlaveSQL=0
SlaveIO=0
states_text=("ok" "warning" "critical" "unknown")

SlaveIORunning=$((mysql -e "SHOW SLAVE STATUS\G" | grep -E 'Slave_IO_Running:') | awk -F: '{print $2}')
SlaveSQLRunning=$((mysql -e "SHOW SLAVE STATUS\G" | grep -E 'Slave_SQL_Running:') | awk -F: '{print $2}')
SecondsBehindMaster=$((mysql -e "SHOW SLAVE STATUS\G" | grep -E 'Seconds_Behind_Master:') | awk -F: '{print $2}')

if [ "$SecondsBehindMaster" != " 0" ]  || [ "$SlaveSQLRunning" != " Yes" ] || [ "$SlaveIORunning" != " Yes" ]; then

 if ["$SecondsBehindMaster" != " 0"]; then
  SBM=1
 fi
 if ["$SlaveSQLRunning" != " Yes"]; then
  SlaveSQL=1
 fi
 if ["$SlaveIORunning" != " Yes"]; then
  SlaveIO=1
 fi

 state=2
fi

output="check_mysql_replication::${states_text[$state]} | SBM=$SBM;;;; SlaveSQL=$SlaveSQL;;;; SlaveIO=$SlaveIO;;;;"
echo ${output[@]}
exit $state
