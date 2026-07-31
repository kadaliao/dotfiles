---
name: english-learning
description: Correct or translate the user's prompt into natural English while preserving coding-agent work. Use when the user sends /english commands, asks to enable English learning, wants their prompt translated or corrected first, wants responses in English, or when /Users/liaoxingyi/.agents/state/english-learning.json has default_enabled set to true.
---

# English Learning

Help the user learn practical English without slowing down coding work. Treat this as a lightweight prompt-polishing layer, not as a replacement for the requested task unless `translate` mode is active.

## Activation

On a new session, read `/Users/liaoxingyi/.agents/state/english-learning.json` before answering the first normal user request. Treat this file as runtime configuration, not conversation memory or project archive. Do not skip this read after loading `/Users/liaoxingyi/.agents/memories/profile.md`.

Use the state file as the global default state. If the file is missing, unreadable, or invalid, explicitly fall back in memory to:

```json
{
  "default_enabled": false,
  "mode": "work",
  "level": "light"
}
```

Do not create or repair the state file during normal session startup. Only write it when the user runs a `/english default ...` command or explicitly asks to change the global default.

If `default_enabled` is true, apply this skill immediately to normal user requests using the configured `mode` and `level`.

Keep two layers of state:

- Global default: read from and written to `/Users/liaoxingyi/.agents/state/english-learning.json`.
- Session override: remembered only in the current conversation after `/english on`, `/english off`, `/english mode ...`, or `/english level ...`.

If global default is off and there is no session override, do not rewrite normal user prompts. On the first assistant reply in a new session, optionally append exactly one short reminder:

`English mode available: /english on`

## Commands

Treat `/english` commands as control-plane instructions. Do not add the English rewrite block to the response for these commands.

Supported commands:

- `/english on`: enable this skill for the current session with the current global or last session mode and level.
- `/english off`: disable this skill for the current session.
- `/english mode work|english|translate`: set the current session mode.
- `/english level light|medium|strict`: set the current session level.
- `/english default on|off`: update `default_enabled` in the global state file.
- `/english default mode work|english|translate`: update global `mode`.
- `/english default level light|medium|strict`: update global `level`.

Also accept clear Chinese equivalents such as "开启英语模式", "关闭英语模式", "切到英文回答", "只翻译", "强度调严格", or "全局默认开启". Prefer the canonical command names in replies.

For command responses, reply briefly, for example:

- `English mode is on for this session: work + light.`
- `Session English mode: english.`
- `Global default enabled for future sessions.`

## Modes

Use one of three modes:

- `work`: Default work mode. Start with a natural English rewrite of the user's natural-language intent, then complete the task normally. For this user, normal task replies are usually Chinese unless the current instruction or project context says otherwise.
- `english`: English immersion work mode. Start with the rewrite, then complete the task mostly in English unless a higher-priority instruction requires another language.
- `translate`: Translation tool mode. Only translate or correct the user's natural-language input. Do not execute the underlying task.

Language priority:

1. The user's latest explicit language instruction.
2. Repository, file, UI, or documentation language conventions.
3. This skill's current mode.

Never let English practice break code, commands, paths, API names, quoted logs, diffs, configuration, or project consistency.

## Rewrite Format

When active for a normal user request, put the rewrite at the very top:

> 💬 **EN:** Help me design a database schema for user subscriptions.

Then leave one blank line and continue according to the selected mode.

Use only one rewrite block per assistant reply. Keep it short in `work` and `english` modes.

## Levels

- `light`: Provide one natural English version only. Do not explain mistakes.
- `medium`: Provide the English version. If the original has a clear grammar issue, Chinglish phrasing, or tone problem, add one very short note.
- `strict`: Provide the English version, then add up to three concise notes about key errors, tone, or better alternatives.

In `work` mode, keep `medium` and `strict` notes short so the coding task remains the main output.

## What To Rewrite

Rewrite only the user's natural-language intent.

- If the user writes Chinese, translate it into natural English.
- If the user writes English, correct or lightly polish it. If it is already natural, keep it unchanged or make a minimal improvement.
- Preserve code blocks, inline code, file paths, commands, logs, errors, stack traces, diffs, JSON/YAML/TOML, identifiers, URLs, and quoted source text.
- For mixed inputs, rewrite the outer request and leave quoted technical material intact.
- For long inputs, multi-section specs, or pasted context, summarize the user's intent as one natural English sentence in `work` and `english` modes.
- In `translate` mode, translate or correct the natural-language parts more completely, while still preserving technical material.

Example mixed input:

```text
这个报错怎么修
TypeError: Cannot read properties of undefined
```

Expected rewrite:

> 💬 **EN:** How can I fix this error?
