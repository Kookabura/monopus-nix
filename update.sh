#!/bin/bash
# Script update monopus
BASE=""                 # Absolute path from run update.sh
INST=/opt/mondistr      # Dir from install update
CFG_FN=/etc/monopus.cfg # Config file to store information in
UpdateLink=""           # From Update
Version="1.3"           # Version script

# Print help for Monopus
print_help() {
  echo "Monopus update script. Usage:"
  echo "update [-h] [-v]"
  echo "  -h     - Print this message"
  echo "  -v     - Print version monopus"
  echo "  <link> - Update monopus, default from: https://github.com/Kookabura/monopus-nix/archive/refs/heads/main.zip"
  exit 0
}

# Print version script update Monopus
print_version() {
  echo "Update monopus script version $Version"
  exit 0
}

# Check update link Monopus
check_update() {
  if [ -z "$UpdateLink" ]; then
    UpdateLink="https://github.com/Kookabura/monopus-nix/archive/refs/heads/main.zip"
  fi
  if [ -n "$1" ]; then
    UpdateLink=$1
  fi
}

# Check exist Monopus
check_monopus() {
  if [ -s "$CFG_FN" ];then
    echo "Check existing Monopus... success"
  else
    echo "Update fail. Monopus service do not exist!!! Please install him:"
    echo "${INST}/install.sh -k<api_key> or sudo ${INST}/install.sh -k<api_key>"
    exit 1
  fi
}

# Update version monopus in cfg file
update_ver() {
  new_ver=$(< ${INST}/monopus.cfg head grep "version")
  new_semi=$(< ${INST}/monopus.cfg grep "timeout")
  sed -i "s/.*version.*/$new_ver/" $CFG_FN       # update version in cfg 
  semicol=$(< /etc/monopus.cfg grep "timeout")
  if [ "${semicol: -1}" != "," ]; then          # if not semicolon in end line consist word 'timeout'
    sed -i "s/.*timeout.*/$new_semi/" $CFG_FN
  fi
  if ! < /etc/monopus.cfg grep "version"; then  # if not version line in cfg
    sed -n '6a\'"$new_ver"'' $CFG_FN
  fi
}

while getopts "hv?" opt; do
  case $opt in
    v) print_version;;
    h|?) print_help;;
    *) exit 0;;
  esac
done
shift $((OPTIND-1))
BASE="$(pwd -P)/$(basename "$0")"               # absolute path from run update.sh
echo "Update.sh run from: $BASE"
check_update "$1"
if [ "$(id -u)" -ne 0 ]; then
  echo -e "\n\nNeed root privileges to update monopus!!! Exit";
  exit 1;
fi
rm -rf  ${INST}                                 # delete if exist install directory, by default: /opt/mondistr 
echo "Starting update monopus..."
echo "Create Install directory."
mkdir -p $INST
if wget -c -q -O ${INST}/update.zip "$UpdateLink";then  # if success download from link update
  echo "Download monopus from link: success"
else
  echo "Download monopus from link: fail!  exit..."
  exit 1
fi
echo "Unpack files"
unzip -tq ${INST}/update.zip && unzip -oq -d $INST ${INST}/update.zip || exit 1
updatedir=$(ls -xd ${INST}/monopus-*/)
mv -f ${updatedir}libcrypto.so.10 /lib
mv -f ${updatedir}libssl.so.10 /lib
mv -f "$updatedir"* ${INST}
rm -rf  ${INST}/update.zip "$updatedir"
echo "Adding execute permissions to files"
if chmod +x -R ${INST};then
  echo "All right installed successful"
else
  echo "Fail set execution rights... exit"
  exit 1
fi
echo "Remove execution permissions from .service, .cfg and .md"
chmod 644 ${INST}/monopus.service ${INST}/monopus.cfg ${INST}/*.md
check_monopus
echo "I start the update through a script call: install.sh -u"
cd ${INST} || echo "Unable to change directory!"
update_ver
if bash ${INST}/install.sh -u; then
  echo "Update went without error"
  systemctl daemon-reload
  echo "Restarting monopus daemon"
  systemctl restart monopus
  rm -rf  ${INST} "${BASE}"
  echo "Update saccessful, well done."
else
  echo "Install.sh exit with error."
  systemctl daemon-reload             # in main 1.0.4 exist error, delele this 2 line, after
  systemctl restart monopus           # correction
  rm -rf  ${INST} "${BASE}"
fi
