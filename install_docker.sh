#!/bin/bash

# 更新软件包索引
echo "更新软件包索引..."
sudo apt-get update -y

# 安装必需的依赖包
echo "安装必需的依赖包..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common jq

# 添加 Docker 官方 GPG 密钥
echo "添加 Docker GPG 密钥..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# 添加 Docker 仓库
echo "添加 Docker 仓库..."
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# 更新 APT 包索引
echo "更新 APT 包索引..."
sudo apt-get update -y

# 安装 Docker
echo "安装 Docker..."
sudo apt-get install -y docker-ce

# 启动并启用 Docker 服务
echo "启动 Docker 服务..."
sudo systemctl start docker
sudo systemctl enable docker

# 验证 Docker 安装
echo "验证 Docker 安装..."
docker --version

# 将当前用户添加到 Docker 组
echo "将当前用户添加到 Docker 组..."
sudo usermod -aG docker $USER

# 安装 Docker Compose
echo "安装 Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# 赋予执行权限
echo "赋予 Docker Compose 执行权限..."
sudo chmod +x /usr/local/bin/docker-compose

# 验证 Docker Compose 安装
echo "验证 Docker Compose 安装..."
docker-compose --version

# 提示用户退出并重新登录
echo "安装完成！请退出并重新登录以使更改生效，或者运行 'newgrp docker' 以立即生效。"
