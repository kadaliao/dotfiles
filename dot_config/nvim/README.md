# Neovim 配置快速使用手册

> Leader 键：`空格` (Space)

## 目录
- [基本操作](#基本操作)
- [文件和项目导航](#文件和项目导航)
- [代码编辑](#代码编辑)
- [LSP 功能](#lsp-功能)
- [Git 集成](#git-集成)
- [窗口和标签管理](#窗口和标签管理)
- [已安装的插件](#已安装的插件)

---

## 基本操作

### 文件操作
| 快捷键 | 功能 |
|--------|------|
| `Ctrl-s` | 保存文件 |
| `<leader>sn` | 保存文件（不自动格式化） |
| `Ctrl-q` | 退出文件 |
| `jk` / `kj` | 退出插入模式（等同于 ESC） |

### Buffer 管理
| 快捷键 | 功能 |
|--------|------|
| `Tab` | 下一个 buffer |
| `Shift-Tab` | 上一个 buffer |
| `<leader>x` | 关闭当前 buffer |
| `<leader>b` | 新建 buffer |
| `<leader><leader>` | 查找已打开的 buffers |

### 移动和滚动
| 快捷键 | 功能 |
|--------|------|
| `Ctrl-d` | 向下半页滚动并居中 |
| `Ctrl-u` | 向上半页滚动并居中 |
| `n` | 跳转到下一个搜索结果并居中 |
| `N` | 跳转到上一个搜索结果并居中 |

### 复制粘贴（系统剪贴板）
| 快捷键 | 功能 |
|--------|------|
| `<leader>y` | 复制到系统剪贴板 |
| `<leader>Y` | 复制整行到系统剪贴板 |
| `<leader>p` | 从系统剪贴板粘贴 |
| `<leader>P` | 从系统剪贴板粘贴（光标前） |
| `<leader>d` | 剪切到系统剪贴板 |

### 全文档操作
| 快捷键 | 功能 |
|--------|------|
| `vae` | 选择整个文档 |
| `dae` | 删除整个文档 |
| `cae` | 删除整个文档并进入插入模式 |

---

## 文件和项目导航

### Neo-tree（文件浏览器）
| 快捷键 | 功能 |
|--------|------|
| `<leader>e` | 切换文件浏览器 |
| `\` | 在文件浏览器中定位当前文件 |
| `<leader>ngs` | 打开 Git 状态窗口 |

**Neo-tree 内部快捷键：**
| 快捷键 | 功能 |
|--------|------|
| `Enter` / `l` | 打开文件/文件夹 |
| `Space` | 展开/折叠节点 |
| `a` | 新建文件 |
| `A` | 新建文件夹 |
| `d` | 删除 |
| `r` | 重命名 |
| `y` | 复制到剪贴板 |
| `x` | 剪切到剪贴板 |
| `p` | 粘贴 |
| `c` | 复制文件 |
| `m` | 移动文件 |
| `H` | 切换显示隐藏文件 |
| `/` | 模糊查找 |
| `q` | 关闭窗口 |
| `?` | 显示帮助 |

### Telescope（模糊查找）
| 快捷键 | 功能 |
|--------|------|
| `<leader>sf` | 查找文件 |
| `<leader>sg` | 全局文本搜索（grep） |
| `<leader>sw` | 搜索当前光标下的单词 |
| `<leader>sh` | 搜索帮助文档 |
| `<leader>sk` | 搜索快捷键 |
| `<leader>sd` | 搜索诊断信息 |
| `<leader>sr` | 恢复上次搜索 |
| `<leader>s.` | 查找最近打开的文件 |
| `<leader>/` | 在当前 buffer 中模糊搜索 |
| `<leader>s/` | 在所有打开的文件中搜索 |
| `<leader>ss` | 选择 Telescope 功能 |

**Telescope 窗口内快捷键：**
| 快捷键 | 功能 |
|--------|------|
| `Ctrl-j` | 下一个结果 |
| `Ctrl-k` | 上一个结果 |
| `Ctrl-l` | 打开选中文件 |
| `Ctrl-/`（插入模式）或 `?`（普通模式） | 显示所有快捷键 |

---

## 代码编辑

### 自动补全（nvim-cmp）
| 快捷键 | 功能 |
|--------|------|
| `Ctrl-n` | 下一个补全项 |
| `Ctrl-p` | 上一个补全项 |
| `Ctrl-y` | 确认选择 |
| `Ctrl-Space` | 手动触发补全 |
| `Tab` | 选择下一项/跳转到下一个代码片段占位符 |
| `Shift-Tab` | 选择上一项/跳转到上一个代码片段占位符 |
| `Alt-l` | 展开或跳转到下一个代码片段占位符 |
| `Alt-h` | 跳转到上一个代码片段占位符 |

### Surround（快速添加/修改括号引号等）
| 快捷键 | 功能 | 示例 |
|--------|------|------|
| `ys{motion}{char}` | 添加包围符号 | `ysiw"` - 给单词加双引号 |
| `ds{char}` | 删除包围符号 | `ds"` - 删除双引号 |
| `cs{old}{new}` | 修改包围符号 | `cs"'` - 把双引号改成单引号 |

### 其他编辑功能
| 快捷键 | 功能 |
|--------|------|
| `gcc` | 注释/取消注释当前行 |
| `gc{motion}` | 注释/取消注释（可视模式） |
| `<` / `>` | 减少/增加缩进（可视模式，可重复） |
| `<leader>lw` | 切换换行显示 |

### Emacs 风格快捷键（插入和命令模式）
| 快捷键 | 功能 |
|--------|------|
| `Ctrl-k` | 删除光标到行尾 |
| `Ctrl-u` | 删除光标到行首 |
| `Ctrl-a` | 移动到行首（vim-rsi 提供） |
| `Ctrl-e` | 移动到行尾（vim-rsi 提供） |

---

## LSP 功能

### 代码导航
| 快捷键 | 功能 |
|--------|------|
| `gd` | 跳转到定义 |
| `gD` | 跳转到声明 |
| `gr` | 查找引用 |
| `gI` | 跳转到实现 |
| `<leader>D` | 跳转到类型定义 |
| `Ctrl-t` | 返回跳转前的位置 |

### 代码操作
| 快捷键 | 功能 |
|--------|------|
| `<leader>ca` | 代码操作（Code Action） |
| `<leader>rn` | 重命名符号 |
| `<leader>th` | 切换内联提示（Inlay Hints） |

### 符号搜索
| 快捷键 | 功能 |
|--------|------|
| `<leader>ds` | 搜索当前文档的符号 |
| `<leader>ws` | 搜索工作区的符号 |

### 诊断信息
| 快捷键 | 功能 |
|--------|------|
| `[d` | 跳转到上一个诊断 |
| `]d` | 跳转到下一个诊断 |
| `<leader>d` | 显示诊断详情（浮动窗口） |
| `<leader>q` | 打开诊断列表 |

### 支持的语言
- **TypeScript/JavaScript**: ts_ls
- **Python**: ruff (LSP + 格式化)
- **Lua**: lua_ls + stylua (格式化)
- **Rust**: rust_analyzer (保存时自动格式化)
- **Web**: HTML, CSS, Tailwind CSS
- **其他**: Docker, SQL, Terraform, JSON, YAML

---

## Git 集成

### Gitsigns（行内 Git 状态）
Git 修改会在行号旁边显示符号：
- `+` 新增行
- `~` 修改行
- `_` 删除行

### Neo-tree Git 功能
| 快捷键 | 功能 |
|--------|------|
| `<leader>ngs` | 打开 Git 状态浮动窗口 |

**在 Git 状态窗口中：**
| 快捷键 | 功能 |
|--------|------|
| `A` | 暂存所有更改 |
| `ga` | 暂存文件 |
| `gu` | 取消暂存文件 |
| `gr` | 还原文件更改 |
| `gc` | 提交 |
| `gp` | 推送 |
| `gg` | 提交并推送 |

### Vim-fugitive（Git 命令）
在命令模式中使用：
- `:Git` 或 `:G` - Git 命令
- `:Git status` - 查看状态
- `:Git commit` - 提交
- `:Git push` - 推送
- `:Git pull` - 拉取
- `:Git blame` - 查看 blame

---

## 窗口和标签管理

### 窗口分割
| 快捷键 | 功能 |
|--------|------|
| `<leader>v` | 垂直分割窗口 |
| `<leader>h` | 水平分割窗口 |
| `<leader>se` | 平衡窗口大小 |
| `<leader>xs` | 关闭当前窗口 |

### 窗口导航
| 快捷键 | 功能 |
|--------|------|
| `Ctrl-h` | 移动到左边窗口 |
| `Ctrl-j` | 移动到下边窗口 |
| `Ctrl-k` | 移动到上边窗口 |
| `Ctrl-l` | 移动到右边窗口 |

### 窗口调整大小
| 快捷键 | 功能 |
|--------|------|
| `↑` | 减小高度 |
| `↓` | 增加高度 |
| `←` | 减小宽度 |
| `→` | 增加宽度 |

### 标签页
| 快捷键 | 功能 |
|--------|------|
| `<leader>to` | 新建标签页 |
| `<leader>tx` | 关闭标签页 |
| `<leader>tn` | 下一个标签页 |
| `<leader>tp` | 上一个标签页 |

---

## 已安装的插件

### 核心功能
- **lazy.nvim** - 插件管理器
- **nvim-lspconfig** - LSP 配置
- **mason.nvim** - LSP/工具自动安装
- **nvim-treesitter** - 语法解析和高亮
- **nvim-cmp** - 自动补全
- **LuaSnip** - 代码片段引擎

### 界面和导航
- **neo-tree.nvim** - 文件浏览器
- **telescope.nvim** - 模糊查找
- **bufferline.nvim** - Buffer 标签栏
- **lualine.nvim** - 状态栏
- **alpha-nvim** - 启动页面
- **indent-blankline** - 缩进线
- **which-key.nvim** - 快捷键提示

### 编辑增强
- **nvim-surround** - 快速操作括号引号
- **nvim-autopairs** - 自动补全括号
- **Comment.nvim** - 快速注释
- **vim-sleuth** - 自动检测缩进
- **vim-rsi** - Emacs 风格键绑定

### Git 集成
- **gitsigns.nvim** - 行内 Git 状态显示
- **vim-fugitive** - Git 命令集成
- **vim-rhubarb** - GitHub 集成

### 其他工具
- **none-ls.nvim** - 格式化和 linting
- **todo-comments.nvim** - 高亮 TODO/FIXME 等注释
- **nvim-colorizer.lua** - 颜色代码高亮
- **vim-tmux-navigator** - Tmux 和 Vim 分割导航

### 主题
- **tokyonight.nvim** - 配色方案（或其他主题）

---

## 常用操作流程

### 1. 打开项目并浏览文件
```
1. nvim .              # 打开当前目录
2. <leader>e           # 打开文件浏览器
3. <leader>sf          # 或使用 Telescope 快速查找文件
```

### 2. 代码编辑
```
1. gd                  # 跳转到定义
2. gr                  # 查看所有引用
3. <leader>ca          # 执行代码操作（如自动导入）
4. <leader>rn          # 重命名变量/函数
5. Ctrl-s              # 保存（自动格式化）
```

### 3. 搜索和替换
```
1. <leader>sg          # 全局搜索文本
2. <leader>sw          # 搜索当前光标下的单词
3. :%s/old/new/g       # 在当前文件中替换
```

### 4. Git 工作流
```
1. <leader>ngs         # 查看 Git 状态
2. ga                  # 暂存文件
3. gc                  # 提交
4. :Git push           # 推送到远程
```

---

## 自定义配置

配置文件结构：
```
~/.config/nvim/
├── init.lua                    # 主配置入口
├── lua/
│   ├── core/
│   │   ├── options.lua        # Vim 选项配置
│   │   ├── keymaps.lua        # 通用快捷键
│   │   └── snippets.lua       # 自定义代码片段
│   └── plugins/
│       ├── lsp.lua            # LSP 配置
│       ├── none-ls.lua        # 格式化和 linting
│       ├── telescope.lua      # 文件查找
│       ├── neotree.lua        # 文件浏览器
│       ├── autocompletion.lua # 自动补全
│       └── ...                # 其他插件配置
```

### 常用自定义
- 修改 Leader 键: 编辑 `lua/core/keymaps.lua`
- 添加 LSP 服务器: 编辑 `lua/plugins/lsp.lua`
- 修改主题: 编辑 `lua/plugins/colortheme.lua`
- 添加格式化工具: 编辑 `lua/plugins/none-ls.lua`

---

## 实用技巧

1. **快速打开配置文件**: `:e ~/.config/nvim/init.lua`
2. **重新加载配置**: `:source ~/.config/nvim/init.lua` 或重启 Nvim
3. **查看 LSP 日志**: `:LspLog`
4. **管理插件**: `:Lazy` - 安装/更新/删除插件
5. **管理 LSP 工具**: `:Mason` - 安装/卸载 LSP 服务器和工具
6. **健康检查**: `:checkhealth` - 检查配置问题
7. **查看所有快捷键**: `<leader>sk` 或按下 Leader 键等待 which-key 提示

---

## 故障排查

### LSP 不工作
```vim
:LspInfo                " 查看 LSP 状态
:Mason                  " 确保 LSP 服务器已安装
:checkhealth lsp        " 运行健康检查
```

### 格式化不工作
```vim
:NullLsInfo            " 查看 none-ls 状态
:Mason                 " 确保格式化工具已安装
```

### 插件问题
```vim
:Lazy sync             " 同步所有插件
:Lazy clean            " 清理未使用的插件
:Lazy update           " 更新所有插件
```

---

**最后更新**: 2025-11-13

更多帮助：
- Neovim 文档：`:help`
- 插件文档：`:help <plugin-name>`
- Telescope 帮助：`:Telescope help_tags`
