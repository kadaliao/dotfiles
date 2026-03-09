# Python 环境规范

本机所有 Python 相关操作必须使用 uv：

- 安装包使用 `uv pip install` 而不是 `pip install`
- 运行 Python 脚本使用 `uv run python` 而不是 `python`
- 创建虚拟环境使用 `uv venv` 而不是 `python -m venv`

# DAE 项目规范

如果检测到当前 Python 项目是 dae 项目，调试脚本时必须使用：

DAE 项目的识别特征（满足其中一项即可判定）：

- 项目根目录有 `app.yaml`，且文件头部包含 `application:`、`runtime: python`、`api_version:` 等 DAE 特有字段
- 项目根目录有 `pip-req.txt` 或 `sys-req.txt`，尤其是文件中出现 `github.intra.douban.com` 等豆瓣内部链接

```bash
dae runscript <script_path>
```

- 不可以在本地直接执行 Python 脚本（`python script.py` 或 `uv run python script.py`）
- 所有脚本调试、测试运行都必须通过 `dae runscript` 执行

# Markdown 格式规范

在生成 Markdown 文件时：

- 需要换行的连续信息应使用列表格式（- 或数字列表）
- 避免使用纯粹的连续行来表达应该分行的信息
- 代码块必须包含语言标识符（如 ```bash）
- 保持适当的空行间距
