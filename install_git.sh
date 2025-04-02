#!/bin/bash

# 设置颜色
GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

# 检测当前系统类型
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    OS=$ID
else
    echo -e "${RED}无法检测操作系统，脚本终止。${RESET}"
    exit 1
fi

echo -e "${GREEN}检测到您的操作系统为: $OS${RESET}"

# 安装 Git
install_git() {
    echo -e "${GREEN}开始安装 Git...${RESET}"

    case "$OS" in
        ubuntu|debian)
            sudo apt update && sudo apt install -y git
            ;;
        centos)
            sudo yum install -y git
            ;;
        fedora)
            sudo dnf install -y git
            ;;
        rocky|almalinux)
            sudo dnf install -y git
            ;;
        *)
            echo -e "${RED}暂不支持该系统: $OS${RESET}"
            exit 1
            ;;
    esac

    # 验证 Git 安装
    if command -v git &>/dev/null; then
        echo -e "${GREEN}Git 安装成功! 🎉 版本信息:$(git --version)${RESET}"
    else
        echo -e "${RED}Git 安装失败，请检查错误信息。${RESET}"
        exit 1
    fi
}

# 运行安装
install_git
