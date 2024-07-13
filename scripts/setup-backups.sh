# This script setup a cron job to run the backup script every day
# at a specific time. The time is specified in the UTC variable.
# @arg1: Mega.nz email
# @arg2: Mega.nz password
UTC=-4 # America/Santo_Domingo
HOUR=2 # 2 AM on America/Santo_Domingo
MEGA_EMAIL=$1
MEGA_PASSWORD=$2
BASE_DIR="$(pwd)"
CREATE_BACKUP_SCRIPT="bash $BASE_DIR/create-backup.sh $BASE_DIR"
ERROR_LOG_FILE="~$BASE_DIR/../logs/setup-backups.error.log"

if ! command -v megacli >/dev/null 2>&1; then
  echo "Error: megacli command not found. Please make sure MegaCLI is installed."
  # TODO: install MegaCLI if it is not installed
  # wget https://mega.nz/linux/repo/Fedora_40/x86_64/megacmd-Fedora_40.x86_64.rpm && sudo dnf install "$PWD/megacmd-Fedora_40.x86_64.rpm"
  exit 1
fi

# Check if the crontab command is available
if ! command -v crontab >/dev/null 2>&1; then
  echo "Error: crontab command not found. Please make sure cron is installed."
  # TODO: install cron if it is not installed
  # sudo dnf makecache --refresh
  # sudo dnf -y install crontabs
  exit 1
fi

# Login to Mega.nz
# TODO: Login to Mega.nz
# mega-login $MEGA_EMAIL $MEGA_PASSWORD
# or
# mega-cmd; login $MEGA_EMAIL $MEGA_PASSWORD

# Check if the cron job already exists
if crontab -l | grep -q "$CREATE_BACKUP_SCRIPT"; then
  echo "Cron job already exists."
  exit 0
fi

# Convert from the UTC variable to the cron format
if [ $UTC -gt 0 ]; then
  HOUR=$(($HOUR + $UTC))
elif [ $UTC -lt 0 ]; then
  HOUR=$(($HOUR - $UTC))
fi

# Add the cron job to run the backup script every day at the specified time
(crontab -l 2>/dev/null; echo "0 $HOUR * * * $CREATE_BACKUP_SCRIPT 2>>$ERROR_LOG_FILE") | crontab -

# Add the cron job to run the cleanup script
(crontab -l 2>/dev/null; echo "0 $HOUR * * * bash $BASE_DIR/cleanup-backups.sh $BASE_DIR 2>>$ERROR_LOG_FILE") | crontab -
