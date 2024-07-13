# This script will remove the backups older than 30 days in the ../backups directory
current_timestamp=$(date +"%Y%m%d%H%M%S")
BASE_DIR=${1:-$(pwd)}

cd $BASE_DIR

for backup in ../backups/*.tar.gz.gpg; do
    timestamp=$(basename $backup .tar.gz.gpg)
    
    difference_in_days=$(( (current_timestamp - timestamp) / 86400 ))

    if [ $difference_in_days -gt 30 ]; then
        rm $backup
    fi
done
