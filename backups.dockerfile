FROM ubuntu:24.04

# Install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    wget \
    gnupg \
    cron

# Install MEGA cmd
RUN wget https://mega.nz/linux/repo/xUbuntu_24.04/amd64/megacmd-xUbuntu_24.04_amd64.deb && \
    apt install "$PWD/megacmd-xUbuntu_24.04_amd64.deb" -y

# Login with mega-cmd
ARG MEGA_SESSION
RUN mega-login $MEGA_SESSION

# Copy scripts and other necessary files
COPY ./scripts /scripts
COPY ./volumes /volumes
COPY ./backups-encryption.key /backups-encryption.key

# Add execution permissions to the scripts
RUN chmod -R +x /scripts

# Add cron jobs
RUN echo "0 3 * * * /scripts/create-backup.sh /scripts/" >> /cronjobs
RUN echo "0 2 * * * /scripts/clean-backups.sh /scripts/" >> /cronjobs
RUN crontab /cronjobs

# Start cron
CMD ["cron", "-f", "-L", "/dev/stdout"]
