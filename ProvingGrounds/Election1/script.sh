# Create variable for target VM
TARGET_IP="192.168.227.211"
WORKING_DIR="/home/brian/Documents/ProvingGrounds/Blogger/"

# nmap
nmap $TARGET_IP -sC -sV -O -A -p 22,80 -oN scan.txt
