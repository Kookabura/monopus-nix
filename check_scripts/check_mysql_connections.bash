#!/bin/bash

function usage {
  echo "$(basename $0) usage: "
  echo "    -w warning_level Example: 80"
  echo "    -c critical_level Example: 90"
  echo "    -u username Example: root"
  echo "    -p password Example: 1234"
  echo "    -h host Example: localhost"
  echo "    --defaults-file <FILE_PATH> "
  echo ""
  exit 1
}

while [[ $# -gt 1 ]]
do
  key="$1"
  case $key in
    -w)
    WARN="$2"
    shift
    ;;
    -c)
    CRIT="$2"
    shift
    ;;
    -u)
    USER="$2"
    shift
    ;;
    -p)
    PASS="$2"
    shift
    ;;
    -h)
    HOST="$2"
    shift
    ;;
    --defaults-file)
    FILE="$2"
    shift
    ;;
    *)
    usage
    shift
    ;;
  esac
  shift
done

[ ! -z ${WARN} ] && [ ! -z ${CRIT} ] || usage
if [ ! -z ${FILE} ]; then
  CONNECTIONS=$(echo "show processlist;" | mysql --defaults-file=${FILE} 2> /dev/null | sed 1,1d  | wc -l)
  SECONDS_BEHINDE_MASTER=$(echo "SHOW SLAVE STATUS\G;" | mysql | grep 'Seconds_Behind_Master' | awk '{print $2}')
else
  CONNECTIONS=$(echo "show processlist;" | mysql  2> /dev/null | sed 1,1d | wc -l)
  SECONDS_BEHINDE_MASTER=$(echo "SHOW SLAVE STATUS\G;" | mysql | grep 'Seconds_Behind_Master' | awk '{print $2}')
  MAX_CONNECTIONS=$(echo "show variables like 'max_connections';" | mysql 2> /dev/null | sed 1,1d | awk '{print $2}')
fi
if [[ $? -ne 0 ]]
then
  echo "check_mysql_connections_unknown"
  exit 3
elif [[ ${CONNECTIONS} -gt ${CRIT} ]]
then
  echo "check_mysql_connections_critical::connections==${CONNECTIONS} | connections=${CONNECTIONS};;;;${MAX_CONNECTIONS}; seconds_behind_master=${SECONDS_BEHINDE_MASTER};;;;"
  exit 2
elif [[ ${CONNECTIONS} -gt ${WARN} ]]
then
  echo "check_mysql_connections_warning::connections==${CONNECTIONS} | connections=${CONNECTIONS};;;;${MAX_CONNECTIONS}; seconds_behind_master=${SECONDS_BEHINDE_MASTER};;;;"
  exit 1
else
  echo "check_mysql_connections_ok::connections==${CONNECTIONS} | connections=${CONNECTIONS};;;;${MAX_CONNECTIONS}; seconds_behind_master=${SECONDS_BEHINDE_MASTER};;;;"
  exit 0
fi