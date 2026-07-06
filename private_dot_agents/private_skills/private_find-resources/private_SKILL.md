---
name: find-resources
description: 根据电影/剧集名称、关键词或链接，在 btdig.com 等磁链搜索引擎上查找尽量多的磁力链接资源，并整理保存到本地文件。Use when the user wants to find magnet links or torrent resources for movies, TV shows, or other media.
allowed-tools: WebFetch, WebSearch, Write, AskUserQuestion, Bash
---

# find-resources — 影视资源磁链查找助手

## 工作流程

### 第一步：确认信息（必须先问用户）

在开始搜索之前，使用 `AskUserQuestion` 向用户确认以下信息（根据用户已提供的内容，跳过已知项）：

1. **资源名称 / 关键词**
   - 中文名、英文名、或两者都有？
   - 年份（如果知道）？
   - 是电影还是剧集？

2. **集数范围**（仅剧集需要）
   - 要找哪几集？全集还是特定范围？

3. **画质偏好**（可多选）
   - 4K / 2160p
   - 1080p
   - 720p 或以下
   - 不限（全部收录）

4. **版本偏好**（可多选）
   - 普通版（WEB-DL）
   - HDR 版
   - 杜比视界（Dolby Vision）
   - 不限（全部收录）

5. **语音 / 字幕要求**
   - 国语配音、粤语、原声？
   - 中文字幕、简体、繁体？
   - 不限？

6. **保存文件名**
   - 默认：`{资源名称}_磁链汇总.txt`
   - 用户可以自定义

---

### 第二步：制定搜索策略

根据用户信息，确定搜索关键词组合：

- 主关键词：中文名 + 年份
- 备用关键词：英文名 + 年份
- 补充关键词：集数关键词（如 "第01集"、"E01"）

主要搜索来源（按优先级）：
1. `https://btdig.com/search?q={关键词}&p={页码}&order=0`
2. 用户直接提供的 btdig.com 链接

---

### 第三步：执行搜索

使用 `WebFetch` 抓取 btdig.com 搜索结果，提取 info hash 和标题。

**搜索策略：**
- 从第 0 页开始，每页 10 条结果
- 并行抓取多页（0-5 页同时请求）
- 如果总结果数 > 50，继续翻页直到覆盖所有结果
- 提取规则：40位十六进制 hash + 对应标题

**WebFetch 提示词模板（用于每页抓取）：**
```
List all torrent results from this btdig search page. For each result, provide:
- The 40-character info hash (hex string in the URL after /search/ or in magnet links)
- The full title

Format each as: HASH | TITLE
Only include results related to [资源名称].
```

**如果用户提供了直接链接：**
直接访问该链接，提取页面上的磁力链接（magnet: 开头）或 info hash。

---

### 第四步：过滤与整理

根据用户偏好过滤结果：

- 按画质筛选（2160p / 1080p / 720p）
- 按版本筛选（HDR / DV / 普通）
- 按集数范围筛选（检查标题中的集数信息）
- 去重（相同 hash 只保留一条）

---

### 第五步：生成磁力链接

将每个 info hash 构造为完整磁力链接：

```
magnet:?xt=urn:btih:{HASH}&dn={URL编码的标题}&tr=udp://tracker.openbittorrent.com:80&tr=udp://tracker.opentrackr.org:1337/announce&tr=udp://open.demonii.com:1337/announce&tr=udp://tracker.torrent.eu.org:451/announce
```

---

### 第六步：保存到本地文件

使用 `Write` 工具将结果保存到用户桌面或指定路径。

**文件格式模板：**

```
{资源名称} - 磁链汇总
来源：btdig.com
更新日期：{今天日期}
共收录 {N} 条磁链
画质筛选：{用户偏好}
============================================================

【推荐下载 - 全集/完整资源】（如有）
------------------------------------------------------------
[标题说明]
magnet:?xt=urn:btih:...

【第 XX-XX 集】
------------------------------------------------------------
[标题说明]
magnet:?xt=urn:btih:...

...（按集数分区，从小到大排列）

============================================================
注意：部分集数可能暂无资源，建议使用全集资源。
```

---

## 注意事项

- btdig.com 有频率限制，直接用 Python/curl 抓取会被 429 拒绝，务必通过 WebFetch 工具访问
- 如果某页 WebFetch 被拒绝（返回拒绝回应），换一个提示词重试，或跳到下一页
- 每次并行请求不超过 3 页，避免同时请求过多
- 如果 btdig.com 结果不够，可以尝试以下备用 URL 格式：
  - `https://btdig.com/search?q={英文名}+{年份}&p=0&order=0`
  - `https://btdig.com/search?q={中文名}&p=0&order=0`
- 搜索完成后告诉用户：总共找到几条、覆盖哪些集数、文件保存在哪里

## 调用示例

用户说：
- `/find-resources 太平年`
- `/find-resources 请帮我找 Severance S02 的资源`
- `/find-resources https://btdig.com/xxx/...`
- `/find-resources 我想找《繁花》全集 4K 的磁链`

都应触发此 skill，先确认细节再开始搜索。
