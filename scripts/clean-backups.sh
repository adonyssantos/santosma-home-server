# This script will remove the backups older than 30 days in the ../backups directory
# @arg1: The base scripts directory

if [ -d "./scripts" ]; then
  cd scripts
  echo "Moved to scripts directory"
fi

BASE_DIR=${1:-$(pwd)}
current_date=$(date +%s)

cd $BASE_DIR

for backup in ../backups/*.tar.gz.gpg; do
  backup_timestamp=$(basename $backup .tar.gz.gpg)
  backup_date=${backup_timestamp:0:8}
  backup_date_seconds=$(date -d $backup_date +%s)
  difference_in_days=$(( (current_date - backup_date_seconds) / 86400 ))

  # Remove the backup if it is older than 30 days
  if [ $difference_in_days -gt 30 ]; then
    echo "Removing backup $backup"
    rm $backup
  else
    echo "Backup $backup is not older than 30 days"
  fi
done
