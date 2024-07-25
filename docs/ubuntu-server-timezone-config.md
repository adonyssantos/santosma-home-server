# How to set up the timezone on Ubuntu Server

To set up the timezone on Ubuntu Server, you can use the `timedatectl` command. This command allows you to set the system's timezone and synchronize the system clock with the network time server.

Here are the steps to set up the timezone on Ubuntu Server:

1. List the available timezones by running the following command:

    ```bash
    timedatectl list-timezones
    ```

2. Find the timezone that you want to set and note the name.

3. Set the timezone by running the following command, replacing `Your/Timezone` with the timezone that you want to set:

    ```bash
    sudo timedatectl set-timezone Your/Timezone
    ```

4. Verify that the timezone has been set by running the following command:

    ```bash
    timedatectl
    ```
