# This script will remove the backups older than 30 days in the ../backups directory
# @arg1: The base scripts directory

if [ -d "./scripts" ]; then
  cd scripts
  echo "Moved to scripts directory"
fi

BASE_DIR=${1:-$(pwd)}
current_timestamp=$(date +"%Y%m%d%H%M%S")

cd $BASE_DIR

for backup in ../backups/*.tar.gz.gpg; do
    timestamp=$(basename $backup .tar.gz.gpg)
    
    difference_in_days=$(( (current_timestamp - timestamp) / 86400 ))

    if [ $difference_in_days -gt 30 ]; then
        rm $backup
        echo "Backup $backup removed."
    fi
done
