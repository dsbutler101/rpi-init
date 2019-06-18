#!/bin/sh

# update ssh key and enable wifi
/bin/mkdir /home/pi/.ssh
/bin/chmod 700 /home/pi/.ssh
/bin/echo {{ ssh_key }} > /home/pi/.ssh/authorized_keys
/bin/chmod 600 /home/pi/.ssh/authorized_keys
/bin/chown -R pi:pi /home/pi/.ssh

# disable password login
/bin/sed -i 's/^#* *PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

# clear init kernel parameter and resume normal resize and reboot process
/bin/sed -i 's| init=/bin/sh -c.*||' /boot/cmdline.txt
/usr/lib/raspi-config/init_resize.sh
