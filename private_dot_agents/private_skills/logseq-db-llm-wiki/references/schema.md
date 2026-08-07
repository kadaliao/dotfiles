# LLM Wiki Schema

## Responsibilities

| Class | Responsibility | Maintenance rule |
| --- | --- | --- |
| `Source` | Traceable evidence record backed by an immutable primary Asset | Add new evidence; do not rewrite the original |
| `Topic` | Current synthesis across one or more Sources | Evolve as evidence changes; preserve contradictions |
| `Entity` | Named person, organization, product, tool, or place | Keep identity facts and relationships concise |
| `Project` | Goal-oriented work with state and related knowledge | Reuse existing project semantics; do not create duplicates |
| `Output` | Durable answer, report, plan, comparison, or runbook for a specific task | Preserve the delivered snapshot and mark later replacements |

## Shared Properties

Use existing properties by ident/name; never create a second property with a near-duplicate label.

For `Source` and `Output`, use:

- built-in `Asset`: canonical primary file;
- `Topics`, `Entities`, `Projects`: node-valued, cardinality many;
- `Origin`: single value such as `Obsidian`, `Web`, or `Local file`;
- `Source Path`: canonical donor path or stable source locator;
- `Content Hash`: lowercase SHA-256 of the canonical source file.

Import additional referenced files as Assets only when the maintained page actually depends on them. Reference them from content blocks; do not replace the primary Asset or invent duplicate Source records.

## Relations

- Make Source-to-Topic/Entity/Project relations explicit through node properties.
- Let linked references provide the reverse direction unless a real workflow needs another property.
- Keep uncertain relationships in prose with an uncertainty marker instead of asserting a typed relation.
- Preserve `supersedes`, `superseded-by`, or equivalent version relationships when an Output replaces another artifact.

## Topic Versus Output

- Use a Topic for question-independent, continuously evolving knowledge.
- Use an Output for a concrete task delivered at a point in time.
- Allow an Output to cite Topics and Sources; allow lessons from the Output to update a Topic later.
- Keep Topics compact. Make Outputs directly usable without requiring the reader to open the Asset.

## Naming

- Prefer human-readable titles in the user's working language.
- Avoid `/` in Logseq titles; preserve the donor path separately.
- Reuse an existing page only after verifying its structural role and inbound references.
- Never depend on database ids being stable across backups or restores.
