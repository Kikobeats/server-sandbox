echo " * Installing SSH client..."
apt-get install -y openssh-client

echo " * Generating Publig SSH Key..."
ssh-keygen -t rsa