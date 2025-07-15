# Neovim 配置说明文档

## 📋 目录
1. [配置概览](#配置概览)
2. [架构说明](#架构说明)
3. [自定义键位映射](#自定义键位映射)
4. [插件管理](#插件管理)
5. [安装与更新](#安装与更新)
6. [维护指南](#维护指南)
7. [故障排除](#故障排除)

---

## 📖 配置概览

这是一个基于 Lua 的现代化 Neovim 配置，使用 lazy.nvim 作为插件管理器。配置包含了完整的 LSP 支持、语法高亮、文件浏览、模糊查找、Git 集成等功能。

### 主要特性
- 🚀 **现代化架构**: 基于 Lua 的模块化配置
- 📦 **插件管理**: 使用 lazy.nvim 进行懒加载
- 🎨 **主题**: Nord 主题，支持透明背景切换
- 🧠 **智能补全**: 基于 LSP 的代码补全
- 🔍 **模糊查找**: Telescope 集成
- 📁 **文件浏览**: Neo-tree 文件管理器
- 🔄 **Git 集成**: fugitive + gitsigns
- 🌈 **语法高亮**: Treesitter 支持
- 🎯 **LeetCode**: 内置 LeetCode 支持
- 📸 **图片预览**: 内置图片预览功能

### 核心组件
- **Leader 键**: 空格键 (` `)
- **包管理**: lazy.nvim
- **LSP**: nvim-lspconfig + mason.nvim
- **补全**: nvim-cmp
- **语法高亮**: nvim-treesitter
- **文件查找**: telescope.nvim
- **文件浏览**: neo-tree.nvim
- **状态栏**: lualine.nvim
- **代码格式化**: none-ls.nvim

---

## 🏗️ 架构说明

### 目录结构
```
~/.config/nvim/
├── init.lua                 # 主配置文件
├── lazy-lock.json          # 插件版本锁定
├── lua/
│   ├── core/               # 核心配置
│   │   ├── options.lua     # 编辑器选项
│   │   ├── keymaps.lua     # 键位映射
│   │   └── snippets.lua    # 代码片段和UI定制
│   └── plugins/            # 插件配置
│       ├── lsp.lua         # LSP 配置
│       ├── none-ls.lua     # 格式化和linting
│       ├── telescope.lua   # 模糊查找
│       ├── neotree.lua     # 文件浏览器
│       ├── colortheme.lua  # 主题配置
│       └── ...             # 其他插件
└── README.md               # 本说明文档
```

### 加载顺序
1. `init.lua` - 主入口点
2. `lua/core/options.lua` - 编辑器基础设置
3. `lua/core/keymaps.lua` - 键位映射
4. `lua/core/snippets.lua` - 代码片段和UI定制
5. 自动安装并加载 lazy.nvim
6. 按需加载各插件配置

---

## ⌨️ 自定义键位映射

### 基础操作
| 键位 | 模式 | 功能 | 
|-----|-----|-----|
| `<Space>` | Leader | 主要 Leader 键 |
| `<C-s>` | Normal | 保存文件 |
| `<leader>sn` | Normal | 保存文件（无格式化） |
| `<C-q>` | Normal | 退出 |
| `jk` / `kj` | Insert | 退出到 Normal 模式 |

### 导航增强
| 键位 | 模式 | 功能 |
|-----|-----|-----|
| `<C-d>` | Normal | 向下翻页并居中 |
| `<C-u>` | Normal | 向上翻页并居中 |
| `n` | Normal | 下一个搜索结果并居中 |
| `N` | Normal | 上一个搜索结果并居中 |

### 窗口管理
| 键位 | 模式 | 功能 |
|-----|-----|-----|
| `<leader>v` | Normal | 垂直分割窗口 |
| `<leader>h` | Normal | 水平分割窗口 |
| `<leader>se` | Normal | 平衡窗口大小 |
| `<leader>xs` | Normal | 关闭当前窗口 |
| `<C-h/j/k/l>` | Normal | 窗口间导航 |
| `<Up/Down/Left/Right>` | Normal | 调整窗口大小 |

### 缓冲区操作
| 键位 | 模式 | 功能 |
|-----|-----|-----|
| `<Tab>` | Normal | 下一个缓冲区 |
| `<S-Tab>` | Normal | 上一个缓冲区 |
| `<leader>x` | Normal | 关闭当前缓冲区 |
| `<leader>b` | Normal | 新建缓冲区 |

### 标签页管理
| 键位 | 模式 | 功能 |
|-----|-----|-----|
| `<leader>to` | Normal | 新建标签页 |
| `<leader>tx` | Normal | 关闭当前标签页 |
| `<leader>tn` | Normal | 下一个标签页 |
| `<leader>tp` | Normal | 上一个标签页 |

### 编辑增强
| 键位 | 模式 | 功能 |
|-----|-----|-----|
| `<leader>lw` | Normal | 切换行换行 |
| `<` / `>` | Visual | 缩进并保持选择 |
| `p` | Visual | 粘贴不覆盖寄存器 |
| `vae` | Normal | 选择整个文档 |
| `dae` | Normal | 删除整个文档 |
| `cae` | Normal | 清空文档并进入插入模式 |

### 系统剪贴板
| 键位 | 模式 | 功能 |
|-----|-----|-----|
| `<leader>y` | Normal/Visual | 复制到系统剪贴板 |
| `<leader>Y` | Normal | 复制行到系统剪贴板 |
| `<leader>p` | Normal/Visual | 从系统剪贴板粘贴 |
| `<leader>P` | Normal | 在光标前粘贴 |
| `<leader>d` | Normal/Visual | 剪切到系统剪贴板 |
| `<leader>D` | Normal | 剪切到行尾 |

### 诊断导航
| 键位 | 模式 | 功能 |
|-----|-----|-----|
| `[d` | Normal | 上一个诊断 |
| `]d` | Normal | 下一个诊断 |
| `<leader>d` | Normal | 打开诊断浮窗 |
| `<leader>q` | Normal | 打开诊断列表 |

### Emacs 风格编辑
| 键位 | 模式 | 功能 |
|-----|-----|-----|
| `<C-k>` | Insert | 删除光标到行尾 |
| `<C-u>` | Insert | 删除光标到行首 |
| `<C-k>` | Command | 删除光标到行尾 |
| `<C-u>` | Command | 删除光标到行首 |

### 插件专用键位

#### Telescope (模糊查找)
| 键位 | 功能 |
|-----|-----|
| `<leader>sh` | 搜索帮助 |
| `<leader>sk` | 搜索键位映射 |
| `<leader>sf` | 搜索文件 |
| `<leader>ss` | 搜索 Telescope 命令 |
| `<leader>sw` | 搜索当前单词 |
| `<leader>sg` | 实时搜索 |
| `<leader>sd` | 搜索诊断 |
| `<leader>sr` | 恢复上次搜索 |
| `<leader>s.` | 搜索最近文件 |
| `<leader><leader>` | 搜索缓冲区 |
| `<leader>/` | 在当前缓冲区搜索 |
| `<leader>s/` | 在打开的文件中搜索 |

#### Neo-tree (文件浏览)
| 键位 | 功能 |
|-----|-----|
| `<leader>e` | 切换文件浏览器 |
| `<leader>ngs` | 打开 Git 状态窗口 |

#### 注释
| 键位 | 模式 | 功能 |
|-----|-----|-----|
| `<C-_>` / `<C-c>` / `<C-/>` | Normal | 切换行注释 |
| `<C-_>` / `<C-c>` / `<C-/>` | Visual | 切换块注释 |

#### 主题
| 键位 | 功能 |
|-----|-----|
| `<leader>bg` | 切换背景透明度 |

#### LSP 相关 (当 LSP 附加时)
| 键位 | 功能 |
|-----|-----|
| `gd` | 跳转到定义 |
| `gr` | 查找引用 |
| `gI` | 跳转到实现 |
| `<leader>D` | 类型定义 |
| `<leader>ds` | 文档符号 |
| `<leader>ws` | 工作区符号 |
| `<leader>rn` | 重命名 |
| `<leader>ca` | 代码操作 |
| `gD` | 跳转到声明 |
| `<leader>th` | 切换内联提示 |

---

## 📦 插件管理

### 插件管理器
使用 [lazy.nvim](https://github.com/folke/lazy.nvim) 作为插件管理器，提供：
- 懒加载：按需加载插件
- 版本锁定：通过 `lazy-lock.json` 锁定版本
- 依赖管理：自动处理插件依赖
- 性能优化：启动时间优化

### 安装的插件列表

#### 核心插件
- **lazy.nvim** - 插件管理器
- **plenary.nvim** - Lua 工具库
- **nvim-web-devicons** - 图标支持

#### 编辑器增强
- **nvim-treesitter** - 语法高亮和代码解析
- **nvim-autopairs** - 自动配对括号
- **nvim-surround** - 快速添加/删除包围字符
- **Comment.nvim** - 智能注释
- **nvim-colorizer.lua** - 颜色代码高亮
- **todo-comments.nvim** - TODO 注释高亮
- **indent-blankline.nvim** - 缩进线显示

#### 文件和查找
- **telescope.nvim** - 模糊查找器
- **telescope-fzf-native.nvim** - FZF 原生支持
- **telescope-ui-select.nvim** - UI 选择器
- **neo-tree.nvim** - 文件浏览器
- **nvim-window-picker** - 窗口选择器

#### LSP 和补全
- **nvim-lspconfig** - LSP 配置
- **mason.nvim** - LSP 服务器管理
- **mason-lspconfig.nvim** - Mason 和 LSP 集成
- **mason-tool-installer.nvim** - 工具自动安装
- **nvim-cmp** - 补全引擎
- **cmp-nvim-lsp** - LSP 补全源
- **cmp-buffer** - 缓冲区补全
- **cmp-path** - 路径补全
- **LuaSnip** - 代码片段引擎
- **cmp_luasnip** - 代码片段补全
- **friendly-snippets** - 预定义代码片段

#### 格式化和 Linting
- **none-ls.nvim** - 格式化和 linting
- **none-ls-extras.nvim** - 额外的格式化工具
- **mason-null-ls.nvim** - Mason 和 null-ls 集成

#### Git 集成
- **gitsigns.nvim** - Git 状态显示
- **vim-fugitive** - Git 命令集成
- **vim-rhubarb** - GitHub 集成

#### UI 和主题
- **nord.nvim** - Nord 主题
- **lualine.nvim** - 状态栏
- **bufferline.nvim** - 缓冲区标签
- **alpha-nvim** - 启动页面
- **which-key.nvim** - 键位提示

#### 工具和实用程序
- **vim-sleuth** - 自动检测缩进
- **vim-tmux-navigator** - Tmux 导航
- **vim-rsi** - Readline 风格键位
- **vim-bbye** - 更好的缓冲区删除
- **fidget.nvim** - LSP 进度显示
- **hererocks** - Lua 环境管理

#### 专用功能
- **leetcode.nvim** - LeetCode 集成
- **image.nvim** - 图片预览

### 插件命令

#### 基本命令
- `:Lazy` - 打开插件管理器界面
- `:Lazy install` - 安装所有插件
- `:Lazy update` - 更新所有插件
- `:Lazy sync` - 同步插件状态
- `:Lazy clean` - 清理未使用的插件
- `:Lazy profile` - 查看启动性能分析

#### 高级命令
- `:Lazy restore` - 恢复到锁定版本
- `:Lazy log` - 查看插件更新日志
- `:Lazy health` - 检查插件健康状态

---

## 🔧 安装与更新

### 初始安装

#### 1. 备份现有配置
```bash
# 备份现有配置
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

#### 2. 克隆配置
```bash
# 方式1: 如果你有这个配置的仓库
git clone <your-repo-url> ~/.config/nvim

# 方式2: 或者直接复制现有配置
cp -r /path/to/current/config ~/.config/nvim
```

#### 3. 首次启动
```bash
# 启动 Neovim，插件会自动安装
nvim
```

### 更新操作

#### 更新插件
```bash
# 在 Neovim 中执行
:Lazy update

# 或者使用同步命令
:Lazy sync
```

#### 更新 LSP 服务器
```bash
# 打开 Mason 管理器
:Mason

# 或者更新所有已安装的工具
:MasonUpdate
```

#### 更新 Treesitter 解析器
```bash
# 更新所有解析器
:TSUpdate

# 更新特定语言解析器
:TSInstall <language>
```

### 版本锁定

配置使用 `lazy-lock.json` 锁定插件版本：

```bash
# 锁定当前版本
:Lazy lock

# 恢复到锁定版本
:Lazy restore
```

---

## 🔧 维护指南

### 日常维护

#### 1. 定期更新
```bash
# 每周建议执行一次
:Lazy sync
:Mason
:TSUpdate
```

#### 2. 清理无用插件
```bash
# 清理未使用的插件
:Lazy clean
```

#### 3. 检查健康状态
```bash
# 检查 Neovim 健康状态
:checkhealth

# 检查插件健康状态
:Lazy health
```

### 性能优化

#### 1. 启动时间分析
```bash
# 分析启动时间
:Lazy profile

# 或者使用命令行
nvim --startuptime startup.log
```

#### 2. 内存使用监控
```bash
# 查看内存使用
:lua print(collectgarbage("count"))
```

#### 3. 插件加载优化
- 检查 `lazy-lock.json` 中的版本
- 移除不必要的插件
- 优化插件加载条件

### 配置自定义

#### 1. 添加新插件
在 `lua/plugins/` 目录中创建新的插件配置文件：

```lua
-- lua/plugins/new-plugin.lua
return {
  'author/plugin-name',
  config = function()
    -- 插件配置
  end
}
```

#### 2. 修改键位映射
编辑 `lua/core/keymaps.lua` 文件添加新的键位：

```lua
vim.keymap.set("n", "<leader>new", ":command<CR>", { desc = "Description" })
```

#### 3. 调整编辑器选项
编辑 `lua/core/options.lua` 文件：

```lua
vim.o.new_option = value
```

### 备份和恢复

#### 1. 备份配置
```bash
# 备份整个配置目录
tar -czf nvim-config-backup.tar.gz ~/.config/nvim

# 备份插件锁定文件
cp ~/.config/nvim/lazy-lock.json ~/nvim-lock-backup.json
```

#### 2. 恢复配置
```bash
# 恢复配置
tar -xzf nvim-config-backup.tar.gz -C ~/

# 恢复插件版本
cp ~/nvim-lock-backup.json ~/.config/nvim/lazy-lock.json
:Lazy restore
```

---

## 🆘 故障排除

### 常见问题

#### 1. 插件加载失败
```bash
# 检查插件状态
:Lazy

# 重新安装问题插件
:Lazy install <plugin-name>

# 清理并重新安装
:Lazy clean
:Lazy install
```

#### 2. LSP 服务器问题
```bash
# 检查 LSP 状态
:LspInfo

# 重启 LSP 服务器
:LspRestart

# 检查 Mason 安装
:Mason
```

#### 3. Treesitter 语法高亮问题
```bash
# 检查 Treesitter 状态
:TSInstallInfo

# 重新安装解析器
:TSUninstall <language>
:TSInstall <language>
```

#### 4. 键位映射冲突
```bash
# 检查键位映射
:verbose map <key>

# 查看所有映射
:map
```

#### 5. image.nvim 插件错误
**错误信息**: `tmux does not have allow-passthrough enabled`

**解决方案**:

**方案1：配置 tmux（推荐）**
```bash
# 在 ~/.tmux.conf 中添加：
set -g allow-passthrough on

# 重新加载配置
tmux source-file ~/.tmux.conf
```

**方案2：临时禁用插件**
```bash
# 在 Neovim 中执行
:Lazy

# 找到 image.nvim 插件并禁用
```

**方案3：修改插件配置**
插件已配置为在不支持的环境中自动禁用，避免错误。

### 日志调试

#### 1. 查看日志
```bash
# Neovim 日志
:messages

# LSP 日志
:LspLog

# Lazy 日志
:Lazy log
```

#### 2. 启用调试模式
```lua
-- 在配置中启用调试
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.debug = true
```

### 性能问题

#### 1. 启动缓慢
```bash
# 分析启动时间
nvim --startuptime startup.log

# 检查插件加载时间
:Lazy profile
```

#### 2. 运行时卡顿
- 检查 `updatetime` 设置
- 减少 Treesitter 解析器数量
- 优化 LSP 配置

### 配置重置

#### 1. 软重置
```bash
# 重新加载配置
:source ~/.config/nvim/init.lua

# 重启 Neovim
:qa!
nvim
```

#### 2. 硬重置
```bash
# 删除插件缓存
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim

# 重新启动 Neovim
nvim
```

---

## 📚 参考资源

### 官方文档
- [Neovim 官方文档](https://neovim.io/doc/)
- [Lazy.nvim 文档](https://github.com/folke/lazy.nvim)
- [LSP 配置指南](https://github.com/neovim/nvim-lspconfig)

### 社区资源
- [Neovim Discourse](https://neovim.discourse.group/)
- [Reddit r/neovim](https://www.reddit.com/r/neovim/)
- [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim)

### 相关工具
- [Mason.nvim](https://github.com/williamboman/mason.nvim) - LSP 服务器管理
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - 语法高亮
- [Telescope](https://github.com/nvim-telescope/telescope.nvim) - 模糊查找

---

## 🎉 结语

这个配置提供了一个功能完整、性能优良的 Neovim 开发环境。通过模块化的架构设计，你可以轻松地添加、修改或删除功能来满足个人需求。

记住定期更新和维护配置，这样可以确保你始终使用最新的功能和修复。如果遇到问题，可以参考故障排除部分，或者查阅相关插件的官方文档。

享受使用 Neovim 的乐趣！ 🚀