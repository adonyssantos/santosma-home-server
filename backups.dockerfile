FROM ubuntu:24.04

# Install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    wget \
    gnupg \
    cron

# Install MEGA cmd
# TODO: change mega-cmd to mega-sync or an alternative that takes less time to login
RUN wget https://mega.nz/linux/repo/xUbuntu_24.04/amd64/megacmd-xUbuntu_24.04_amd64.deb && \
    apt install "$PWD/megacmd-xUbuntu_24.04_amd64.deb" -y

# Login with mega-cmd
# TODO: Limit the permissions to only the necessary ones
ARG MEGA_SESSION
RUN mega-login $MEGA_SESSION

# Copy scripts whit the necessary permissions
COPY ./scripts /scripts
RUN chmod -R +x /scripts

# Add cron jobs
RUN echo "0 3 * * * /scripts/clean-backups.sh /scripts/" >> /cronjobs
RUN echo "10 3 * * * /scripts/create-backup.sh /scripts/" >> /cronjobs
RUN crontab /cronjobs

# Start cron
CMD ["cron", "-f", "-L", "/dev/stdout"]
