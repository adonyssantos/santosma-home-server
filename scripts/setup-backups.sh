#!/bin/bash

# This script sets up a cron job to run the backup script every day
# at a specific time. The time is specified in the UTC variable.
# @arg1: Mega.nz email
# @arg2: Mega.nz password

UTC=-4 # America/Santo_Domingo
HOUR=2 # 2 AM on America/Santo_Domingo
MEGA_EMAIL=$1
MEGA_PASSWORD=$2
BASE_DIR="$(pwd)"
CREATE_BACKUP_SCRIPT="bash $BASE_DIR/create-backup.sh $BASE_DIR"
ERROR_LOG_FILE="$BASE_DIR/../logs/setup-backups.error.log"

# Check if the megacli command is available
if ! command -v megacli >/dev/null 2>&1; then
  echo "Error: megacli command not found. Please make sure Mega.nz is installed."
  exit 1
fi

# Check if the crontab command is available
if ! command -v crontab >/dev/null 2>&1; then
  echo "Error: crontab command not found. Please make sure cron is installed."
  exit 1
fi

# Login to Mega.nz
mega-login $MEGA_EMAIL $MEGA_PASSWORD

# Check if there are existing cron jobs and remove them
if crontab -l >/dev/null 2>&1; then
  crontab -r
fi

# Convert from the UTC variable to the cron format
if [ $UTC -gt 0 ]; then
  HOUR=$(($HOUR - $UTC))
elif [ $UTC -lt 0 ]; then
  HOUR=$(($HOUR + ${UTC#-}))
fi
HOUR=$((HOUR % 24))

# Add the cron job to run the backup script every day at the specified time
(crontab -l 2>/dev/null; echo "0 $HOUR * * * $CREATE_BACKUP_SCRIPT 2>>$ERROR_LOG_FILE") | crontab -

# Add the cron job to run the cleanup script
(crontab -l 2>/dev/null; echo "0 $HOUR * * * bash $BASE_DIR/cleanup-backups.sh $BASE_DIR 2>>$ERROR_LOG_FILE") | crontab -
