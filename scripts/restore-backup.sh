# This script will restore the backups 
# @arg1: The path to the backup file to restore
backup_file=$1

# Create temporary directory
rm -rf ../.temp
mkdir -p ../.temp/restores
cp -r $backup_file ../.temp/restores

# Decrypt the backup
gpg --output ../.temp/backup.tar.gz --decrypt --batch --passphrase-file ../backups-encryption.key $backup_file

# Extract the backup
tar -xzvf ../.temp/backup.tar.gz -C ../.temp/restores

# Restore the backup
cp -r ../.temp/restores/volumes ../

# Clean up the temporary directory
rm -rf ../.temp
