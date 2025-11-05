# 🛠️ GPG 密钥导出和 chezmoi 跨机器使用完整指南

## 📦 你现在拥有什么

在 `~/gpg-backup/` 目录中，我为你创建了以下文件：

```
~/gpg-backup/
├── README.md                          # 详细的参考文档
├── QUICK-START.md                     # 快速开始指南（5分钟）
├── SETUP-INSTRUCTIONS.md              # 这个文件
├── export-gpg-key.sh                  # 导出密钥的自动化脚本
├── import-on-new-machine.sh           # 在新机器上导入密钥的脚本
├── liaoxingyi-secret-key.gpg          # ❌ 不完整（请使用脚本导出）
└── liaoxingyi-secret-key.asc          # ❌ 空文件（请使用脚本导出）
```

## ⚠️ 重要：你需要手动导出密钥

由于在非交互式环境的限制，我无法直接导出完整的 GPG 密钥。**你需要在交互式终端中手动执行导出。**

### 步骤 1：在你当前的机器上导出密钥

打开终端并运行：

```bash
cd ~/gpg-backup
bash export-gpg-key.sh
```

这个脚本会：
1. 提示你输入 GPG 密钥密码（如果有的话）
2. 导出公钥到 `liaoxingyi-public-key.asc`
3. 导出私钥到 `liaoxingyi-secret-key.asc`
4. 显示 SHA256 校验和（用于验证完整性）

**预期输出示例：**
```
🔐 导出 GPG 密钥
======================================
密钥 ID: 4B07A70A11BE697792BE71EB7249BD4EFC2850F4
备份目录: /Users/liaoxingyi/gpg-backup

📤 导出公钥...
✅ 公钥已导出到: /Users/liaoxingyi/gpg-backup/liaoxingyi-public-key.asc

🔒 导出私钥 (需要输入密钥密码)...
✅ 私钥已导出到: /Users/liaoxingyi/gpg-backup/liaoxingyi-secret-key.asc
```

## 🔐 安全保管密钥文件

导出后，**立即**采取安全措施：

### 选项 A：使用加密的 U 盘（推荐）
```bash
# 复制密钥文件到 U 盘
# 然后在 U 盘上启用加密（BitLocker、FileVault 等）
cp ~/gpg-backup/liaoxingyi-secret-key.asc /Volumes/YOUR_USB_DRIVE/
cp ~/gpg-backup/liaoxingyi-public-key.asc /Volumes/YOUR_USB_DRIVE/
```

### 选项 B：使用加密的云存储（次选）
```bash
# 如果必须使用云存储，先用 GPG 再加密一层
gpg --encrypt --recipient 4B07A70A11BE697792BE71EB7249BD4EFC2850F4 \
    ~/gpg-backup/liaoxingyi-secret-key.asc \
    -o ~/gpg-backup/liaoxingyi-secret-key.asc.gpg

# 然后删除原始文件
rm ~/gpg-backup/liaoxingyi-secret-key.asc

# 现在可以安全地上传 .gpg 文件到云存储
# 要使用时，先下载然后解密
gpg --decrypt liaoxingyi-secret-key.asc.gpg > liaoxingyi-secret-key.asc
```

### 选项 C：安全删除备份文件（清理当前机器）
```bash
# 在备份到安全位置后，从当前机器删除
# macOS/Linux:
shred -vfz ~/gpg-backup/liaoxingyi-secret-key.asc

# 或简单删除（less secure）:
rm ~/gpg-backup/liaoxingyi-secret-key.asc
```

## 🚀 在新机器上导入密钥

### 步骤 1：获取密钥文件

将 `liaoxingyi-secret-key.asc` 从安全位置复制到新机器（使用安全方式，如 U 盘或 scp）。

### 步骤 2：运行导入脚本

```bash
bash import-on-new-machine.sh /path/to/liaoxingyi-secret-key.asc
```

或者手动执行（如果脚本有问题）：

```bash
# 1. 导入密钥
gpg --import ~/liaoxingyi-secret-key.asc

# 2. 信任密钥
gpg --edit-key 4B07A70A11BE697792BE71EB7249BD4EFC2850F4
# 输入: trust, 5, y, quit

# 3. 创建 chezmoi 配置
mkdir -p ~/.config/chezmoi
cat > ~/.config/chezmoi/chezmoi.toml << 'EOF'
encryption = "gpg"

[gpg]
recipient = "4B07A70A11BE697792BE71EB7249BD4EFC2850F4"
EOF

# 4. 初始化 chezmoi
chezmoi init https://github.com/yourusername/dotfiles.git

# 5. 查看将应用的更改
chezmoi diff

# 6. 应用配置
chezmoi apply
```

