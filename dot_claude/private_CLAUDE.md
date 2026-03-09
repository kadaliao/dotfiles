# Python 环境规范

本机所有 Python 相关操作必须使用 uv：
- 安装包使用 `uv pip install` 而不是 `pip install`
- 运行 Python 脚本使用 `uv run python` 而不是 `python`
- 创建虚拟环境使用 `uv venv` 而不是 `python -m venv`

# Markdown 格式规范

在生成 Markdown 文件时：

- 需要换行的连续信息应使用列表格式（- 或数字列表）
- 避免使用纯粹的连续行来表达应该分行的信息
- 代码块必须包含语言标识符（如 ```bash）
- 保持适当的空行间距
