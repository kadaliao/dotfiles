# Neovim 使用指南

## 基础配置

- 空格键（Space）被设置为 leader 键
- 使用 Lazy 作为插件管理器
- 已安装多个实用插件，包括：
  - neotree（文件树）
  - telescope（模糊查找）
  - lsp（语言服务器）
  - treesitter（语法高亮）
  - bufferline（缓冲区管理）
  - lualine（状态栏）
  等

## 常用快捷键

### 基础操作
- `<C-s>` - 保存文件
- `<leader>sn` - 保存文件（不进行自动格式化）
- `<C-q>` - 退出文件
- `jk` 或 `kj` - 在插入模式下退出到普通模式

### 窗口管理
- `<leader>v` - 垂直分割窗口
- `<leader>h` - 水平分割窗口
- `<leader>se` - 使分割窗口大小相等
- `<leader>xs` - 关闭当前分割窗口
- `<C-h/j/k/l>` - 在分割窗口间移动

### 缓冲区管理
- `<Tab>` - 切换到下一个缓冲区
- `<S-Tab>` - 切换到上一个缓冲区
- `<leader>x` - 关闭当前缓冲区
- `<leader>b` - 新建缓冲区

### 标签页管理
- `<leader>to` - 打开新标签页
- `<leader>tx` - 关闭当前标签页
- `<leader>tn` - 切换到下一个标签页
- `<leader>tp` - 切换到上一个标签页

### 系统剪贴板操作
- `<leader>y` - 复制到系统剪贴板
- `<leader>Y` - 复制整行到系统剪贴板
- `<leader>p` - 从系统剪贴板粘贴
- `<leader>P` - 在光标前从系统剪贴板粘贴
- `<leader>d` - 剪切到系统剪贴板
- `<leader>D` - 剪切到行尾到系统剪贴板

### 文档操作
- `vae` - 选择整个文档
- `dae` - 删除整个文档
- `cae` - 删除整个文档并进入插入模式

### Telescope 模糊查找
- `<leader>sf` - 搜索文件
- `<leader>sg` - 全局搜索
- `<leader>sh` - 搜索帮助文档
- `<leader>sk` - 搜索快捷键
- `<leader>ss` - 搜索 Telescope 命令
- `<leader>sw` - 搜索当前单词
- `<leader>sd` - 搜索诊断信息
- `<leader>sr` - 恢复上次搜索
- `<leader>s.` - 搜索最近文件
- `<leader><leader>` - 查找已存在的缓冲区

### 诊断信息
- `[d` - 跳转到上一个诊断信息
- `]d` - 跳转到下一个诊断信息
- `<leader>d` - 打开浮动诊断信息
- `<leader>q` - 打开诊断列表

### 其他功能
- `<leader>lw` - 切换行换行
- `<C-d>` - 向下滚动并居中
- `<C-u>` - 向上滚动并居中
- `<Up/Down/Left/Right>` - 调整窗口大小

## 提示
1. 在 Telescope 中：
   - 插入模式下按 `<C-/>` 或普通模式下按 `?` 可以查看所有可用的快捷键
   - 使用 `<C-j/k>` 在搜索结果中移动
   - 使用 `<C-l>` 选择默认操作

2. 文件搜索会自动忽略 `node_modules`、`.git` 和 `.venv` 目录

3. 如果遇到问题，可以使用 `:checkhealth` 命令检查配置状态 