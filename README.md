# Overview
---

This repo uses Ansible modules to initialise a Raspberry Pi SD card using either MacOS or Linux. Note this is for initialising a raw SD card, plugged in to a Mac, not managing Raspberry that is already running. It installs a previously downloaded Raspbian image to an SD card and configures both Wifi credentials and SSH public key, all via MacOS. You can insert the SD card in to your Pi and connect headlessly over Wifi using your SSH keys with no further configuration needed.

This works by overloading the `init=` kernel parameter in cmdline.txt to mount volumes in read-write mode and executes a custom script copied to the `/boot` partition. This gets around the fact that the Raspbian root partition is `ext4` which cannot be mounted on MacOS without 3rd party software. The `/boot` partition is FAT32 which can be mounted natively in MacOS. 

# Prerequisites

- a recent Raspbian image downloaded and the full path noted down
- SSH keys installed on your workstation with the public key to hand
- Ansible installed on your local workstation
- a card reader that allows you to plug the SD card in to your Mac

# Steps

Insert the SD card in to a card reader and plug in to your Mac. The `/boot` mount point will appear on your desktop if the SD has been previously formatted for your Raspberry Pi. Run the following command from the terminal:

`ansible-playbook init.yml -K`

When prompted enter the following information:

- Workstation admin password (to allow access to block devices)
- Specify the block device for the SD card. Note it is very important to supply the correct device otherwise you could lose data - it should appear as `/dev/diskX (external, physical)` where X is a number. Make sure you are not overwritting an important external drive. Please be super careful - you are doing this AT YOUR OWN RISK!
- Provide the full path to the downloaded Raspbian image
- Wifi SSID
- Wifi password
- SSH public key

# To-do

- Add conditional logic to not prompt for Wifi SSD and password if not required.
