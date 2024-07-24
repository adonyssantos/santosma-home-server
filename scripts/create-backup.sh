# This scripts sets up the backups for all the volumes in the system
# The backups are compress, encrypted and saved in Mega.nz
# @arg1: The base scripts directory

if [ -d "./scripts" ]; then
  cd scripts
  echo "Moved to scripts directory"
fi

mega_forlder_backups=/Archive/SantosmaServer/Backups
BASE_DIR=${1:-$(pwd)}
timestamp=$(date +"%Y%m%d%H%M%S")

cd $BASE_DIR

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

# Upload the backup to Mega.nz
mega-put -c ../backups/$timestamp.tar.gz.gpg $mega_forlder_backups/$timestamp.tar.gz.gpg
