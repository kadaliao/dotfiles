# 🔐 chezmoi + GPG 跨机器配置管理

用 GPG 加密敏感配置，安全地在多台机器间同步 dotfiles。

## ⚡ 5 分钟快速开始

### 第一台机器：导出密钥

```bash
bash export-gpg-key.sh
```

得到 `liaoxingyi-secret-key.asc`，**立即备份到离线介质（U 盘、移动硬盘）**

### 新机器：导入并同步

```bash
# 1. 安装工具
brew install gnupg chezmoi

# 2. 克隆 dotfiles
chezmoi init https://github.com/kadaliao/dotfiles.git

# 3. 导入密钥（自动配置 chezmoi）
# 密钥文件可以来自任何地方（U 盘、下载文件夹、~/Documents 等）
bash ~/.local/share/chezmoi/.chezmoi-scripts/import-on-new-machine.sh \
  /path/to/your/liaoxingyi-secret-key.asc

# 例子：
# bash ~/.local/share/chezmoi/.chezmoi-scripts/import-on-new-machine.sh ~/Downloads/liaoxingyi-secret-key.asc
# bash ~/.local/share/chezmoi/.chezmoi-scripts/import-on-new-machine.sh /Volumes/USB_DRIVE/liaoxingyi-secret-key.asc

# 4. 应用配置
chezmoi apply

完成！✨
```

## 🔧 脚本

### export-gpg-key.sh
在当前机器导出 GPG 密钥对。**运行一次**，然后妥善保管密钥文件。

### import-on-new-machine.sh
在新机器导入密钥并自动配置 chezmoi。

## 🔑 你的 GPG 密钥

```
ID: 4B07A70A11BE697792BE71EB7249BD4EFC2850F4
类型: RSA 3072-bit
用户: liaoxingyi
```

## 📚 常用命令

```bash
# 主机器：修改并保存配置
nano ~/.config/fish/config.fish
chezmoi add ~/.config/fish/config.fish
cd ~/.local/share/chezmoi && git add . && git commit -m "..." && git push

# 其他机器：同步最新配置
chezmoi update
chezmoi apply
```

## 🛡️ 安全

- ✅ GPG 密钥文件受 `.gitignore` 保护，永不上传到 GitHub
- ✅ SSH 配置使用 GPG RSA-3072 加密存储
- ✅ chezmoi 自动解密加密文件
- ✅ 即使仓库公开，加密内容也无法读取

## ⚠️ 重要事项

1. **导出密钥后立即备份**到物理介质，不要放在云存储
2. **不要上传 .asc/.gpg 文件**到 GitHub（受 .gitignore 保护）
3. **记住 GPG 密钥密码**，否则无法解密配置
4. **在新机器上导入相同的密钥**即可多机器同步

## ❓ 遇到问题？

**chezmoi 无法解密文件**
```bash
gpg --list-secret-keys  # 检查密钥是否导入
```

**macOS 上 GPG 卡住**
```bash
brew install pinentry-mac
echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf
```

**其他问题** → 查看脚本中的详细注释或 GPG/chezmoi 官方文档

---

**概括**：导出密钥 → 备份到 U 盘 → 在新机器导入 → 应用配置。就这么简单！
