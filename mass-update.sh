#!/bin/bash

#usage:
#./mass-update.sh <pass-file> <command update> 

copyleft() {
  echo ""
  echo "Usage ./mass-update.sh <pass-file> <command update>"
  echo ""
  echo "Copyleft TolkIT (team@tolkit.top)"
  echo "author Sergey Egorushkin (SeroEgor@Gmail.com)"
}

LOG=mass-update.log                         #create log file
touch $LOG && echo "" > $LOG

if [ -n "$2" ]; then                        #if <command update> not empty
  if [ -s "$1" ]; then                      #if <pass-file> exist and greater than zero
    hosts=$(echo "$( < "$1" wc -l) - 2" | bc -l) # number hosts in <pass-file>
    if [ "$hosts" -gt 0 ]; then             #if number hosts in <pass-file> greater zero
      IFS=',' read -ra PASSES <<< "$( < "$1" tail -n "$hosts" | tr -s '\n' ',')" #create array lines with credentials
      for PASS in "${PASSES[@]}"            # 1 line with credential
      do
        pass=$(echo "$PASS" | awk '{print $1}')  #password
        login=$(echo "$PASS" | awk '{print $2}') #login
        ip=$(echo "$PASS" | awk '{print $3}')    #ip
        if sshpass -p "${pass}" ssh -o StrictHostKeyChecking=no "${login}@${ip}" "$2"; then
           echo "Update on ${login}@${ip} ($(hostname)) - success" >> $LOG # loggin success
        else                                                 # loggin fail
           echo "Update on ${login}@${ip} ($(hostname)) - fail, exit code $?" >> $LOG
        fi 
      done
    else
      echo "file with passwords is empty"
      copyleft
    fi
  else
    echo "File with passwords not exist: $1"
    copyleft
  fi
else
  echo "Please enter update command as second argument"
  copyleft
fi