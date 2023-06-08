#!/bin/bash
log_console=s
VERSION=1.0.5

which ed 2>&- >/dev/null && ED="ed" 
if which ex 2>&- >/dev/null;then      # check install ed utitity
  ED="ex"
else
  echo "Need Ed installed, exit..."
  exit 1
fi

#BASE=/opt/monopus
BASE=/opt/monopus
VAR=/var/monopus
CFG_FN=/etc/monopus.cfg # Config file to store information in
CHECKS_FN=$VAR/checks.txt # Where we store checks to perform with their times
PORTAL_URL=http://portal.monopus.ru/test-api.html

PRINTF=/usr/bin/printf # Better printf for old linuxen, that supports \uNNNN
test -f $PRINTF || PRINTF="printf" # Use builtin

# Synopsis: set_param <config_file> <param> <value>
set_param()
{
  # For empty file or file without such parameter, otherwise d fails
  #echo "$2=" >> $1
  $ED -s "$1" <<EOF
g/^ *"$2": "/d
i
    "$2": "$3",
.
w
q
EOF
}

# Gets and outputs to stdout the value from JSON (passed as <var>) for the given
# key.
# get_opt <var> <name>
get_opt()
{
  echo "$1" | awk -F"\t" '$1=="[\"'$2'\"]"{print $2}'
}

# logs to logger its arguments, if there are no arguments, log stdin
log()
{  
  [ "$verbose" ] || return
  # log_console may be set to 's' to output to the stderr as well  
  if [ $# = 0 ]; then cat; else echo "$*"; fi |
#  sed "s/^/`date`: /g" | 
  logger -"${log_console}"t monopus
}

check_curl()
{
  if ! which curl >/dev/null; then
    if ! which wget >/dev/null; then
      log "wget must be installed to run the script"
      exit 1
    else
      log "curl must be installed to run the script"
      exit 1
    fi
  fi
}
