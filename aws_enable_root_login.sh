#!/bin/bash

# 第一步：创建root用户并设置密码
echo -e "Abcd@1234\nAbcd@1234" | sudo passwd root

# 第二步：切换到root用户
sudo su -

# 第三步：编辑SSH配置文件
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# 第四步：修改authorized_keys文件
sudo sed -i 's/ssh-rsa.*$/ssh-rsa/g' /root/.ssh/authorized_keys

# 重启SSH服务
sudo systemctl restart sshd
