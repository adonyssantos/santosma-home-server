# Santosma Home Server

This is the home server of Santosma. It is a server that runs on a Raspberry Pi 4 and is used for various purposes. The server is running on a Raspberry Pi 4 with 4GB of RAM and a 64GB SD card. The server is running on Ubuntu Server.

## Setup

The following steps were taken to set up the server:

- [Install Ubuntu Server on the Raspberry PI](https://ubuntu.com/download/raspberry-pi).
- [Setup a static IP address and SSH access](./docs/ubuntu-server-network-config.md).
- [Configure the machine with Ansible](./setup/README.md).
- [Setup GitHub SSH](./docs/github-ssh-setup.md).
- Clone this repository to the server.
- Create the necessary credentials files. See the [Credentials](#credentials) section for more information.
- Run the `docker-compose up -d` command to start the services.

## Credentials

This system is using the following credentials:

- `backups-encryption.key`: The encryption key for the backups. You can generate a new key using the `openssl rand -base64 256 > backups-encryption.key` command. Make sure to keep this key secure and do not lose it, as it is required to decrypt the backups.
- `.env`: The environment file that contains the environment variables for the services. This file is not included in the repository for security reasons. You can create this file by copying the `.env.example` file and updating the values as needed.

## Scripts

On the `scripts` folder there are some scripts to help with the management of the server. The scripts are:

- `clean-backups.sh`: Clean the backups older than 30 days. This script is used by the backups service to clean old backups.
- `create-backup.sh`: Create a backup of the services volumes, compress, encrypt and upload to Mega. This script is used by the backups service to create recurring backups.
- `restore-backup.sh`: Download, decrypt, decompress and restore the backups.

## Services

The server is running the following services:

| Service                                               | Container Name           | External Ports | Internal Ports |
| ----------------------------------------------------- | ------------------------ | -------------- | -------------- |
| [FreshRSS](#freshrss)                                 | freshrss                 | N/A            | 80             |
| [RSS Bridge](#rss-bridge)                             | rssbridge                | N/A            | 80             |
| [instagram-feed-generator](#instagram-feed-generator) | instagram-feed-generator | N/A            | 80             |
| [rss-nginx](#rss-nginx)                               | freshrss-nginx           | 8000           | 80             |
| [Vaultwarden](#vaultwarden)                           | vaultwarden              | 8100           | 80             |
| [BudgE](#budge)                                       | budge                    | 8200           | 80             |
| [Portainer](#portainer)                               | portainer                | 9000           | 9000           |
| [Uptime Kuma](#uptime-kuma)                           | uptime-kuma              | 9100           | 3001           |
| [Docker Socket Proxy](#docker-socket-proxy)           | dockerproxy              | N/A            | 2375           |
| [Cloudflared](#cloudflared)                           | cloudflared              | N/A            | N/A            |
| [Backups](#backups)                                   | backups                  | N/A            | N/A            |

### FreshRSS

[FreshRSS](https://freshrss.org/) is a free, self-hosted RSS feed reader. It is a great way to keep up with your favorite websites and blogs.

### RSS Bridge

[RSS Bridge](https://github.com/RSS-Bridge/rss-bridge) is a PHP project that allows you to generate RSS feeds for websites that do not have them. It is a great way to keep up with websites that do not offer RSS feeds.

### instagram-feed-generator

[instagram-feed-generator](./projects/instagram-feed-generator/README.md) is my own implementation to generate an RSS feed from an Instagram account. It is a great way to keep up with your favorite Instagram accounts without having to use the Instagram app.

## rss-nginx

An [nginx](https://www.nginx.com/) server that serves all the services related to RSS feeds. It is used to serve the FreshRSS and RSS Bridge services.

This is serving the following services:

- [FreshRSS](#freshrss): `http://rss-nginx:80/`
- [RSS Bridge](#rss-bridge): `http://rss-nginx:80/rss-bridge`
- [instagram-feed-generator](#instagram-feed-generator): `http://rss-nginx:80/instagram-feed-generator`

### Vaultwarden

[Vaultwarden](https://vaultwarden.github.io/docs/) is a free, open-source password manager that is compatible with Bitwarden. It is a great way to store and manage your passwords securely.

### BudgE

[BudgE](https://docs.linuxserver.io/images/docker-budge/) is an open source 'budgeting with envelopes' personal finance app.

### Portainer

[Portainer](https://www.portainer.io/) is a lightweight management UI that allows you to easily manage your Docker environments.

### Uptime Kuma

[Uptime Kuma](https://github.com/louislam/uptime-kuma) is a self-hosted monitoring tool that checks the uptime of your websites and services.

### Docker Socket Proxy

[Docker Socket Proxy](https://github.com/Tecnativa/docker-socket-proxy) is a tool that allows you to securely access the Docker API from a remote machine. It is used by Portainer to access the Docker API on the host machine.

### Cloudflared

[Cloudflared](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/installation) is a tool that allows you to tunnel traffic through Cloudflare's network. Is used to access to the local server from the internet.

### Backups

This service is my own implementation to backup the data from all others services volumes. The backups are encrypted using the `backups-encryption.key` file and uploaded to Mega using the `mega-cmd` tool. Also, this service remove old backups from the local server to save space.
