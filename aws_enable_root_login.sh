#!/bin/bash

# 1. 创建root用户及设置密码
echo "Setting password for root user..."
echo "root:Abcd@1234" | chpasswd

# 2. 切换到root用户
echo "Switching to root user..."
su - root -c "echo 'Switched to root user'"

# 3. 修改SSH配置文件
echo "Editing SSH configuration..."
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/^PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/^UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# 4. 编辑authorized_keys文件
echo "Editing authorized_keys file..."
sed -i 's/ssh-rsa .*$/ssh-rsa/g' /root/.ssh/authorized_keys

# 5. 重启 SSH 服务
echo "Restarting SSH service..."
if [ -x "$(command -v systemctl)" ]; then
    systemctl restart sshd
elif [ -x "$(command -v service)" ]; then
    service ssh restart
else
    echo "Unable to restart SSH service. Please restart it manually."
fi

echo "SSH service restarted."


echo "Script execution completed."
