#!/bin/bash

# ================================================
# Script Name: phase-11.sh
# Purpose: Automation of simple backup task
# Usage: ./phase-11.sh
# ================================================

#1.-----Initializing variables-----
SOURCE="$HOME/scripts/reports"
BACKUP="$HOME/scripts/backup"

#2.-----Confirming the backup path-----
mkdir -p "$BACKUP"

#3.-----Creating backup file-----
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVE="$BACKUP/reports_$DATE.tar.gz"

#4.-----zipping and archiving the source file-----
tar -czf "$ARCHIVE" "$SOURCE"

if [[ $? -eq 0 ]]
then
	echo "[$DATE] Successfully backed-up: $ARCHIVE"
else
	echo "[$DATE] Backup Failed"
fi

