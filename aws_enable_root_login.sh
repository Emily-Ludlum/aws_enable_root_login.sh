#!/bin/bash

# 第一步：创建root用户并设置密码
echo "Creating root user and setting password..."
echo -e "Abcd@1234\nAbcd@1234" | sudo passwd root

# 第二步：切换到root用户
echo "Switching to root user..."
su - root -c "echo 'Switched to root user.'"

# 第三步：编辑ssh配置文件
echo "Editing sshd_config file..."
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# 第四步：编辑authorized_keys文件
echo "Editing authorized_keys file..."
sudo sed -i 's/ssh-rsa.*$/ssh-rsa/g' /root/.ssh/authorized_keys

echo "All steps completed."
