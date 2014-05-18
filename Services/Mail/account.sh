user1="user1"
echo " [ MAIL ] "
echo " * Creating $user1..."
useradd $user1 -m
passwd $user1

user2="user2"
echo " * Creating $user2..."
useradd $user2 -m
passwd $user2