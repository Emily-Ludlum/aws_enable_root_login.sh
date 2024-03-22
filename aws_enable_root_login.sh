#!/bin/bash

# 创建root用户并设置密码
echo -e "Abcd@1234\nAbcd@1234" | sudo passwd root

# 切换到root用户
sudo su -

# 编辑SSH配置文件
sudo sed -i 's/#PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# 重启SSH服务
sudo systemctl restart sshd

# 编辑authorized_keys文件
sudo sed -i 's/ssh-rsa.*$/ssh-rsa/g' /root/.ssh/authorized_keys
