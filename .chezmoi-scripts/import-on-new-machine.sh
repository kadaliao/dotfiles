#!/bin/bash
# 在新机器上导入 GPG 密钥并配置 chezmoi
# 使用方法: bash import-on-new-machine.sh /path/to/liaoxingyi-secret-key.asc

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KEY_FILE="${1:-$SCRIPT_DIR/liaoxingyi-secret-key.asc}"
KEY_ID="4B07A70A11BE697792BE71EB7249BD4EFC2850F4"

echo "🚀 在新机器上导入 GPG 密钥并配置 chezmoi"
echo "=================================================="
echo ""

# 检查文件
if [ ! -f "$KEY_FILE" ]; then
    echo "❌ 错误: 找不到密钥文件: $KEY_FILE"
    echo "用法: bash $0 /path/to/liaoxingyi-secret-key.asc"
    exit 1
fi

# 检查工具
echo "📋 检查必要工具..."
for tool in gpg chezmoi git; do
    if ! command -v $tool &> /dev/null; then
        echo "❌ 未安装 $tool"
        echo "请先安装:"
        echo "  macOS: brew install gnupg chezmoi"
        echo "  Ubuntu: sudo apt install gnupg chezmoi git"
        exit 1
    fi
done
echo "✅ 所有工具已安装"
echo ""

# 导入 GPG 密钥
echo "🔐 导入 GPG 密钥..."
echo "提示: 如果弹出密码对话框，请输入你的 GPG 密钥密码"
echo ""

if gpg --import "$KEY_FILE"; then
    echo "✅ 密钥导入成功"
else
    echo "❌ 导入失败，请检查密钥文件和密码"
    exit 1
fi

echo ""

# 信任密钥
echo "🔑 信任密钥..."
# 使用 --batch 模式和期望的输入来自动化信任过程
# 或者提示用户手动执行
cat << 'EOF'

⚠️  重要: 你需要信任这个密钥以使用加密文件。
执行以下命令:

    gpg --edit-key 4B07A70A11BE697792BE71EB7249BD4EFC2850F4

然后在 GPG 提示符下输入:
    trust
    5
    y
    quit

按 Enter 继续...
EOF
read

gpg --edit-key "$KEY_ID" << 'GPG_COMMANDS'
trust
5
y
quit
GPG_COMMANDS

echo "✅ 密钥已信任"
echo ""

# 验证密钥
echo "📊 验证密钥..."
gpg --list-secret-keys "$KEY_ID" | grep -E "sec|uid" | head -2
echo "✅ 密钥验证成功"
echo ""

# 创建 chezmoi 配置
echo "⚙️  配置 chezmoi..."
mkdir -p ~/.config/chezmoi

cat > ~/.config/chezmoi/chezmoi.toml << EOF
encryption = "gpg"

[gpg]
recipient = "$KEY_ID"
EOF

echo "✅ chezmoi 配置已创建: ~/.config/chezmoi/chezmoi.toml"
echo ""

# 提示用户后续步骤
cat << 'EOF'
🎉 设置完成！

接下来的步骤:

1. 克隆 dotfiles 仓库（如果还没有）:
   chezmoi init https://github.com/yourusername/dotfiles.git

2. 或者如果已经初始化，更新配置:
   chezmoi update

3. 查看会应用的更改:
   chezmoi diff

4. 应用配置到系统:
   chezmoi apply

5. 测试是否成功:
   ls -la ~/.ssh/config
   ssh -v hithlan1

❓ 如果遇到问题，检查:
  gpg --list-secret-keys                    # 验证密钥导入
  cat ~/.config/chezmoi/chezmoi.toml         # 验证配置
  chezmoi status                            # 检查 chezmoi 状态

EOF

echo ""
echo "✅ 设置脚本完成"
