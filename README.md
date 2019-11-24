# Overview

This ansible module allows you to initialise a raw SD card from a new Raspberry Pi image and perform arbitrary configuration on first boot - for example to automatically configure SSH keys. This is achieved by modifying only files on the FAT32 boot partition on a newly imaged SD card without directly accessing the ext4 Linux root partition. This is particularly useful as it means initialisation can be performed from systems such as MacOS that cannot natively read ext4 filesystems.

The script can be customised to perform other arbitrary initialisation actions as required on first boot. This is particularly useful for automatically configuring a headless RPi systems.

It works by overriding the `init=` kernel parameter in `/boot/cmdline.txt` to mount all volumes in read-write mode and specifies a custom script that is copied to `/boot` and executed on first boot. After the script has run successfully, the script restores the default `/boot/cmdline.txt` configuration and reboots the RPi as normal.


# Prerequisites

- Ansible installed on your local workstation
- A recent Raspbian image downloaded and the full path noted down
- SSH keys installed on your workstation with the public key to hand
- A card reader that allows you to plug the SD card in to your Mac
- This repo cloned to your Mac `git clone https://github.com/dsbutler101/rpi-init.git`


# Steps

Plug the SD card in to your Mac. The `/boot` mount point may appear on your desktop if the SD card has been previously formatted with Rasbian (or is otherwise mountable by MacOS). Run the following command from the terminal after cd'ing to the cloned repo directory:

`ansible-playbook init.yml -K`

Use the `-U <user>` to specify an admin user if the current Mac user is not an admin user.

When prompted enter the following information:

- Workstation admin password (provides access to write the SD block device)
- Block device name for the SD card. Note it is very important to supply the correct device otherwise you may lose data - it should appear as `/dev/diskX (external, physical)` where X is a number. Be very careful you are not overwriting another attached external drive - you are doing this AT YOUR OWN RISK!
- Full path to the downloaded Raspbian image
- Wifi SSID
- Wifi password
- SSH public key
