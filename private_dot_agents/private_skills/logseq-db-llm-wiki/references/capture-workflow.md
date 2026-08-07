# Personal Capture Workflow

Use this workflow when the user asks to organize recent notes, process `待整理`, or maintain the LLM Wiki in a way that includes personal captures.

## Data Model

- Journal and Inbox blocks are the original personal record. Preserve them in place.
- `待整理` is the explicit queue class.
- `整理到` is a node-valued `default` property with cardinality `many`. It records verified Topic, Project, or Output destinations on the original block.
- `上次整理扫描` is a single `date` property on the `LLM Wiki` page. Its value must reference a Journal entity, not a date string.
- Do not create a Source for every personal note. Promote a substantial, frozen personal document to Source only when provenance or an immutable artifact matters.

## Trigger And Scope

- Run only during an explicit request such as `整理最近内容`, processing the queue, or an LLM Wiki maintenance task whose scope includes recent captures.
- Do not run as a silent background job or during unrelated graph work.
- Always inspect the live graph, create and verify a backup, and capture the validation baseline before a write batch.

## Candidate Collection

1. Query every block tagged `待整理` that does not already have `整理到`. These are explicit candidates regardless of age.
2. Read `上次整理扫描` from `LLM Wiki`.
3. If there is no cursor, scan at most the most recent seven calendar days. Otherwise scan the cursor day again plus later Journal days, so edits made later on the same day are not missed.
4. Scan Inbox blocks updated within that same date window. If update timestamps are unreliable after migration, inspect the small Inbox page and skip blocks already linked through `整理到`.
5. Deduplicate candidates by block id or UUID. Read enough parent, child, and page context to judge the note without exposing private text in reports.

## Confidence Policy

Classify each candidate before writing:

- **High confidence:** a self-contained reusable insight, durable decision, problem-and-solution record, stable personal preference, or project fact that clearly belongs in an existing or unambiguous new Topic, Project, or Output. Organize it automatically.
- **Medium confidence:** potentially valuable, but the destination, meaning, or intended durability is unclear. Report a short redacted candidate list and wait for the user. Do not create a Topic or set `整理到` yet.
- **Low confidence:** routine status, pure TODO, transient reminder, duplicate fragment, context-free sentence, or sensitive fragment. Leave it untouched and do not surface its private content.

Prefer updating an existing canonical node over creating a near-duplicate. Topic is evolving synthesis; Project is goal-oriented context; Output is a task-specific durable deliverable.

## High-Confidence Write

1. Create or update the canonical Topic, Project, or Output in a small batch.
2. Add an exact block reference to the destination so the original wording remains reachable.
3. Set `整理到` on the original block to the verified destination node or nodes.
4. Reread both sides and confirm the block reference and node-valued property resolve correctly.
5. Treat a `待整理` block with a verified `整理到` value as handled. Keep the tag as trace unless the user explicitly asks to remove handled queue tags.

Never rewrite, move, or delete the original block merely to make it cleaner. Do not add Source/Asset machinery to an ordinary personal capture.

## Cursor Rules

- Advance `上次整理扫描` only after every explicit and passive candidate in the window is resolved: organized, deliberately ignored as low confidence, or decided by the user.
- Do not advance while medium-confidence candidates are awaiting a decision or after any ambiguous/failed write.
- Set the cursor to the latest fully handled Journal day by entity reference. Reread `LLM Wiki` to verify the date relation.
- The cursor is an optimization, not the only safety net: the global unresolved `待整理` query always runs first.

## User Report

Report counts rather than private note text: explicit candidates, passive candidates, auto-organized items, items left untouched, and unresolved medium-confidence candidates. Name created or updated destinations only when that is useful and non-sensitive. Include the cursor date, backup path, validation delta, and any failed readback.
