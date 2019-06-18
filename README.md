# Overview
---

This repo uses Ansible modules to initialise a Raspberry Pi SD card using either MacOS or Linux. Note this is for initialising a raw SD card, plugged in to a Mac, not managing Raspberry that is already running. It installs a previously downloaded Raspbian image to an SD card and configures both Wifi credentials and SSH public key. This makes it possible to connect headlessly to your Raspberry Pi over Wifi using SSH keys after the SD card is inserted with no further configuration needed.

The secret sauce that allow this to work on a MacOS is that it uses the 'init' kernel parameter in cmdline.txt to specify a custom script copied to the /boot partition. This is necessary as the main root partition is 'ext4' which cannot be mounted (and therefore read) on MacOS without third party software. The /boot partition is FAT32 which can be mounted natively in MacOS. 

# Prerequisites

- a recent Raspbian image downloaded and the full path noted down
- SSH keys installed on your workstation with the public key to hand
- Ansible installed on your local workstation
- a card reader that allows you to plug the SD card in to your Mac

# Steps

Insert the SD card in to a card reader and plug in to your Mac. The /boot mount point will appear on your desktop if the SD has been previously formatted for your Raspberry Pi. Run the following command from the terminal:

`ansible-playbook init.yml -K`

When prompted enter the following information:

- Workstation admin password (to allow access to block devices)
- Specify the block device for the SD card. Note it is very important to supply the correct device otherwise you could lose data - it should appear as '/dev/diskX (external, physical)' where X is a number. Make sure you are not overwritting an important external drive. Please be super careful - you are doing this AT YOUR OWN RISK!)
- Provide the full path to the downloaded Raspbian image
- Wifi SSID
- Wifi password
- SSH public key

# To-do

- Add conditional logic to not prompt for Wifi SSD and password if not required
