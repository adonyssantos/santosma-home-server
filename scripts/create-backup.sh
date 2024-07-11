# This scripts sets up the backups for all the volumes in the system
# The backups are compress, encrypted and stored in Mega.nz cloud storage

timestamp=$(date +"%Y%m%d%H%M%S")

# Create a temporary directory to store the backup
rm -rf ../.temp
mkdir -p ../.temp/backups/$timestamp
cp -r ../volumes ../.temp/backups/$timestamp

# Compress the backup
tar -czvf ../.temp/backups/$timestamp.tar.gz -C ../.temp/backups/$timestamp volumes

# Encrypt the backup
gpg --output ../backups/$timestamp.tar.gz.gpg --symmetric --cipher-algo AES256 --batch --passphrase-file ../backups-encryption.key ../.temp/backups/$timestamp.tar.gz

# Clean up the temporary directory
rm -rf ../.temp

# TODO: Upload the backup to Mega.nz on Mondays
if [ $(date +%u) -eq 1 ]; then
    # TODO: Upload the backup to Mega.nz
fi