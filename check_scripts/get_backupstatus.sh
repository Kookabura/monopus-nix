#!/bin/bash

BACKUP_STORAGE="/backups/bases/*"
NEW_COPIES=$(find $BACKUP_STORAGE -type f -mtime -2 | wc -l)
ALL_COPIES=$(find $BACKUP_STORAGE -type f -mtime -7 | wc -l)

if [ $NEW_COPIES -lt 1 ]; then
        echo "get_backupstatus.err.day_missing_copies | copies=$ALL_COPIES;;;;"
        exit 2
fi

if [ $ALL_COPIES -lt 7 ]; then
        echo "get_backupstatus.err.week_missing_copies | copies=$ALL_COPIES;;;;"
        exit 1
fi

# The check runs very fast without it and we've got false alerts
# opt/monopus/monopus: line 212: wait: pid 2110 is not a child of this shell 
sleep 2

echo "get_backupstatus.ok | copies=$ALL_COPIES;;;;"
exit 0
