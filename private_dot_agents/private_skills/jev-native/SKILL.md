---
name: jev-native
description: Use Jev to execute bounded native macOS GUI steps in applications such as Kindle, Calculator, TextEdit, and Finder. Suitable for short sequences of visible labeled clicks, text entry, and scrolling. Uses the local accessibility tree and OCR; stops on app changes, uncertain targets, and final sending/deleting/purchasing actions. Prefer it when the user asks for Jev or faster native computer use; retain ordinary computer use for unsupported controls and verification.
---

# Native macOS Jev

This executor is separate from `jev-browser` and from Codex's built-in computer-use tools. It is installed on each configured Mac at `~/.local/share/jev-native`, using the pinned upstream `awlevin/typesafe-computer-use` plus this local adapter. Verified upstream revision: `cc7b5066ae1a07b5e3182e8f87a9b5b6dfdcffc1`. Do not run the upstream `clicker --act` directly: that skips application guards and the configured writer.

## Use

Read-only checks:

```bash
~/.agents/skills/jev-native/scripts/jev-native doctor
~/.agents/skills/jev-native/scripts/jev-native status
```

Open/focus the exact target app with the existing computer-use tool, observe its current state, then run a short goal:

```bash
~/.agents/skills/jev-native/scripts/jev-native run --app Calculator \
  --goal 'Calculate 17 multiplied by 23. Stop when the result is visible.' --steps 12
```

`--app` must match the foreground app name from `doctor`. The executor never activates another app; switching focus aborts the run. Use one controller at a time on the same Mac. Ctrl-C or moving the pointer to the top-left screen corner stops the loop. Native actions happen in the foreground, so user interaction can interrupt them.

Run one meaningful verification after completion using the normal computer-use tool or a read-only app API. `done` means Jev judged completion, not that verification passed. Confirm the actual display, file, or app state. On uncertainty, refusal, foreground change, unsupported controls, or a final-action stop, continue through ordinary computer use instead of repeatedly retrying Jev.

## Scope

- Short sequences of clicks on observed, visible accessibility controls; no coordinate guesses or hidden controls.
- Ordinary focused text fields use OneAPI and AX value insertion with exact read-back. Unsupported AX insertion stops; use normal computer use for those fields.
- Scrolling and Escape are supported. Return is omitted because it can submit a form unexpectedly.
- Final sending, publishing, purchasing, submitting, or deleting labels stop the runner. This is a conservative label check, not a complete permission system: keep the goal within the user's actual authorization and let the supervising agent handle consequential final actions.
- The selected app must be on the main display. Multi-app workflows are split into separate bounded goals. Menus, icon-only controls, complex canvases, drag operations, and app-specific failures may require ordinary computer use.

For Kindle, start with selecting a known book, opening its notes panel, and navigating to export. Stop before final sending. Preserve existing user notes and files. Verify exported HTML or other output independently. App waiting time cannot be removed by a faster decision model.

## Credentials and privacy

Reuses the TypeSafe key from service `codex-jev-browser`, account `TYPESAFE_API_KEY`, in this Mac's login keychain. It also reuses `jev-browser`'s OneAPI configuration. Never print keys or persist them in the repository. Keychain reads over SSH may require launching from the logged-in desktop session.

The local OCR and accessibility text, goal, and recent actions reach TypeSafe. The text helper receives the goal, focused-field description/value, and recent actions through OneAPI. No screenshots are uploaded by this adapter, and the upstream Anthropic final-answer call is disabled.

Private local artifacts live in `~/.local/state/jev-native/runs/`: phase timings, outcome, selected actions, and screenshots masked to the target window and its menu strip. They can contain application text; do not share them without a relevant user request. `status` displays only app, counts, outcome, and timing summaries for the last five runs.

## Requirements

`doctor` must report Accessibility and Screen Recording available in the actual launch context. Handle macOS permission prompts normally; do not change TCC databases or disable protections. A green `doctor` is configuration readiness, not task verification.

OCR is refreshed each step because small text changes can evade the upstream image cache. Default post-action settling is 0.3 seconds; `--delay` accepts 0.1–5 seconds for apps that need longer. Always compare complete task time and success, not only Jev API latency. Keep the pinned upstream version unless a specific update is requested or needed.
