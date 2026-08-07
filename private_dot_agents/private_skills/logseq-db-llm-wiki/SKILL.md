---
name: logseq-db-llm-wiki
description: Build and maintain the user's Logseq 2.x DB-mode LLM Wiki. Use when asked to ingest files, URLs, or Obsidian knowledge into Logseq; organize personal Journal or Inbox captures, including untagged valuable notes discovered during an explicit maintenance run; create or update Source, Topic, Entity, Project, or Output nodes; manage Assets, provenance, content-hash deduplication, and anti-backflow rules; expand Output pages into directly usable runbooks or reports; or back up and validate these workflows. Use logseq-maintain-library instead for graph-wide cleanup, duplicate-page audits, Home, or 知识库总览 maintenance.
---

# Logseq DB LLM Wiki

Maintain one local-first knowledge system whose runtime truth is the Logseq DB graph.

## Boundaries

- Treat the graph returned by `logseq.App.getCurrentGraph` and the matching CLI graph as runtime truth.
- Treat `~/Logseq/graphs/logseq-graph` as the expected DB graph root only after live verification. Do not confuse it with the legacy file-graph repository at `/Users/liaoxingyi/logseq-graph`.
- Treat Logseq DB as the only knowledge source of truth. Markdown exports, Obsidian, search indexes, and Git archives are read-only donors or rebuildable derivatives.
- Never use Git, rsync, or Markdown merge as a SQLite or Logseq transaction merge protocol.
- Keep Logseq Sync disabled unless the user starts a separate sync task. The retired Git auto-sync plugin must not be re-enabled.
- Do not modify Home, `知识库总览`, unrelated pages, or plugins unless explicitly requested.

## Load References

- Read [references/schema.md](references/schema.md) before creating classes, properties, or deciding whether content is a Source, Topic, Entity, Project, or Output.
- Read [references/obsidian-migration.md](references/obsidian-migration.md) before importing or reconciling an Obsidian vault.
- Read [references/output-authoring.md](references/output-authoring.md) before creating, expanding, or revising an Output.
- Read [references/capture-workflow.md](references/capture-workflow.md) before organizing Journal/Inbox notes, processing `待整理`, or scanning for valuable untagged blocks.

## Non-Negotiable Rules

1. Inspect the live graph, API health, CLI graph, current counts, sync state, and related Git worktrees before writing.
2. Create a fresh CLI-consistent DB backup before every multi-page batch. Run `PRAGMA integrity_check` against the backup with immutable/read-only access.
3. Record the baseline `graph validate` count and categories. Do not run `--fix` on the live graph.
4. Use Logseq CLI or the local HTTP API. Never edit `db.sqlite`, client-op databases, or the active `assets/` directory directly.
5. Read the API token locally without printing it, logging it, or placing it in prompts or reports.
6. Write one page or one small batch at a time and reread immediately. Stop on latency, timeout, or ambiguous output.
7. Keep raw private content out of broad scans and user-visible reports. Report counts, hashes, titles needed for navigation, and redacted structure.
8. Preserve existing classes, properties, aliases, inbound references, and structural pages. Reuse an existing page only after checking its role.
9. Make every ingest idempotent through `Origin`, `Source Path`, `Content Hash`, target title, and Asset checksum.
10. Scan canonical files for high-confidence credentials before Asset import. A redacted page body does not make an unchanged Asset safe.

## Establish Baseline

1. Confirm Logseq, port `12315`, and the current graph through the local API.
2. Confirm the CLI reaches the same graph and capture page-like, UUID, and Asset counts.
3. Capture `graph validate` count and categories without printing private entity bodies.
4. Capture sync state. Expect `ws-state=stopped`, no graph id, and no remote transaction unless the user explicitly enabled sync elsewhere.
5. Capture Git status for the Obsidian donor, legacy graph repository, and any retired auto-sync source repository that is in scope.
6. Create and verify a new backup before writes.

## Ingest One Source

1. Read the selected material and any maintained source/topic/entity pages that explain it.
2. Compute SHA-256 and canonical source path before creating anything.
3. Run a high-confidence secret scan. If a canonical file contains a real token, password, cookie, private key, or credential value, pause and choose an explicit policy: exclude it, create a traceable redacted derivative, or preserve the original only with the user's informed authorization.
4. Query existing pages by title, `Source Path`, and `Content Hash`; query Assets by checksum.
5. Import the approved immutable original or redacted derivative with `logseq upsert asset --path ... --target-page ...`. Never copy directly into the active Asset directory.
6. Create or reuse the Source instance and set the `Source` class.
7. Set the primary Asset plus `Origin`, `Source Path`, `Content Hash`, and explicit Topic/Entity/Project relations. Hash the file that was actually imported.
8. Write a concise Chinese summary, important claims, source notes, redaction status when applicable, and navigable relations.
9. Reread the Source, Asset entity, on-disk Asset hash, and every relation before marking the ingest complete.

## Batch Migration

Follow [references/obsidian-migration.md](references/obsidian-migration.md). Build an include/exclude manifest first, then migrate two or three coherent clusters per batch. Recheck hashes immediately before each Asset upsert even when the initial inventory found no duplicate.

## Organize Personal Captures

Follow [references/capture-workflow.md](references/capture-workflow.md). Process explicitly tagged pending blocks first, then scan the bounded Journal/Inbox window for untagged high-value notes. Preserve each original block, write `整理到` only after its destination is verified, and advance `上次整理扫描` only after all candidates in the window are resolved. Never run this as an unrelated background mutation.

## Maintain Outputs

Follow [references/output-authoring.md](references/output-authoring.md). An Output must be directly useful in Logseq; a four-line catalog card plus an Asset is not a finished Output. Preserve a concise first screen, then add structured, collapsible detail from the canonical source.

## Verify Every Batch

- Confirm every planned page exists once with the expected class and properties.
- Confirm `source SHA-256 = DB Asset checksum = on-disk Asset SHA-256` and byte sizes match.
- Confirm every node-valued property resolves to a real page.
- Confirm page, UUID, block, and Asset deltas match the plan.
- Confirm `graph validate` did not gain errors.
- Confirm the app/API remains responsive and sync remains unchanged.
- Confirm donor and legacy Git statuses have no unintended changes.
- Navigate to representative pages in the UI. If Electron accessibility text or screenshots are stale, report that limitation and use DB/API tree readback as the persistence proof.

## Failure Handling

- A write times out: stop, query actual state, and continue only from the verified boundary.
- CLI returns `invalid-options`: treat it as no-write until a fresh read proves otherwise; correct the option and retry idempotently.
- A title contains `/`: use a readable Logseq title without `/`, but preserve the canonical `Source Path` and `Content Hash`.
- A target title already exists: inspect tags, ident, schema role, content, aliases, and inbound references before reusing it.
- Asset import succeeds but relation writing fails: keep the verified Asset, reread the page, and resume only the missing relation step.
- UI shows stale content: do not restart or rewrite based on the screenshot alone. Verify with CLI/API first.

## Final Report

Report the backup path, included and excluded sets, created/reused/skipped counts, Asset hash verification, relation verification, entity deltas, validation result, UI/API checks, sync state, Git state, and anything not completed.
