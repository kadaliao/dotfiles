# ⚡ 快速开始指南

## 🔄 在新机器上 5 分钟内完成设置

### 前置条件
- 你有 `liaoxingyi-secret-key.asc` 文件（GPG 私钥）
- 你知道 GPG 密钥密码

### 步骤 1️⃣ - 安装工具（2 分钟）

**macOS:**
```bash
brew install gnupg chezmoi
```

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install gnupg chezmoi git
```

**CentOS/RHEL:**
```bash
sudo yum install gnupg chezmoi git
```

### 步骤 2️⃣ - 导入 GPG 密钥（1 分钟）

```bash
gpg --import /path/to/liaoxingyi-secret-key.asc
```

系统会要求输入密钥密码。输入后按 Enter。

### 步骤 3️⃣ - 信任密钥（1 分钟）

```bash
gpg --edit-key 4B07A70A11BE697792BE71EB7249BD4EFC2850F4
```

在 GPG 提示符（`gpg>`）下输入：
```
trust
5
y
quit
```

### 步骤 4️⃣ - 配置 chezmoi（1 分钟）

```bash
mkdir -p ~/.config/chezmoi

cat > ~/.config/chezmoi/chezmoi.toml << 'EOF'
encryption = "gpg"

[gpg]
recipient = "4B07A70A11BE697792BE71EB7249BD4EFC2850F4"
EOF
```

### 步骤 5️⃣ - 应用配置（1 分钟）

```bash
# 如果这是第一次
chezmoi init https://github.com/yourusername/dotfiles.git

# 如果已经初始化
chezmoi update

# 查看会应用什么
chezmoi diff

# 应用！
chezmoi apply
```

✅ **完成！** 你的配置现在已经在新机器上了。

---

## 🔍 验证是否成功

```bash
# 检查 SSH 配置
ls -la ~/.ssh/config

# 测试 SSH 连接
ssh -v hithlan1
```

---

## 🆘 问题排查（3 步）

### 问题 1: "key not found" 或无法解密

```bash
# 检查密钥是否导入
gpg --list-secret-keys

# 应该看到:
# sec   rsa3072 2024-06-18 [SC]
#       4B07A70A11BE697792BE71EB7249BD4EFC2850F4
#       uid           [ultimate] liaoxingyi
```

### 问题 2: chezmoi 显示找不到文件

```bash
# 检查 chezmoi 配置
cat ~/.config/chezmoi/chezmoi.toml

# 应该看到:
# encryption = "gpg"
# [gpg]
# recipient = "4B07A70A11BE697792BE71EB7249BD4EFC2850F4"
```

### 问题 3: 在 macOS 上卡住或崩溃

```bash
# 安装 pinentry（让 GPG 能弹出密码对话框）
brew install pinentry-mac

# 配置 GPG
echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf

# 重启 agent
gpg-connect-agent reloadagent /bye
```

---

## 📚 常用命令

```bash
# 查看 chezmoi 状态
chezmoi status

# 查看差异（会解密 SSH 配置）
chezmoi diff

# 同步最新配置
chezmoi update

# 重新应用（覆盖本地更改）
chezmoi apply --force

# 添加新文件到 dotfiles
chezmoi add ~/.config/fish/config.fish
```

---

## 🔐 安全提示

✅ **做这些:**
- 使用加密的 U 盘传输密钥文件
- 在离线环境中处理密钥
- 定期备份密钥到多个位置
- 记住你的 GPG 密钥密码

❌ **不要做这些:**
- 通过邮件发送密钥文件
- 上传密钥到云服务（Google Drive, OneDrive 等）
- 在公共 Wi-Fi 上传输密钥
- 在 GitHub 上提交密钥文件

---

## 💡 提示

**如果经常在多台机器间切换:**

每台机器都需要导入相同的 GPG 密钥，但只需要做一次。之后可以直接运行 `chezmoi update` 来同步配置。

**如果想在团队中分享非敏感配置:**

只分享你的 dotfiles 仓库链接（GitHub 等），他们可以看到代码但无法解密 SSH 配置文件。

