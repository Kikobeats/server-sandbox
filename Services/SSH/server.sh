echo " * Installing SSH server..."
apt-get install -y openssh-server

echo "Creating backup of original config file..."
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup