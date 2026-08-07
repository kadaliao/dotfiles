# Output Authoring

## Definition

An Output is a durable artifact for a specific question or task: a report, implementation plan, comparison, decision, tutorial, or runbook. It is not the evolving canonical model of a subject; that belongs in Topic.

## Page Shape

Keep a concise first screen with:

- problem or question;
- conclusion or decision;
- critical constraints;
- evidence pointer and canonical Asset.

Then add a stable, collapsible detail section. For the current migrated pages, use the marker `详细内容（Obsidian Output v1）` exactly once. Organize roughly 12-30 high-signal blocks into six useful sections chosen from:

- background and applicability;
- core reasoning or decision;
- procedure, implementation, or main answer;
- validation and expected results;
- constraints, risks, security, and rollback;
- evidence, related Topics, and follow-up work.

Adapt section names to the artifact. Do not force irrelevant headings.

## Content Rules

- Preserve commands, configuration shape, thresholds, decision conditions, and failure signatures needed to use the Output.
- Replace tokens, keys, cookies, passwords, and credential values with explicit placeholders.
- Retain internal paths or addresses only when necessary for the private local runbook; remove unrelated identity details.
- Secret-scan the canonical Markdown before Asset import. Keep it unchanged as full-fidelity evidence only when no high-confidence credential is present or the user explicitly approved that local retention policy.
- Do not mechanically copy YAML frontmatter or every Markdown line into blocks.
- Do not stop at another four-sentence summary.

## Idempotency

1. Read the actual page block tree.
2. Confirm the first-screen summary and Asset/property metadata.
3. Search for the stable detail marker.
4. If absent, insert one nested block tree and reread it.
5. If present, update only the intended section; never append a second marker.
6. Verify marker count, section count, collapsed state, block delta, and retained summary/property blocks.

## Versioning

Preserve an Output as the delivered snapshot. When a later artifact replaces it, mark the relationship explicitly rather than silently rewriting history. Update a Topic separately when the new Output changes the long-term synthesis.
