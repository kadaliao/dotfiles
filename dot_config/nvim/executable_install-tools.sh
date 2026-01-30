#!/bin/bash

# Neovim LSP 工具安装脚本
# 根据你的需求选择安装

echo "🚀 Neovim LSP 工具安装脚本"
echo "================================"
echo ""

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查命令是否存在
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 安装函数
install_tool() {
    local tool_name=$1
    local check_cmd=$2
    local install_cmd=$3
    local description=$4

    echo -e "${YELLOW}检查 $tool_name...${NC}"
    if command_exists "$check_cmd"; then
        echo -e "${GREEN}✓ $tool_name 已安装${NC}"
    else
        echo -e "${RED}✗ $tool_name 未安装${NC}"
        echo -e "  描述: $description"
        echo -e "  安装命令: ${YELLOW}$install_cmd${NC}"
        read -p "  是否现在安装? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            eval "$install_cmd"
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✓ 安装成功${NC}"
            else
                echo -e "${RED}✗ 安装失败，请手动安装${NC}"
            fi
        fi
    fi
    echo ""
}

echo "📦 核心工具（强烈建议安装）"
echo "--------------------------------"

# Python - ruff
install_tool "ruff" "ruff" \
    "pip install ruff" \
    "Python 代码检查和格式化（超快！）"

# Lua - stylua
install_tool "stylua" "stylua" \
    "brew install stylua" \
    "Lua 代码格式化（编辑 Neovim 配置必备）"

# Web 开发 - Prettier
install_tool "prettier" "prettier" \
    "npm install -g prettier" \
    "JavaScript/TypeScript/CSS/JSON 等格式化"

echo "🔧 可选工具（按需安装）"
echo "--------------------------------"

# JavaScript/TypeScript - ESLint
install_tool "eslint_d" "eslint_d" \
    "npm install -g eslint_d" \
    "JavaScript/TypeScript 快速 linting（daemon 模式）"

# Shell - shfmt
install_tool "shfmt" "shfmt" \
    "brew install shfmt" \
    "Shell 脚本格式化"

# Bash LSP
install_tool "bash-language-server" "bash-language-server" \
    "npm install -g bash-language-server" \
    "Bash 脚本 LSP 支持（自动补全、跳转等）"

# Makefile - checkmake
install_tool "checkmake" "checkmake" \
    "brew install checkmake" \
    "Makefile linting"

echo "================================"
echo -e "${GREEN}✓ 安装检查完成！${NC}"
echo ""
echo "💡 提示："
echo "  - 重启 Neovim 以应用更改"
echo "  - 运行 :Mason 查看已安装的 LSP 服务器"
echo "  - 运行 :checkhealth 检查配置状态"
echo "  - 如果某些工具不需要，忽略警告即可"
echo ""
