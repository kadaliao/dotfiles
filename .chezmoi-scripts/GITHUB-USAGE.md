# 🚀 从 GitHub 使用 chezmoi 脚本

现在你的所有 GPG 密钥管理脚本和文档都在你的 dotfiles 仓库中了！

## 📍 在新机器上使用

### 快速开始（5分钟）

1. **克隆你的 dotfiles 仓库**
```bash
chezmoi init https://github.com/kadaliao/dotfiles.git
```

2. **进入 .chezmoi-scripts 目录**
```bash
cd ~/.local/share/chezmoi/.chezmoi-scripts
```

3. **查看文档**
```bash
# 快速开始指南
cat QUICK-START.md

# 完整设置说明
cat SETUP-INSTRUCTIONS.md
```

4. **导入 GPG 密钥**
```bash
# 需要先获取你的密钥文件（liaoxingyi-secret-key.asc）
bash import-on-new-machine.sh /path/to/liaoxingyi-secret-key.asc
```

## 📂 脚本说明

### `export-gpg-key.sh`
在当前机器上导出 GPG 私钥和公钥。
```bash
bash export-gpg-key.sh
```
会生成：
- `liaoxingyi-secret-key.asc` - 你的私钥（保管好！）
- `liaoxingyi-public-key.asc` - 你的公钥

### `import-on-new-machine.sh`
在新机器上导入密钥并自动配置 chezmoi。
```bash
bash import-on-new-machine.sh /path/to/liaoxingyi-secret-key.asc
```
会自动：
1. 导入 GPG 密钥
2. 信任密钥
3. 创建 chezmoi 配置
4. 提示你下一步操作

## 📖 文档目录

| 文件 | 用途 | 最佳阅读时机 |
|------|------|------------|
| `00-START-HERE.txt` | 快速导航 | 第一次使用 |
| `QUICK-START.md` | 5分钟快速指南 | 急着使用时 |
| `SETUP-INSTRUCTIONS.md` | 完整的设置说明 | 了解全流程 |
| `README.md` | 详细参考和故障排查 | 遇到问题时 |
| `FILES-MANIFEST.txt` | 文件清单说明 | 需要了解文件结构 |
| `GITHUB-USAGE.md` | 这个文件 | 从 GitHub 克隆后 |

## 🔒 安全提示

⚠️ **重要**：
- 本仓库中的脚本和文档是**公开的**
- 你的 **GPG 密钥文件（.asc）永远不会被上传**（受 .gitignore 保护）
- `.ssh/config` 已被 GPG 加密存储
- 即使仓库是公开的，加密的配置文件内容也是无法读取的

## 🚀 工作流

### 在主机器上

```bash
# 修改配置
nano ~/.config/fish/config.fish

# 添加到 chezmoi
chezmoi add ~/.config/fish/config.fish

# 提交到 git
cd ~/.local/share/chezmoi
git add .
git commit -m "update: fish config"
git push
```

### 在新机器上

```bash
# 克隆仓库
chezmoi init https://github.com/kadaliao/dotfiles.git

# 更新配置
chezmoi update

# 应用
chezmoi apply
```

## ❓ 常见问题

**Q: 脚本在哪里？**
A: 在克隆后：`~/.local/share/chezmoi/.chezmoi-scripts/`

**Q: 如何在新机器上快速查看文档？**
A: 克隆后立即查看：
```bash
cat ~/.local/share/chezmoi/.chezmoi-scripts/QUICK-START.md
```

**Q: 密钥文件会不会被上传？**
A: 不会。`.gitignore` 文件防止了所有 `*.asc` 和 `*.gpg` 文件上传。

**Q: 我可以修改这些脚本吗？**
A: 可以。它们就在仓库中，提交你的改进。

## 📚 下一步

1. 从当前机器导出 GPG 密钥：
   ```bash
   bash ~/.local/share/chezmoi/.chezmoi-scripts/export-gpg-key.sh
   ```

2. 备份密钥到安全位置（U 盘、移动硬盘）

3. 在新机器上克隆并使用：
   ```bash
   chezmoi init https://github.com/kadaliao/dotfiles.git
   cd ~/.local/share/chezmoi/.chezmoi-scripts
   bash import-on-new-machine.sh /path/to/liaoxingyi-secret-key.asc
   ```

---

祝你使用愉快！🎉
