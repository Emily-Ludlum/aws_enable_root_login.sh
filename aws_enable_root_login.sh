#!/bin/bash

# 第一步：创建root用户并设置密码
echo "Setting root password..."
echo -e "Abcd@1234\nAbcd@1234" | sudo passwd root

# 第二步：切换到root用户
echo "Switching to root user..."
su - root -c "echo 'Switched to root user.'"

# 第三步：编辑ssh配置文件
echo "Editing sshd_config file..."
sudo vim -c ":%s/#\?PasswordAuthentication\s\+no/PasswordAuthentication yes/g" -c ":wq" /etc/ssh/sshd_config
sudo vim -c ":%s/#\?PermitRootLogin\s\+prohibit-password/PermitRootLogin yes/g" -c ":wq" /etc/ssh/sshd_config
sudo vim -c ":%s/UsePAM yes/UsePAM no/g" -c ":wq" /etc/ssh/sshd_config

# 第四步：编辑authorized_keys文件
echo "Editing authorized_keys file..."
sudo vim -c 'g/ssh-rsa/normal! k$d' -c 'wq' /root/.ssh/authorized_keys

echo "All steps completed."
