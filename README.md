# Overview

Ansible role to intialise an SD card with a Raspberry Pi OS image, configuring ssh and wifi headlessly without the need to connect a screen or keyboard.

After the image has been written to SD card, it automatically configures wifi ssid/password and ssh authorized key ready for first boot.

This makes use of the `custom.toml` config file written to the boot partition which is automatically processed by the standard Raspberry Pi Bookworm first boot script. Note, the `custom.toml` process is not documented so this approach may not work on previous versions of Raspberry Pi OS.

See Raspberry Pi distro [source code](https://github.com/RPi-Distro/raspberrypi-sys-mods/blob/bookworm/usr/lib/raspberrypi-sys-mods/firstboot) for more info.

# Prereqs

- MacOS Sonoma as the client workstation
- Ansible installed on your local workstation
- Downloaded Raspberry Pi image (bookworm or later)
- This repo cloned - eg. `git clone https://github.com/dsbutler101/rpi-init.git`
- Update `default:` parameters in the `vars_prompt:` section in the `site.yml` file to be sensible defaults for your initialisation process

# Install Steps

Plug the SD card into your Mac. `bootfs` may appear on your desktop if the SD card has been previously been formatted with Raspberry Pi OS. Run the following command from the terminal after changing to the directory of the cloned repo:

`ansible-playbook -K site.yml`

You may need to also supply `-U <user>` if your current user is not already an admin. This plus the `-K` switch is needed to write to the SD card as a block device.

When prompted enter the following information:

- Block device name for the SD card eg. `diskX` where X is the number of the of the appropriate drive you wish to overwrite.
- full path to the downloaded Raspberry Pi OS image
- wlan ssid
- wlan password
- your SSH public key

NOTE: It is critical to supply the correct SD card device. You will LOSE DATA if you provide the the wrong drive. Proceed at your own risk!
