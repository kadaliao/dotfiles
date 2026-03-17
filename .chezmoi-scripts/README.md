# 🔐 chezmoi + GPG 跨机器配置管理

用 GPG 加密敏感配置，安全地在多台机器间同步 dotfiles。

## ⚡ 5 分钟快速开始

### 第一台机器：导出密钥

```bash
bash export-gpg-key.sh /path/to/backup-dir
```

得到 `liaoxingyi-secret-key.asc` 后，**立即备份到离线介质（U 盘、移动硬盘）**。

### 新机器：导入并同步

```bash
# 1. 安装工具
brew install gnupg chezmoi git

# 2. 克隆 dotfiles
chezmoi init https://github.com/kadaliao/dotfiles.git

# 3. 进入脚本目录并运行导入脚本
cd "$(chezmoi source-path)/.chezmoi-scripts"
bash ./import-on-new-machine.sh /path/to/liaoxingyi-secret-key.asc

# 4. 应用配置
chezmoi apply
```

如果你把 `liaoxingyi-secret-key.asc` 放在脚本目录或当前目录，也可以直接：

```bash
bash ./import-on-new-machine.sh
```

## 🔧 脚本

### export-gpg-key.sh
在当前机器导出 GPG 密钥对，支持指定输出目录。

### import-on-new-machine.sh
在新机器导入密钥、写入 chezmoi 配置，并补齐模板依赖的 git 用户数据。

## 🔑 你的 GPG 密钥

```text
ID: 4B07A70A11BE697792BE71EB7249BD4EFC2850F4
类型: RSA 3072-bit
用户: liaoxingyi
```

## ⚠️ 重要事项

1. 导出密钥后立即备份到物理介质，不要放在公开云存储
2. 不要上传 `.asc` / `.gpg` 文件到 GitHub（已受 `.gitignore` 保护）
3. 记住 GPG 密钥密码，否则无法解密配置
4. 如果 `chezmoi apply` 提示目标文件被本地修改，先执行 `chezmoi diff`，确认后再决定是否 `chezmoi apply --force`

## ❓ 遇到问题？

**chezmoi 无法解密文件**

```bash
gpg --list-secret-keys
```

**模板渲染提示缺少 `gitname` / `email`**

重新运行 `import-on-new-machine.sh`，它会自动写入 `~/.config/chezmoi/chezmoi.toml` 的 `[data]` 段。

**macOS 上 GPG 卡住**

```bash
brew install pinentry-mac
echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf
```

---

概括：导出密钥 → 备份到安全介质 → 在新机器导入 → 应用配置。
