# This script setup a cron job to run the backup script every day
# at a specific time. The time is specified in the UTC variable.
UTC=-4 # America/Santo_Domingo
HOUR=2 # 2 AM on America/Santo_Domingo

# Convert from the UTC variable to the cron format
if [ $UTC -gt 0 ]; then
  HOUR=$(($HOUR + $UTC))
elif [ $UTC -lt 0 ]; then
  HOUR=$(($HOUR - $UTC))
fi

# Check if the crontab command is available
if ! command -v crontab >/dev/null 2>&1; then
  echo "Error: crontab command not found. Please make sure cron is installed."
  # sudo dnf makecache --refresh
  # sudo dnf -y install crontabs
  exit 1
fi

# Add the cron job to run the backup script
# TODO: Create the cron job
