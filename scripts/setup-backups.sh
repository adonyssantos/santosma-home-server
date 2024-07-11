# This script setup a cron job to run the backup script every day
# at a specific time. The time is specified in the UTC variable.
# @arg1: Mega.nz email
# @arg2: Mega.nz password
UTC=-4 # America/Santo_Domingo
HOUR=2 # 2 AM on America/Santo_Domingo
MEGA_EMAIL=$1
MEGA_PASSWORD=$2

# Convert from the UTC variable to the cron format
if [ $UTC -gt 0 ]; then
  HOUR=$(($HOUR + $UTC))
elif [ $UTC -lt 0 ]; then
  HOUR=$(($HOUR - $UTC))
fi

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

# Add the cron job to run the backup script
# TODO: Create the cron job

# Add the cron job to run the cleanup script'
# TODO: Create the cron job
