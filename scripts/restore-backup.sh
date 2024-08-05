# This script will restore the backups 
# @arg1: The path to the backup file to restore
backup_file=$1

if [ -d "./scripts" ]; then
  cd scripts
  echo "Moved to scripts directory"
fi

# Create temporary directory
rm -rf ../.temp
mkdir -p ../.temp/restores
cp -r $backup_file ../.temp/restores

# Decrypt the backup
gpg --output ../.temp/backup.tar.gz --decrypt --batch --passphrase-file ../backups-encryption.key $backup_file

# Extract the backup
tar -xzvf ../.temp/backup.tar.gz -C ../.temp/restores

# Get a list of all the volumes to restore
volumes=$(find ../.temp/restores/volumes -maxdepth 1 -type d -not -path "../.temp/restores/volumes")

function restore_specific_volumes() {
  echo "Select the volumes to restore"
  selected_volumes=()
  for volume in $volumes; do
    read -p "Restore $volume? [Y/n]: " restore
    restore=${restore:-y}
    if [ $restore == "y" ]; then
      selected_volumes+=($volume)
    fi
  done

  # Restore the selected volumes
  for volume in ${selected_volumes[@]}; do
      volume_name=$(basename $volume)
      echo "Restoring volume: $volume_name"
      rm -rf ../volumes/$volume_name
      mkdir -p ../volumes/$volume_name
      cp -r $volume ../volumes
  done
}

read -p "Restore all volumes? [y/N]: " restore_all
restore_all=${restore_all:-n}
if [ $restore_all == "y" ]; then
  # Restore the complete backup
  cp -r ../.temp/restores/volumes ../
  exit 0
else
  restore_specific_volumes
fi

# Clean up the temporary directory
rm -rf ../.temp
