# Santosma Home Server

This is the home server of Santosma. It is a server that runs on a Raspberry Pi 4 and is used for various purposes. The server is running on a Raspberry Pi 4 with 4GB of RAM and a 64GB SD card. The server is running on Ubuntu Server.

## Credentials

This system is using the following credentials:

- `backups-encryption.key`: The encryption key for the backups. You can generate a new key using the `openssl rand -base64 256 > backups-encryption.key` command. Make sure to keep this key secure and do not lose it, as it is required to decrypt the backups.
- `.env`: The environment file that contains the environment variables for the services. This file is not included in the repository for security reasons. You can create this file by copying the `.env.example` file and updating the values as needed.

## Requirements

The following software is required to run the server:

- [Install Ubuntu Server on the Raspberry PI](https://ubuntu.com/download/raspberry-pi)
- [Setup a static IP address and SSH access](./docs/ubuntu-server-network-config.md)
- [Install Docker](https://docs.docker.com/engine/install/)
- [Install Mega CMD](https://mega.io/cmd#download)
- [Install Crontab](https://linuxgenie.net/set-up-use-crontab-ubuntu-linux/)

## Services

The server is running the following services:

| Service                     | Container Name | Ports |
| --------------------------- | -------------- | ----- |
| [FreshRSS](#freshrss)       | freshrss       | 8000  |
| [Vaultwarden](#vaultwarden) | vaultwarden    | 8100  |
| [Cloudflared](#cloudflared) | cloudflared    | N/A   |

### FreshRSS

[FreshRSS](https://freshrss.org/) is a free, self-hosted RSS feed reader. It is a great way to keep up with your favorite websites and blogs.

### Vaultwarden

[Vaultwarden](https://vaultwarden.github.io/docs/) is a free, open-source password manager that is compatible with Bitwarden. It is a great way to store and manage your passwords securely.

### Cloudflared

[Cloudflared](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/installation) is a tool that allows you to tunnel traffic through Cloudflare's network. Is used to access to the local server from the internet.
