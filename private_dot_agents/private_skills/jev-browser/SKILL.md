---
name: jev-browser
description: Use Jev Ultrafast on this Mac for short Chrome workflows involving ordinary HTML controls, searches, and filters. Use when asked to accelerate browser computer use with Jev. Requires a configured TypeSafe key and Chrome remote debugging. Does not replace native macOS computer use or visual/canvas workflows.
---

# Jev browser

This is an optional browser executor, separate from Codex's built-in computer use. The runtime is installed at `~/.local/share/jev-ultrafast` on each configured Mac. Run the commands on the host whose Chrome should be controlled.

## Check and configure

```bash
~/.agents/skills/jev-browser/scripts/jev doctor
```

If the TypeSafe key is absent, have the user run the following in **Terminal on the target Mac**. It takes hidden input and stores the key in the macOS login keychain. Never request the key in chat, print it, or pass it on a command line.

```bash
~/.agents/skills/jev-browser/scripts/jev setup-key
```

The text helper uses the existing `oneapi` provider in `~/.pi/agent/models.json`, model `deepseek-v4-flash`. Explicit `TEXT_MODEL_API_KEY`, `TEXT_MODEL_BASE_URL`, and `TEXT_MODEL` environment variables override it as a set. Keys are loaded only into the process environment. Browser state is sent to TypeSafe; text field context is sent to the configured text model.

For Chrome connection diagnostics:

```bash
~/.local/share/jev-ultrafast/.venv/bin/browser-harness --doctor
```

If required, the user enables **Allow remote debugging for this browser instance** at `chrome://inspect/#remote-debugging`. Preserve ongoing browser work; do not restart Chrome or kill existing computer-use services. Do not enable recordings without the user's request.

## Run a bounded goal

```bash
~/.agents/skills/jev-browser/scripts/jev run \
  --url 'https://example.com' \
  --goal 'Open the More information link and stop when its destination is visible.'
```

The executor creates its own background tab in the existing Chrome profile and keeps that tab open for independent inspection. It prints its tab id, final URL, visible text, elapsed time, and model usage. Default limit: 20 decision cycles. Use `--max-steps N` for a different bounded budget. `--close` closes only its own tab after completion.

Use it for narrow, authorized web goals with ordinary HTML/ARIA controls. Keep task scope and final submission boundaries explicit in the goal. An authorization to browse does not authorize sending messages, buying, publishing, or deleting. Do not hand it a goal that includes an unauthorized final action.

Verify the actual outcome in the retained tab; `done` is the model's judgment, not proof of task success. Stop on `blocked`, budget exhaustion, missing credentials, unsupported controls, or repeated failure. Use the existing computer-use tool for native applications, image-based inspection, canvas, uploads, popup tabs, frames, shadow roots, or ambiguous/risky steps. Never run two controllers against the same tab simultaneously.

Installing this skill does not reroute an active task. For an existing task, explicitly read this SKILL.md and invoke the executor at a suitable boundary. Keep native computer use available.

Official sources: https://github.com/browser-use/jev-ultrafast and https://docs.typesafe.ai/agent-skill

## See whether Jev actually ran

Run `~/.agents/skills/jev-browser/scripts/jev status` on the same Mac. It displays the last five runs, action counts, completed model requests, agent-loop time, and total command time (including initialization and cleanup). Records start with this version; no record cannot disprove an older invocation. Native Kindle actions cannot appear here because this executor only controls Chrome. A `done` record is not independent verification or a speed comparison. Failed/in-flight model requests may not be included in completed request counts.

The local log `~/.local/state/jev-browser/runs.jsonl` stores timings/counts only, without goals, page content, URLs, or credentials. To compare speed, use the same task and success criteria with both executors; report total time separately from model-loop time.

For native applications such as Kindle and Calculator, use [jev-native](../jev-native/SKILL.md) when installed. Keep browser and native run statistics separate.
