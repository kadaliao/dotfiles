---
name: volcano-seedance
description: 使用火山方舟 Seedance 生成视频、查询任务和下载成片。用户要求 Seedance 或火山引擎视频生成时，优先使用现有 macOS 钥匙串 API key 与 curl；无需专用 CLI 或浏览器登录。
---

# 火山方舟 Seedance

用户在火山引擎已有充值账户。默认通过 curl 请求 API；只有用户明确指定网页操作，或已确认 API 无法完成所需能力时再使用浏览器。浏览器未登录、ARK_API_KEY 未设置、arkcli 未安装，都不能据此判定没有 API 凭据。

## 凭据

本机和 mm 使用 macOS 登录钥匙串服务 `volcengine-ark-cat-wallpaper-seedance`，账户 `liaoxingyi`。
按需读取：`security find-generic-password -s volcengine-ark-cat-wallpaper-seedance -a liaoxingyi -w`。
将输出捕获到变量，禁止打印 key、开启 shell tracing、写入请求 JSON、日志或仓库；用完 unset。钥匙串访问失败时报告实际错误，不新建 key、不擅自改账户配置。

## 已验证的 API 路径

- Base URL: `https://ark.cn-beijing.volces.com/api/v3`
- 创建：`POST /contents/generations/tasks`
- 查询：`GET /contents/generations/tasks/{id}`
- Authorization: `Bearer <key>`；Content-Type: `application/json`
- 已成功使用的模型 ID：`doubao-seedance-2-5-260628`。新版本、价格与参数范围以当前官方文档为准。

请求示例（只在用户已要求生成时提交）：

```json
{"model":"doubao-seedance-2-5-260628","content":[{"type":"text","text":"用户的视频提示词"}],"ratio":"9:16","resolution":"1080p","duration":6,"generate_audio":false,"watermark":false}
```

用 `curl --data-binary @request.json` 发送请求，并立即保存创建响应中的 id。创建 POST 不自动重试；超时或响应不明确时先查已有任务，避免重复收费。查询同一个 id，直到 succeeded 或 failed；状态轮询可间隔 20–30 秒。成功响应的 `content.video_url` 是下载地址，`usage.total_tokens` 是实际用量。失败时保留错误，不自动重复生成收费任务。

分辨率、时长、音频等按当前用户要求配置；上述示例不是全局默认。用户要求的 4K 与实际可用档位不同时要说明，不能把 1080p 冒充 4K。生成前说明本次设置及可核实费用，遵循用户预算。价格随日期变化，不沿用过期折扣；估算费用与最终账单扣费分开表述。

成片下载到当前任务 outputs，使用 ffprobe 核验实际分辨率、时长和轨道，再给出可点击文件链接。仅进行接入验证时查询已有任务，不创建收费任务。

官方接口文档：https://www.volcengine.com/docs/82379/1520757
官方价格：https://www.volcengine.com/docs/82379/1544106
