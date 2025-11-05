#!/bin/bash
# 导出 GPG 密钥的脚本
# 在交互式终端中运行此脚本

set -e

KEY_ID="4B07A70A11BE697792BE71EB7249BD4EFC2850F4"
BACKUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔐 导出 GPG 密钥"
echo "======================================"
echo "密钥 ID: $KEY_ID"
echo "备份目录: $BACKUP_DIR"
echo ""

# 导出公钥
echo "📤 导出公钥..."
gpg --export --armor $KEY_ID > "$BACKUP_DIR/liaoxingyi-public-key.asc"
echo "✅ 公钥已导出到: $BACKUP_DIR/liaoxingyi-public-key.asc"

# 导出私钥
echo ""
echo "🔒 导出私钥 (需要输入密钥密码)..."
echo "   密码提示可能会弹出 macOS 系统对话框"
echo ""

# 确保 GPG_TTY 设置正确
export GPG_TTY=$(tty)

# 清理 gpg-agent 缓存，确保会提示密码
echo "正在清理 GPG agent 缓存..."
gpgconf --kill gpg-agent
sleep 1

# 导出私钥（不重定向 stderr，让密码提示正常显示）
if gpg --export-secret-keys --armor $KEY_ID > "$BACKUP_DIR/liaoxingyi-secret-key.asc"; then
    echo ""
    echo "✅ 私钥导出成功"
else
    echo ""
    echo "❌ 导出失败。可能的原因："
    echo "   1. 密码输入错误或取消了输入"
    echo "   2. pinentry 程序未正确配置"
    echo ""
    echo "📝 手动导出方法："
    echo "   gpg --export-secret-keys --armor $KEY_ID > ~/liaoxingyi-secret-key.asc"
    echo ""
    exit 1
fi

echo "✅ 私钥已导出到: $BACKUP_DIR/liaoxingyi-secret-key.asc"

# 验证
echo ""
echo "📋 验证导出的密钥..."
echo ""
echo "公钥信息:"
gpg --armor --export $KEY_ID | gpg --import-options show-only --import
echo ""
echo "私钥已成功导出（为了安全，不显示内容）"
echo ""

# 显示文件大小和哈希
echo "📊 文件信息:"
echo "  公钥文件: $(ls -lh "$BACKUP_DIR/liaoxingyi-public-key.asc" | awk '{print $5}')"
echo "  私钥文件: $(ls -lh "$BACKUP_DIR/liaoxingyi-secret-key.asc" | awk '{print $5}')"
echo ""

# 计算 SHA256 校验和
echo "🔍 SHA256 校验和（用于验证完整性）:"
shasum -a 256 "$BACKUP_DIR/liaoxingyi-secret-key.asc" | awk '{print "私钥:", $1}'
shasum -a 256 "$BACKUP_DIR/liaoxingyi-public-key.asc" | awk '{print "公钥:", $1}'
echo ""

echo "⚠️  重要提示:"
echo "  1. 妥善保管这些文件，特别是 liaoxingyi-secret-key.asc"
echo "  2. 复制到安全的位置（U 盘、移动硬盘）"
echo "  3. 不要上传到云存储或不安全的地方"
echo "  4. 使用完后考虑用 shred 安全删除临时文件"
echo ""
echo "✅ 导出完成！"
