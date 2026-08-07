# Obsidian Migration

## Donor Boundary

- Treat `/Users/liaoxingyi/Obsidian` as a read-only donor.
- Read its `AGENTS.md`, `wiki/index.md`, `wiki/overview.md`, and `wiki/log.md` before classifying content.
- Treat `raw/` as evidence and `wiki/` as maintained synthesis.
- Do not edit the vault during migration.

## Prevent Logseq Backflow

Exclude content when any of these is true:

- the Source filename matches `wiki/sources/logseq-*.md`;
- `source_files` points to `logseq/pages/...` or another Logseq export path;
- Git history or the raw snapshot proves the content originated in Logseq;
- a Topic, Entity, or Output is supported only by excluded Logseq-derived material.

For mixed-source pages, migrate only claims supported by included native sources. Preserve uncertainty rather than copying unsupported synthesis.

## Build the Manifest

Classify every candidate as include, exclude, reuse, or needs-review. Record:

- donor type and relative path;
- title and normalized Logseq title;
- `source_files`, topics, entities, and referenced local attachments;
- Git introduction evidence when provenance is ambiguous;
- SHA-256 and byte size;
- high-confidence credential scan result and any redaction policy;
- target page, Source Path, Content Hash, and Asset checksum matches.

Exclude `wiki/index.md`, `overview.md`, `log.md`, `maintenance/`, `.obsidian/`, skills, generated promotional assets, and unreferenced files as standalone knowledge pages. Use them only for classification and navigation.

## Execute

1. Reuse an already imported cluster when its path and hash match.
2. Import two or three coherent Source clusters per batch.
3. Secret-scan the canonical file. Do not import a high-confidence credential unchanged without an explicit policy and authorization.
4. Import the approved canonical file or traceable redacted derivative as the primary Asset.
5. Import only referenced local images or supporting files; check checksum again immediately before upsert.
6. Create or reuse Topic and Entity pages, preserving existing structural roles.
7. Import durable `wiki/outputs` pages as Output instances with their approved canonical Markdown or redacted derivative as Asset.
8. Update the `LLM Wiki` page with lightweight manual Sources, Topics, Entities, and Outputs lists. Do not copy the donor index or log.
9. Run the complete batch verification before continuing.

## Audit

Keep a machine-readable manifest and append-only execution log in task-local `work/` when a migration spans multiple batches. Do not place these temporary artifacts in the graph or donor vault.
