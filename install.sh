#!/bin/sh

log_console=s
verbose=1
wait_time=360 # Default time to wait before running a newly added check
KEEP_CFG="false"
. ./common.sh

usage ()
{
  cat <<EOF >&2
 `basename $0`: Install monopus monitoring software
sh ./`basename $0` [-hd] -k <api_key>
 	-h 				- Print this message
 	-d 				- Deinstall monopus monitor
 	-k<api_key>		- API_KEY (get in your profile)
	-u 				- Forced file update
Examples:
sh ./`basename $0` -kPtXwn4Stv3UdbmvEyEKHfvKEVdGyWN2Lh0iF4b8Ae2Oppj4YYO - Initialise subscription
EOF
  exit 0
}

do_deinstall()
{
  log "Deinstalling programs"

  # Send stop command

  # id=$(cat $CFG_FN | get_param id) # hostname
  # CFG_API_KEY=$(cat $CFG_FN | get_param api_key)
  # check_curl
  # res=$($RETR "$PORTAL_URL?api_key=$CFG_API_KEY&action=delete&host_id=$id"|./json.sh -l)
  # err=$(get_opt "$res" error)
  # if [ "$err" ]; then
  #   msg=$($PRINTF "$err")
  #   log "Error deleting server: $msg"
  #   exit 1
  # fi
  # result=$(get_opt "$res" result)
  # log "Unregistration result: $($PRINTF "$result")"
  # echo

  # if [ -f /etc/redhat-release ]; then
  #   case $(cut -f1 -d' ' < /etc/redhat-release) in
  #     CentOS)
  # 	service monopus stop
  # 	chkconfig --del monopus;;
  #   esac
  #   rm /etc/init.d/monopus
  # elif [ -f /etc/debian_version ]; then
  #   service monopus stop
  #   rm /etc/init.d/monopus
  #   update-rc.d monopus remove
  # else
  #   : # Some other OS, not supported yet
  # fi
  systemctl disable monopus
  
  rm -rf /etc/monopus.cfg $BASE $VAR
  
  log "Program deinstalled"
  exit 0
}

do_install()
{
  log "Installing programs"
  # Installing to /opt/monopus, also need /var/monopus
  for i in $BASE/check_scripts $VAR; do test -d $i || mkdir -p $i; done
  cp common.sh json.sh monopus $BASE # send_nrdp.sh
  cp -r check_scripts/* $BASE/check_scripts
  chmod -R +x $BASE/check_scripts/
  
  if (!($KEEP_CFG)); then
	cp monopus.cfg $CFG_FN
  fi
  
  cp monopus.service /etc/systemd/system/
  systemctl enable monopus
  systemctl start monopus
  
  log "Programs installed"
}

# major: ${1%.*} minor: ${1#*.}
# returns true if version in $1 is lower (<) than in $2
ver_lt()
{
  [ ${1%.*} -lt ${2%.*} ] || [ ${1%.*} -eq ${2%.*} -a ${1#*.} -lt ${2#*.} ]
}

while getopts "?duk:" opt; do
  case $opt in
    k) CFG_API_KEY=$OPTARG;;
    d) do_deinstall;;
    u) KEEP_CFG="true";;
    ?) usage;;
  esac
done
shift $((OPTIND-1))

[ $(id -u) -ne 0 ] && { log "Need root privileges to install"; exit 1; }

check_curl

hostname=$(hostname)
if [ -f $CFG_FN ]; then
  log "Monopus is already installed, checking if we need to update files"
  our_ver=$(cat $CFG_FN | get_param version)
  new_ver=$(cat version.txt)
  if ver_lt $new_ver ${our_ver:-0.00}; then
    log "You already have the latest version."
    exit 1
  fi
  
  # Stop service for supported distribs
  # [ -f /etc/redhat-release -o -f /etc/debian_version ] && service monopus stop
  systemctl stop monopus
else
  do_init=1

  [ "$CFG_API_KEY" ] || { log "API key is mandatory"; usage; exit 1; }
  #create_object
fi

do_install $KEEP_CFG

[ "$CFG_API_KEY" ] && set_param $CFG_FN api_key $CFG_API_KEY