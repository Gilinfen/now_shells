#!/bin/bash

# 更新系统
echo "更新系统..."
sudo dnf -y update

# 安装依赖
echo "安装必需的依赖包..."
sudo dnf install -y yum-utils device-mapper-persistent-data lvm2

# 添加 Docker 仓库
echo "添加 Docker 仓库..."
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# 安装 Docker
echo "安装 Docker..."
sudo dnf install -y docker-ce docker-ce-cli containerd.io

# 启动 Docker 服务
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
DOCKER_COMPOSE_VERSION="1.29.2" # 请根据需要修改为最新版本
sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# 赋予 Docker Compose 执行权限
echo "赋予 Docker Compose 执行权限..."
sudo chmod +x /usr/local/bin/docker-compose

# 验证 Docker Compose 安装
echo "验证 Docker Compose 安装..."
docker-compose --version

echo "安装完成！请退出并重新登录以使更改生效，或者运行 'newgrp docker' 以立即生效。"
