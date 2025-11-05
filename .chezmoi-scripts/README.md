# 🔐 GPG 密钥转移和 chezmoi 跨机器使用指南

## 📋 你的 GPG 密钥信息

```
密钥 ID: 4B07A70A11BE697792BE71EB7249BD4EFC2850F4
密钥类型: RSA 3072-bit
用户: liaoxingyi
创建日期: 2024-06-18
```

## ⚠️ 重要提示

**这个文件夹包含你的 GPG 私钥！**
- 🔒 只在安全的环境中保存
- 🚫 不要上传到互联网
- 💾 建议备份到加密的移动设备或保险库
- 🔑 记住你的 GPG 密钥密码（如果有的话）

---

## 🔄 在新机器上使用的步骤

### 第 1 步：准备新机器

在目标机器上安装必要工具：

```bash
# macOS
brew install gnupg chezmoi

# Ubuntu/Debian
sudo apt install gnupg chezmoi

# CentOS/RHEL
sudo yum install gnupg chezmoi
```

### 第 2 步：导入 GPG 密钥

将 `liaoxingyi-secret-key.gpg` 复制到新机器（**安全方式**）：

```bash
# 选项 A：使用 scp（SSH）- 推荐用于远程服务器
scp liaoxingyi-secret-key.gpg user@newmachine:~/

# 选项 B：使用 U盘 或其他物理介质 - 最安全

# 选项 C：暂时通过加密通道（仅作临时传输）
# 例如使用 gpg 本身再加密一层、或通过加密邮件
```

在新机器上导入密钥：

```bash
# 导入私钥
gpg --import ~/liaoxingyi-secret-key.gpg

# 信任你的密钥（非常重要！）
gpg --edit-key 4B07A70A11BE697792BE71EB7249BD4EFC2850F4
# 在 GPG 提示符下输入:
# trust
# 选择 5 (I trust ultimately)
# quit

# 验证导入成功
gpg --list-secret-keys 4B07A70A11BE697792BE71EB7249BD4EFC2850F4
```

### 第 3 步：配置 chezmoi

在新机器上配置 chezmoi 使用相同的 GPG 密钥：

```bash
# 创建 chezmoi 配置目录
mkdir -p ~/.config/chezmoi

# 创建配置文件
cat > ~/.config/chezmoi/chezmoi.toml << 'EOF'
encryption = "gpg"

[gpg]
recipient = "4B07A70A11BE697792BE71EB7249BD4EFC2850F4"
EOF
```

### 第 4 步：克隆或更新 chezmoi 仓库

```bash
# 如果你的 chezmoi 仓库在 GitHub 上
chezmoi init https://github.com/yourusername/dotfiles.git

# 或者如果已经初始化
chezmoi update

# 查看会应用的更改
chezmoi diff

# 应用到系统
chezmoi apply
```

### 第 5 步：验证 SSH 配置已正确应用

```bash
# 检查文件是否存在且权限正确
ls -la ~/.ssh/config

# 测试 SSH 连接
ssh -v hithlan1  # 使用你的某个 host 别名测试
```

---

## 🛡️ 安全最佳实践

### 导出密钥后
```bash
# ✅ 做这些：
1. 备份到离线存储（U 盘、移动硬盘）
2. 使用单独的加密容器存储
3. 定期验证备份的完整性
4. 记录备份位置

# ❌ 不要做这些：
1. 不要把密钥放在云存储（Google Drive, OneDrive）
2. 不要通过不安全的邮件发送
3. 不要在公共 Wi-Fi 上传输
4. 不要保留多个不加保护的副本
```

### 清理临时文件
```bash
# 用完后立即删除临时密钥文件
shred -vfz liaoxingyi-secret-key.gpg  # macOS/Linux

# 或者简单删除
rm ~/liaoxingyi-secret-key.gpg
```

---

## 🔍 故障排查

### 问题：导入后 chezmoi 无法解密文件

```bash
# 检查密钥是否正确导入
gpg --list-secret-keys

# 检查密钥信任度
gpg --edit-key 4B07A70A11BE697792BE71EB7249BD4EFC2850F4
# 查看 trust 值，应该是 ultimate

# 测试解密
gpg --decrypt ~/.local/share/chezmoi/private_dot_ssh/encrypted_private_config.asc
```

### 问题：GPG 询问密码太频繁

```bash
# 配置 GPG agent 来缓存密码
cat >> ~/.gnupg/gpg-agent.conf << 'EOF'
default-cache-ttl 3600
max-cache-ttl 7200
EOF

# 重启 GPG agent
gpg-connect-agent reloadagent /bye
```

### 问题：在 macOS 上 GPG 无法工作

```bash
# 安装 pinentry（让 GPG 能弹出密码对话框）
brew install pinentry-mac

# 配置 GPG 使用它
echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf
gpg-connect-agent reloadagent /bye
```

---

## 📚 常用命令速查

```bash
# 查看所有密钥
gpg --list-keys                    # 公钥
gpg --list-secret-keys             # 私钥

# 导出密钥
gpg --export-secret-keys KEY_ID > backup.gpg
gpg --export KEY_ID > public.gpg

# 导入密钥
gpg --import backup.gpg

# 测试加密/解密
echo "test" | gpg --encrypt --recipient KEY_ID | gpg --decrypt

# chezmoi 命令
chezmoi status                     # 查看状态
chezmoi diff                       # 查看差异
chezmoi apply                      # 应用更改
chezmoi update                     # 从源更新
```

---

## 💡 建议的工作流

### 在主机器（当前机器）上：
```bash
# 定期更新配置
# 修改 ~/.config/fish/config.fish 等
# 然后：
chezmoi add ~/.config/fish/config.fish
cd ~/.local/share/chezmoi
git add .
git commit -m "update fish config"
git push
```

### 在新机器上：
```bash
# 定期拉取最新配置
chezmoi update
chezmoi diff          # 查看会应用什么
chezmoi apply        # 应用更改
```

---

## 🆘 需要帮助？

如果遇到问题，检查：
1. GPG 密钥是否正确导入：`gpg --list-secret-keys`
2. chezmoi 配置是否正确：`cat ~/.config/chezmoi/chezmoi.toml`
3. chezmoi 源目录是否可访问：`ls -la ~/.local/share/chezmoi`
4. 仓库是否克隆正确：`git -C ~/.local/share/chezmoi status`
