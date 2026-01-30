# Neovim 配置快速使用手册

> **Leader 键：`空格` (Space)**
> **配置最后更新**: 2026-01-30
> **久未使用？** 阅读本文档快速回忆！

## 📑 目录
- [快速开始](#快速开始)
- [基本操作](#基本操作)
- [文件和项目导航](#文件和项目导航)
- [代码编辑](#代码编辑)
- [LSP 功能](#lsp-功能)
- [增强功能（新）](#增强功能新)
- [Git 集成](#git-集成)
- [窗口和标签管理](#窗口和标签管理)
- [已安装的插件](#已安装的插件)
- [工具安装](#工具安装)
- [常用操作流程](#常用操作流程)
- [故障排查](#故障排查)

---

## 🚀 快速开始

### 首次使用
```bash
# 1. 启动 Neovim
nvim

# 2. 等待插件自动安装（第一次启动会自动安装）
# 提示：按 <leader>ch 检查健康状态

# 3. 安装语言工具（按需）
cd ~/.config/nvim
./install-tools.sh
```

### 核心概念
- **Leader 键 = 空格键**：大部分快捷键以空格开始
- **按 Leader 键等待 0.3 秒**：会自动显示可用的快捷键提示（which-key）
- **智能提示**：打开特定语言文件时，会提示缺失的工具

---

## 📝 基本操作

### 文件操作
| 快捷键 | 功能 |
|--------|------|
| `Ctrl-s` | 💾 保存文件（自动格式化） |
| `<leader>sn` | 💾 保存文件（不自动格式化） |
| `Ctrl-q` | ❌ 退出文件 |
| `jk` / `kj` | 🚪 退出插入模式（= ESC） |

### Buffer 管理
| 快捷键 | 功能 |
|--------|------|
| `Tab` | ➡️ 下一个 buffer |
| `Shift-Tab` | ⬅️ 上一个 buffer |
| `<leader>x` | ❌ 关闭当前 buffer |
| `<leader>b` | ➕ 新建 buffer |
| `<leader><leader>` | 🔍 查找已打开的 buffers |

### 移动和滚动
| 快捷键 | 功能 |
|--------|------|
| `Ctrl-d` | ⬇️ 向下半页滚动并居中 |
| `Ctrl-u` | ⬆️ 向上半页滚动并居中 |
| `n` | ➡️ 下一个搜索结果并居中 |
| `N` | ⬅️ 上一个搜索结果并居中 |

### 系统剪贴板操作
| 快捷键 | 功能 |
|--------|------|
| `<leader>y` | 📋 复制到系统剪贴板 |
| `<leader>Y` | 📋 复制整行到系统剪贴板 |
| `<leader>p` | 📌 从系统剪贴板粘贴 |
| `<leader>P` | 📌 从系统剪贴板粘贴（光标前） |
| `<leader>dc` | ✂️ 剪切到系统剪贴板 |
| `<leader>dC` | ✂️ 剪切到行尾到系统剪贴板 |

### 全文档操作
| 快捷键 | 功能 |
|--------|------|
| `vae` | 选择整个文档 |
| `dae` | 删除整个文档 |
| `cae` | 删除整个文档并进入插入模式 |

---

## 🗂️ 文件和项目导航

### Neo-tree（文件浏览器）
| 快捷键 | 功能 |
|--------|------|
| `<leader>e` | 🌳 切换文件浏览器（需要安装后配置） |
| `\` | 📍 在文件浏览器中定位当前文件 |

**Neo-tree 内部快捷键：**
| 快捷键 | 功能 |
|--------|------|
| `Enter` / `l` | 打开文件/展开文件夹 |
| `h` | 折叠文件夹 |
| `a` | 新建文件 |
| `A` | 新建文件夹 |
| `d` | 删除 |
| `r` | 重命名 |
| `c` | 复制 |
| `m` | 移动 |
| `H` | 切换显示隐藏文件 |
| `?` | 显示所有快捷键 |

### Telescope（模糊查找）
| 快捷键 | 功能 |
|--------|------|
| `<leader>sf` | 🔍 查找文件 |
| `<leader>sg` | 🔎 全局文本搜索（grep） |
| `<leader>sw` | 🔦 搜索当前光标下的单词 |
| `<leader>sh` | 📚 搜索帮助文档 |
| `<leader>sk` | ⌨️ 搜索快捷键 |
| `<leader>sd` | 🐛 搜索诊断信息 |
| `<leader>sr` | 🔄 恢复上次搜索 |
| `<leader>s.` | 🕐 查找最近打开的文件 |
| `<leader>/` | 🔍 在当前 buffer 中模糊搜索 |
| `<leader>s/` | 🔍 在所有打开的文件中搜索 |
| `<leader>ss` | 🎯 选择 Telescope 功能 |

**Telescope 窗口内：**
| 快捷键 | 功能 |
|--------|------|
| `Ctrl-j` | 下一个结果 |
| `Ctrl-k` | 上一个结果 |
| `Ctrl-l` | 打开选中文件 |
| `Ctrl-/` 或 `?` | 显示所有快捷键 |

---

## ✏️ 代码编辑

### 自动补全（nvim-cmp）
| 快捷键 | 功能 |
|--------|------|
| `Ctrl-n` | 下一个补全项 |
| `Ctrl-p` | 上一个补全项 |
| `Ctrl-y` | ✅ 确认选择 |
| `Ctrl-Space` | 手动触发补全 |
| `Tab` | 下一项/下一个占位符 |
| `Shift-Tab` | 上一项/上一个占位符 |

### Surround（快速操作括号引号）
| 快捷键 | 功能 | 示例 |
|--------|------|------|
| `ys{motion}{char}` | 添加包围 | `ysiw"` 给单词加引号 |
| `ds{char}` | 删除包围 | `ds"` 删除引号 |
| `cs{old}{new}` | 修改包围 | `cs"'` 双引号改单引号 |

### Flash（快速跳转）🆕
| 快捷键 | 功能 |
|--------|------|
| `s` | ⚡ Flash 跳转（超快定位） |
| `S` | 🌳 Treesitter 节点跳转 |

### Treesitter 文本对象 🆕
| 快捷键 | 功能 |
|--------|------|
| `af` / `if` | 选择函数（外部/内部） |
| `ac` / `ic` | 选择类（外部/内部） |
| `aa` / `ia` | 选择参数（外部/内部） |
| `]f` / `[f` | 跳到下/上一个函数 |
| `]c` / `[c` | 跳到下/上一个类 |

### 其他编辑功能
| 快捷键 | 功能 |
|--------|------|
| `gcc` | 💬 注释/取消注释当前行 |
| `gc{motion}` | 💬 注释（可视模式） |
| `<` / `>` | 减少/增加缩进（可视模式） |
| `<leader>lw` | 🔄 切换换行显示 |

### Emacs 风格快捷键（插入/命令模式）
| 快捷键 | 功能 |
|--------|------|
| `Ctrl-k` | 删除光标到行尾 |
| `Ctrl-u` | 删除光标到行首 |
| `Ctrl-a` | 移动到行首 |
| `Ctrl-e` | 移动到行尾 |

---

## 🔧 LSP 功能

### 代码导航
| 快捷键 | 功能 |
|--------|------|
| `gd` | 🎯 跳转到定义 |
| `gD` | 📜 跳转到声明 |
| `gr` | 🔗 查找所有引用 |
| `gI` | 🔨 跳转到实现 |
| `<leader>D` | 📦 跳转到类型定义 |
| `Ctrl-t` | ⬅️ 返回跳转前的位置 |

### 代码操作
| 快捷键 | 功能 |
|--------|------|
| `<leader>ca` | 💡 代码操作（自动导入、修复等） |
| `<leader>rn` | ✏️ 重命名符号（全局） |
| `<leader>th` | 👁️ 切换内联提示 |

### 符号搜索
| 快捷键 | 功能 |
|--------|------|
| `<leader>ds` | 📄 搜索当前文档的符号 |
| `<leader>ws` | 🌐 搜索工作区的符号 |

### 诊断信息
| 快捷键 | 功能 |
|--------|------|
| `[d` | ⬆️ 上一个诊断 |
| `]d` | ⬇️ 下一个诊断 |
| `<leader>e` | 💬 显示诊断详情（浮动窗口） |
| `<leader>q` | 📋 打开诊断列表 |

### 支持的语言（开箱即用）
- **TypeScript/JavaScript**: ts_ls + Prettier
- **Python**: Pyright + Ruff（linting + formatting）
- **Lua**: lua_ls + StyLua
- **Rust**: rust_analyzer（保存时自动格式化）
- **Web**: HTML, CSS, Tailwind CSS
- **其他**: Docker, SQL, Terraform, JSON, YAML, Bash

---

## 🎨 增强功能（新）

### Trouble（增强的诊断列表）🆕
| 快捷键 | 功能 |
|--------|------|
| `<leader>xx` | 📋 打开诊断列表 |
| `<leader>xX` | 📄 当前 buffer 诊断 |
| `<leader>xq` | 🔧 Quickfix 列表 |
| `<leader>xl` | 📍 Location 列表 |
| `<leader>cs` | 🔣 符号列表 |

### Which-key（快捷键提示）🆕
- **按 `<leader>` 并等待**：自动显示所有可用快捷键
- 再也不用记住所有快捷键！

### Treesitter Context 🆕
- 自动显示当前函数/类名在顶部
- 滚动长函数时保持上下文

### 自动格式化 🆕
- **保存时自动格式化**（支持的语言会自动格式化）
- 使用 `<leader>sn` 保存时跳过格式化

---

## 🔀 Git 集成

### Gitsigns（行内 Git 状态）
Git 修改会在行号旁显示：
- `+` 新增行（绿色）
- `~` 修改行（蓝色）
- `_` 删除行（红色）

### Vim-fugitive（Git 命令）
命令模式中使用：
```vim
:Git status          " 查看状态
:Git commit          " 提交
:Git push            " 推送
:Git pull            " 拉取
:Git blame           " 查看 blame
```

---

## 🪟 窗口和标签管理

### 窗口分割
| 快捷键 | 功能 |
|--------|------|
| `<leader>v` | ➗ 垂直分割 |
| `<leader>h` | ➖ 水平分割 |
| `<leader>se` | ⚖️ 平衡窗口大小 |
| `<leader>xs` | ❌ 关闭当前窗口 |

### 窗口导航
| 快捷键 | 功能 |
|--------|------|
| `Ctrl-h` | ⬅️ 左边窗口 |
| `Ctrl-j` | ⬇️ 下边窗口 |
| `Ctrl-k` | ⬆️ 上边窗口 |
| `Ctrl-l` | ➡️ 右边窗口 |

### 调整窗口大小
| 快捷键 | 功能 |
|--------|------|
| `↑` / `↓` | 调整高度 |
| `←` / `→` | 调整宽度 |

### 标签页
| 快捷键 | 功能 |
|--------|------|
| `<leader>to` | 新建标签 |
| `<leader>tx` | 关闭标签 |
| `<leader>tn` | 下一个标签 |
| `<leader>tp` | 上一个标签 |

---

## 📦 已安装的插件

### 核心功能
- **lazy.nvim** - 插件管理器（懒加载）
- **nvim-lspconfig** + **mason.nvim** - LSP 配置和自动安装
- **nvim-treesitter** - 语法解析和高亮
- **nvim-cmp** + **LuaSnip** - 智能补全

### 界面和导航
- **neo-tree.nvim** - 文件浏览器
- **telescope.nvim** - 模糊查找（超强）
- **bufferline.nvim** - Buffer 标签栏
- **lualine.nvim** - 状态栏
- **alpha-nvim** - 启动页面
- **which-key.nvim** 🆕 - 快捷键提示
- **trouble.nvim** 🆕 - 增强的诊断列表
- **flash.nvim** 🆕 - 快速跳转

### 编辑增强
- **nvim-surround** - 操作括号引号
- **nvim-autopairs** - 自动补全括号
- **Comment.nvim** - 快速注释
- **vim-sleuth** - 自动检测缩进
- **nvim-treesitter-textobjects** 🆕 - 智能文本对象
- **nvim-treesitter-context** 🆕 - 显示上下文

### Git 和其他
- **gitsigns.nvim** - Git 状态显示
- **vim-fugitive** + **vim-rhubarb** - Git 集成
- **none-ls.nvim** - 格式化和 linting
- **todo-comments.nvim** - 高亮 TODO 注释
- **nvim-colorizer.lua** - 颜色代码预览

---

## 🛠️ 工具安装

### 方式一：使用安装脚本（推荐）
```bash
cd ~/.config/nvim
./install-tools.sh
```

### 方式二：使用 Mason（推荐）
```vim
:Mason                  " 打开 Mason 界面
```
在 Mason 中：
- `i` - 安装光标下的工具
- `X` - 卸载工具
- `U` - 更新工具
- `g?` - 帮助

### 方式三：手动安装常用工具
```bash
# Python
pip install ruff pyright

# JavaScript/TypeScript
npm install -g prettier eslint_d

# Lua
brew install stylua

# Shell
brew install shfmt
npm install -g bash-language-server
```

### 智能提示系统 🆕
当你打开某种语言的文件时：
- ✅ **必需工具缺失**：会显示警告（WARN）
- ℹ️ **可选工具缺失**：会显示提示（INFO）
- 🔕 **已安装的工具**：不会提示
- 💡 **按需检查**：只在打开相关文件时检查，不会一次性全部提示

**手动检查当前文件类型的工具：**
```vim
:CheckTools
```

---

## 🎯 常用操作流程

### 1️⃣ 打开项目
```bash
# 在项目目录
nvim .

# 或打开特定文件
nvim main.py
```

### 2️⃣ 浏览和查找文件
```
1. <leader>sf          # 查找文件（最常用）
2. <leader>sg          # 全局搜索文本
3. <leader>sw          # 搜索当前单词
```

### 3️⃣ 代码编辑工作流
```
1. gd                  # 跳转到定义
2. gr                  # 查看所有引用
3. <leader>ca          # 代码操作（自动导入等）
4. <leader>rn          # 重命名变量
5. Ctrl-s              # 保存（自动格式化）
```

### 4️⃣ 使用诊断信息
```
1. ]d                  # 跳到下一个错误
2. <leader>e           # 查看错误详情
3. <leader>xx          # 打开 Trouble 列表
4. <leader>ca          # 应用修复建议
```

### 5️⃣ Git 工作流
```
1. :Git status         # 查看状态
2. :Git add %          # 暂存当前文件
3. :Git commit         # 提交
4. :Git push           # 推送
```

### 6️⃣ 多窗口编辑
```
1. <leader>v           # 垂直分割
2. Ctrl-h/j/k/l        # 在窗口间导航
3. <leader>sf          # 在新窗口打开文件
```

---

## 🔍 故障排查

### LSP 不工作
```vim
:LspInfo                    " 查看 LSP 状态
:Mason                      " 检查 LSP 服务器安装
:checkhealth lsp            " 健康检查
:CheckTools                 " 检查当前文件类型的工具
```

### 格式化不工作
```vim
:NullLsInfo                 " 查看 none-ls 状态
:Mason                      " 确保格式化工具已安装
:checkhealth                " 全面健康检查
```

### 插件问题
```vim
:Lazy sync                  " 同步所有插件
:Lazy clean                 " 清理未使用的插件
:Lazy update                " 更新所有插件
:Lazy profile               " 查看启动性能
```

### 快捷键不工作
```vim
:verbose map <leader>sf     " 查看快捷键映射情况
:Telescope keymaps          " 搜索所有快捷键
```

### 配置出错
```vim
:checkhealth                " 全面健康检查
:messages                   " 查看错误消息
:LspLog                     " 查看 LSP 日志
```

---

## 💡 实用技巧

### 1. 快速打开配置
```vim
:e ~/.config/nvim/init.lua
:e ~/.config/nvim/lua/core/keymaps.lua
```

### 2. 查看所有快捷键
- 按 `<leader>` 然后等待 → 显示所有 Leader 快捷键
- `:Telescope keymaps` → 搜索所有快捷键

### 3. 学习新功能
- `:help <plugin-name>` → 查看插件文档
- `:Telescope help_tags` → 搜索帮助文档

### 4. 性能优化
```vim
:Lazy profile               " 查看插件加载时间
```

### 5. 临时禁用自动格式化
```vim
:let g:disable_autoformat = 1    " 禁用
:let g:disable_autoformat = 0    " 启用
```

---

## 📁 配置文件结构

```
~/.config/nvim/
├── init.lua                          # 主入口
├── install-tools.sh                  # 工具安装脚本 🆕
├── lua/
│   ├── core/
│   │   ├── options.lua              # Vim 选项
│   │   ├── keymaps.lua              # 快捷键
│   │   ├── snippets.lua             # 代码片段
│   │   ├── utils.lua                # 工具函数
│   │   ├── health.lua               # 健康检查
│   │   └── filetype-tools.lua       # 文件类型工具检查 🆕
│   └── plugins/
│       ├── lsp.lua                  # LSP 配置
│       ├── autocompletion.lua       # 补全配置
│       ├── telescope.lua            # 查找配置
│       ├── treesitter.lua           # 语法解析 🆕 增强
│       ├── trouble.lua              # 诊断列表 🆕
│       ├── flash.lua                # 快速跳转 🆕
│       ├── which-key.lua            # 快捷键提示 🆕
│       └── ...                      # 其他插件
└── README.md                         # 本文档
```

---

## 🎓 学习资源

- **Neovim 官方文档**: `:help`
- **快捷键速查**: 按 `<leader>` 等待提示
- **插件文档**: `:help <plugin-name>`
- **视频教程**: 搜索 "Neovim from scratch"

---

## ⚡ 性能说明

当前配置已优化：
- ✅ 懒加载插件（启动更快）
- ✅ 按需检查工具（减少启动警告）
- ✅ 智能文件类型检测
- ✅ 异步 LSP 和格式化

典型启动时间：< 50ms （取决于机器性能）

---

## 🆘 需要帮助？

1. **配置问题**: `:checkhealth`
2. **快捷键忘记**: 按 `<leader>` 等待
3. **功能不清楚**: `:Telescope help_tags`
4. **工具缺失**: `:CheckTools` 或运行 `./install-tools.sh`

---

**享受你的 Neovim 之旅！🚀**

*最后更新: 2026-01-30*
