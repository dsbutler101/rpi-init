# Overview

This repo uses Ansible modules to initialise a Raspberry Pi SD card using either MacOS or Linux. Note this initialises a raw SD card plugged in to a Mac, not an SD card in a running Raspberry Pi. It installs a previously downloaded Raspbian image to the SD card and configures both Wifi credentials and SSH public key, all from MacOS. After the install process is complete, you can then insert the SD card in to your Pi and connect headlessly over Wifi using your SSH keys with no further configuration needed.

This works by overloading the `init=` kernel parameter in cmdline.txt to mount volumes in read-write mode and executing a custom script copied to the `/boot` partition. It gets around the fact that the Raspbian `/` partition is `ext4` which cannot be mounted by MacOS without 3rd party software. The `/boot` partition, however, is FAT32 which is supported natively in MacOS. 

# Prerequisites

- Ansible installed on your local workstation
- A recent Raspbian image downloaded and the full path noted down
- SSH keys installed on your workstation with the public key to hand
- A card reader that allows you to plug the SD card in to your Mac
- This repo cloned to your local workstation `git clone https://github.com/dsbutler101/rpi-init.git`


# Steps

Insert the SD card in to the card reader and plug it in to your Mac. The `/boot` mount point may appear on your desktop if the SD card has been previously formatted with Rasbian. Run the following command from the terminal after cd'ing to the cloned repo directory:

`ansible-playbook init.yml -K`

When prompted enter the following information:

- Workstation admin password (to allow access to block devices)
- Specify the block device for the SD card. Note it is very important to supply the correct device otherwise you could lose data - it should appear as `/dev/diskX (external, physical)` where X is a number. Make sure you are not overwritting an important external drive. Please be super careful - you are doing this AT YOUR OWN RISK!
- Provide the full path to the downloaded Raspbian image
- Wifi SSID
- Wifi password
- SSH public key

# To-do

- Add conditional logic to skip prompt for Wifi SSD and password if `configure_wifi` set to 'no'.
