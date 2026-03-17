# dotfiles

用 [chezmoi](https://www.chezmoi.io/) 管理的个人配置文件，支持 macOS 和 Linux。

## 包含的配置

- **Neovim** — `dot_config/nvim/`，基于 lazy.nvim 的配置
- **Fish shell** — `dot_config/private_fish/`，包含 functions 和别名
- **Ghostty** — `dot_config/ghostty/`，终端模拟器配置
- **tmux** — `dot_tmux.conf`，使用 TPM 插件管理器，Nord 主题
- **lf** — `dot_config/lf/`，文件管理器，含预览脚本
- **starship** — `dot_config/starship.toml`，shell 提示符
- **Git** — `dot_gitconfig.tmpl`，模板化配置，区分 macOS/Linux
- **Claude Code** — `dot_claude/`，Claude Code 配置和状态栏脚本
- **SSH** — `private_dot_ssh/`，加密存储

## 前置依赖

- [chezmoi](https://www.chezmoi.io/install/)
- [GnuPG](https://gnupg.org/)（用于解密加密文件，如 SSH 配置）

```bash
# macOS
brew install chezmoi gnupg

# Linux
sh -c "$(curl -fsLS get.chezmoi.io)"
apt install gnupg  # 或对应发行版的包管理器
```

## 首次安装

### 1. 导入 GPG 密钥

加密文件（SSH 配置、Claude 设置等）需要 GPG 密钥才能解密：

```bash
# 从备份导入私钥
gpg --import private-key.asc
```

### 2. 初始化并应用配置

```bash
chezmoi init --apply https://github.com/kadaliao/dotfiles
```

或者已经克隆到本地：

```bash
chezmoi init --apply /path/to/dotfiles
```

## 日常使用

```bash
# 查看当前状态（哪些文件有变更）
chezmoi status

# 预览将要应用的变更
chezmoi diff

# 应用所有变更到 home 目录
chezmoi apply

# 编辑某个配置文件
chezmoi edit ~/.config/nvim/init.lua

# 将 home 目录的修改同步回 source
chezmoi add ~/.config/fish/config.fish

# 更新远程变更并应用
chezmoi update
```

## 跨平台差异

`dot_gitconfig.tmpl` 使用模板变量区分系统：

- **macOS**：启用 commit template、git-templates 目录
- **Linux**：跳过上述 macOS 专属配置

模板变量在 `.chezmoi.toml.tmpl` 中定义（`is_macos`、`is_linux`）。

## 加密文件

以下文件使用 GPG 加密（文件名含 `.asc` 后缀）：

- `dot_claude/encrypted_settings.json.asc` — Claude Code 设置
- `private_dot_ssh/` 下的私钥文件

添加新的加密文件：

```bash
chezmoi add --encrypt ~/.ssh/id_ed25519
```
