---
name: grill-with-docs
description: Interview a repository about a fuzzy, single-session change and record settled domain vocabulary and durable architectural decisions.
---

# Grill with Docs

Use this skill only when the user explicitly invokes `/grill-with-docs` or `$grill-with-docs`. It is for requirements discovery and shared understanding before implementation.

## Dependencies

Load the `grilling` skill for the interview loop and `domain-modeling` for glossary and ADR discipline. If either dependency is unavailable, say so and preserve the interview cadence; do not silently pretend that documentation was written.

## Workflow

1. Inspect the repository before asking questions. Answer anything the codebase can establish from code, tests, configuration, and existing docs.
2. Establish the change boundary and identify ambiguous terms, actors, states, invariants, and externally visible behavior.
3. Ask a small round of focused questions (with a recommended answer when evidence supports one), then wait for the user's answers. Continue in rounds until the shared understanding is stable. Do not dump all questions at once.
4. When a project term is resolved, write it immediately to the appropriate glossary. Use `CONTEXT-MAP.md` when present to select a context; otherwise use root `CONTEXT.md`. Keep entries short: term plus a tight definition. Do not put implementation plans, acceptance criteria, or scratch notes in the glossary.
5. Record a decision as an ADR under `docs/adr/` only when all three conditions hold: it is hard to reverse, surprising without context, and involves a real trade-off. Create the directory lazily. Include the decision, context, alternatives, and consequences.
6. Keep ordinary answers in the conversation. Do not manufacture ADRs for routine choices, and do not claim that files changed unless you verified them on disk.

## Boundaries

This skill ends with shared understanding and documentation. Hand the resulting conversation to a specification or implementation workflow when the user is ready. Do not implement code, create tickets, or publish changes unless separately requested.