### 步骤 3：验证成功

```bash
# 检查 SSH 配置是否存在
ls -la ~/.ssh/config

# 检查内容是否正确（应该能看到你的 host 配置）
cat ~/.ssh/config | head -10

# 测试 SSH 连接
ssh -v hithlan1
```

## 🔍 故障排查

### 问题：导出脚本要求密码但我没有设置密码

**解决:** 不需要密码也可以继续。直接按 Enter。

### 问题：导入时说密钥格式错误

```bash
# 检查密钥文件是否损坏
file liaoxingyi-secret-key.asc
# 应该显示: PGP private key block

# 如果显示其他信息，密钥文件可能已损坏，重新从备份复制
```

### 问题：chezmoi apply 仍然要求密码

```bash
# 配置 GPG agent 缓存密码
cat >> ~/.gnupg/gpg-agent.conf << 'EOF'
default-cache-ttl 3600
max-cache-ttl 7200
EOF

# 重启 agent
gpg-connect-agent reloadagent /bye

# 重试 chezmoi apply
chezmoi apply
```

### 问题：在 macOS 上 GPG 卡住或无响应

```bash
# 安装 pinentry 以允许密码输入对话框
brew install pinentry-mac

# 配置 GPG 使用它
echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf

# 重启 agent
gpg-connect-agent reloadagent /bye
```

## 📋 检查清单

### 在当前机器上：
- [ ] 运行 `bash export-gpg-key.sh` 导出密钥
- [ ] 验证生成了 `liaoxingyi-secret-key.asc` 和 `liaoxingyi-public-key.asc`
- [ ] 记录 SHA256 校验和（用于后续验证完整性）
- [ ] 复制到安全位置（U 盘、离线存储）
- [ ] 可选：从当前机器删除密钥文件（使用 `shred`）

### 在新机器上：
- [ ] 从安全位置获取 `liaoxingyi-secret-key.asc`
- [ ] 运行 `bash import-on-new-machine.sh` 或手动导入
- [ ] 验证 `gpg --list-secret-keys` 显示你的密钥
- [ ] 验证 `cat ~/.config/chezmoi/chezmoi.toml` 配置正确
- [ ] 运行 `chezmoi update` 同步配置
- [ ] 验证 `ls -la ~/.ssh/config` 存在并有正确内容
- [ ] 测试 SSH 连接成功

## 💡 最佳实践

### 多台机器设置
```
当前机器 (主)
  ├── GPG 密钥 (私钥)
  ├── chezmoi 源目录
  └── git 仓库推送

新机器 1 (从)
  ├── GPG 密钥 (导入)
  ├── chezmoi 源目录 (克隆)
  └── chezmoi apply

新机器 2 (从)
  ├── GPG 密钥 (导入)
  ├── chezmoi 源目录 (克隆)
  └── chezmoi apply
```

### 日常工作流
```bash
# 在主机器上更新配置
nano ~/.config/fish/config.fish

# 添加到 chezmoi
chezmoi add ~/.config/fish/config.fish

# 提交到 git
cd ~/.local/share/chezmoi
git add .
git commit -m "update: fish config"
git push

# 在任何从机器上
chezmoi update  # 自动拉取、解密、应用
```

## 🆘 需要帮助？

参考文件：
- `README.md` - 详细的参考文档和所有命令
- `QUICK-START.md` - 5 分钟快速指南
- chezmoi 官方文档: https://www.chezmoi.io/
- GPG 官方文档: https://www.gnupg.org/

常见命令：
```bash
gpg --list-secret-keys                    # 列出所有私钥
gpg --list-keys                           # 列出所有公钥
chezmoi status                            # 查看 chezmoi 状态
chezmoi diff                              # 查看差异
chezmoi apply                             # 应用更改
chezmoi update                            # 从源更新
```

---

## ✅ 总结

现在你有了：

1. ✅ **加密的 SSH 配置** - 安全备份在 chezmoi 中
2. ✅ **GPG 密钥管理流程** - 脚本化导入/导出
3. ✅ **跨机器同步方案** - 使用 chezmoi 和 git
4. ✅ **详细的文档** - README、QUICK-START 和故障排查指南

**下一步：**
1. 运行 `bash ~/gpg-backup/export-gpg-key.sh` 导出密钥
2. 复制密钥文件到安全位置
3. 在新机器上使用 `import-on-new-machine.sh` 导入

祝你使用愉快！🎉
