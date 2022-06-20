#!/bin/bash

###########################
####### LOAD CONFIG #######
###########################

while [ $# -gt 0 ]; do
	case $1 in
		-c)
			CONFIG_FILE_PATH="$2"
			shift 2
			;;
		*)
			${ECHO} "Unknown Option \"$1\"" 1>&2
			exit 2
			;;
	esac
done

if [ -z "$CONFIG_FILE_PATH" ] ; then
	SCRIPTPATH=$(cd "${0%/*}" && pwd -P)
	CONFIG_FILE_PATH="${SCRIPTPATH}/pg_backup.config"
fi

if [ ! -r "${CONFIG_FILE_PATH}" ] ; then
	echo "Could not load config file from ${CONFIG_FILE_PATH}" 1>&2
	exit 1
fi

source "${CONFIG_FILE_PATH}"

###########################
#### PRE-BACKUP CHECKS ####
###########################

# Make sure we're running as the required backup user
if [ "$BACKUP_USER" != "" ] && [ "$(id -un)" != "$BACKUP_USER" ] ; then
	echo "This script must be run as $BACKUP_USER. Exiting." 1>&2
	exit 1
fi


###########################
### INITIALISE DEFAULTS ###
###########################

if [ ! "$USERNAME" ]; then
	USERNAME="postgres"
fi;


###########################
#### START THE BACKUPS ####
###########################

function perform_backups()
{
	FINAL_BACKUP_DIR="$BACKUP_DIR/pg/"

	echo "Making backup directory in $FINAL_BACKUP_DIR"

	if ! mkdir -p "$FINAL_BACKUP_DIR"; then
		echo "Cannot create backup directory in $FINAL_BACKUP_DIR. Go and fix it!" 1>&2
		exit 1;
	fi;

	#######################
	### GLOBALS BACKUPS ###
	#######################

	echo -e "\n\nPerforming globals backup"
	echo -e "--------------------------------------------\n"

	if [ "$ENABLE_GLOBALS_BACKUPS" = "yes" ]
	then
		    echo "Globals backup"

		    set -o pipefail
		    if ! pg_dumpall -g -U "$USERNAME" -w --file="$FINAL_BACKUP_DIRglobals.sql.in_progress"; then
			    echo "[!!ERROR!!] Failed to produce globals backup" 1>&2
		    else
			    mv -v "$FINAL_BACKUP_DIRglobals.sql.in_progress" "$FINAL_BACKUP_DIRglobals.sql"
		    fi
		    set +o pipefail
	else
		echo "None"
	fi


	###########################
	### SCHEMA-ONLY BACKUPS ###
	###########################

	for SCHEMA_ONLY_DB in ${SCHEMA_ONLY_LIST//,/ }
	do
		SCHEMA_ONLY_CLAUSE="$SCHEMA_ONLY_CLAUSE or datname ~ '$SCHEMA_ONLY_DB'"
	done

	SCHEMA_ONLY_QUERY="select datname from pg_database where false $SCHEMA_ONLY_CLAUSE order by datname;"

	echo -e "\n\nPerforming schema-only backups"
	echo -e "--------------------------------------------\n"

	SCHEMA_ONLY_DB_LIST=$(psql -U "$USERNAME" -w -At -c "$SCHEMA_ONLY_QUERY" postgres)

	echo -e "The following databases were matched for schema-only backup:\n${SCHEMA_ONLY_DB_LIST}\n"

	for DATABASE in $SCHEMA_ONLY_DB_LIST
	do
		echo "Schema-only backup of $DATABASE"
		set -o pipefail
		if ! pg_dump -Fd -Z 0 -s -U "$USERNAME" -w "$DATABASE" --file="$FINAL_BACKUP_DIR""$DATABASE"_SCHEMA.in_progress; then
			echo "[!!ERROR!!] Failed to backup database schema of $DATABASE" 1>&2
		else
			mv -v "$FINAL_BACKUP_DIR""$DATABASE"_SCHEMA.in_progress "$FINAL_BACKUP_DIR""$DATABASE"_SCHEMA
		fi
		set +o pipefail
	done


	###########################
	###### FULL BACKUPS #######
	###########################

	for SCHEMA_ONLY_DB in ${SCHEMA_ONLY_LIST//,/ }
	do
		EXCLUDE_SCHEMA_ONLY_CLAUSE="$EXCLUDE_SCHEMA_ONLY_CLAUSE and datname !~ '$SCHEMA_ONLY_DB'"
	done

	FULL_BACKUP_QUERY="select datname from pg_database where not datistemplate and datallowconn $EXCLUDE_SCHEMA_ONLY_CLAUSE order by datname;"

	echo -e "\n\nPerforming full backups"
	echo -e "--------------------------------------------\n"

	for DATABASE in $(psql -U "$USERNAME" -w -At -c "$FULL_BACKUP_QUERY" postgres)
	do
		echo "Custom backup of $DATABASE"

		if ! pg_dump -Z 0 -Fd -U "$USERNAME" -w "$DATABASE" -f "$FINAL_BACKUP_DIR""$DATABASE".in_progress; then
			echo "[!!ERROR!!] Failed to produce custom backup database $DATABASE"
		else
			mv -v "$FINAL_BACKUP_DIR""$DATABASE".in_progress "$FINAL_BACKUP_DIR""$DATABASE"
		fi

	done

	echo -e "\nAll database backups complete!"
}

function upload_backups()
{
	FINAL_BACKUP_DIR=$BACKUP_DIR/pg/
	if [ ! -d "$FINAL_BACKUP_DIR" ]; then
		echo "Backup directory in $FINAL_BACKUP_DIR dosn't exist. Go and fix it!" 1>&2
		exit 1;
	fi;

	if [ ! "$BORG_REPO" ]; then
		echo "You need to provide borg repo URI" 1>&2
		exit 1;
	fi;
	export BORG_REPO=$BORG_REPO

	echo "Uploading backup directory to $BORG_REPO"

	set -o pipefail
	if ! borg create --verbose --filter AME  --list --stats --show-rc \
	                 --compression "$BORG_COMPRESSION" --exclude **/*.in_progress \
	                 ::"$BORG_ARCHIVE_NAME" "$FINAL_BACKUP_DIR"; then
		echo "[!!ERROR!!] Failed to upload files" 1>&2
	else
		rm -r "$FINAL_BACKUP_DIR"
	fi
	set +o pipefail
}

perform_backups
upload_backups
