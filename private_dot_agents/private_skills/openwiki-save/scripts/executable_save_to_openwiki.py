#!/usr/bin/env python3
"""Stage a private session note and ask OpenWiki to synthesize it."""

from __future__ import annotations

import argparse
import datetime as dt
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import stat
import subprocess
import sys
from typing import Any


MAX_INPUT_BYTES = 25 * 1024 * 1024
VALID_SOURCE = re.compile(r"^[a-z][a-z0-9-]{0,31}$")


class SaveError(RuntimeError):
    pass


def utc_now() -> dt.datetime:
    return dt.datetime.now(dt.UTC)


def clean_single_line(value: str, field: str) -> str:
    cleaned = " ".join(value.split())
    if not cleaned:
        raise SaveError(f"{field} must not be empty")
    return cleaned


def yaml_string(value: str) -> str:
    return json.dumps(value, ensure_ascii=False)


def short_hash(value: str, length: int = 16) -> str:
    return hashlib.sha256(value.encode("utf-8")).hexdigest()[:length]


def resolve_session_id(args: argparse.Namespace, title: str) -> tuple[str, str]:
    explicit = args.session_id or os.environ.get("OPENWIKI_SESSION_ID")
    if not explicit and args.source == "codex":
        explicit = os.environ.get("CODEX_THREAD_ID")
    if explicit:
        return clean_single_line(explicit, "session id"), "provided"

    local_date = dt.datetime.now().astimezone().date().isoformat()
    return f"{args.source}-{local_date}-{short_hash(title, 12)}", "fallback"


def read_input(path: Path) -> str:
    try:
        size = path.stat().st_size
    except FileNotFoundError as exc:
        raise SaveError(f"input file does not exist: {path}") from exc
    if size > MAX_INPUT_BYTES:
        raise SaveError(f"input exceeds {MAX_INPUT_BYTES} bytes: {path}")
    content = path.read_text(encoding="utf-8").strip()
    if not content:
        raise SaveError("input file is empty")
    return content


def find_existing_note(inbox: Path, prefix: str) -> Path | None:
    matches = sorted(inbox.glob(f"{prefix}-*.md"))
    return matches[0] if matches else None


def note_path(inbox: Path, source: str, session_id: str, title: str) -> Path:
    prefix = f"{source}-{short_hash(session_id)}"
    existing = find_existing_note(inbox, prefix)
    if existing:
        return existing
    slug = re.sub(r"[^a-z0-9]+", "-", title.lower()).strip("-")[:48]
    if not slug:
        slug = "session"
    return inbox / f"{prefix}-{slug}.md"


def render_note(
    *,
    body: str,
    completeness: str,
    mode: str,
    session_id: str,
    session_id_kind: str,
    source: str,
    title: str,
    timestamp: str,
) -> str:
    metadata = [
        "---",
        "type: Source",
        f"title: {yaml_string(title)}",
        f"timestamp: {yaml_string(timestamp)}",
        f"source_agent: {yaml_string(source)}",
        f"source_session_id: {yaml_string(session_id)}",
        f"source_session_id_kind: {yaml_string(session_id_kind)}",
        f"capture_mode: {yaml_string(mode)}",
        f"completeness: {yaml_string(completeness)}",
        f"tags: [{yaml_string('session-memory')}, {yaml_string(source)}]",
        "---",
        "",
    ]
    return "\n".join(metadata) + body.rstrip() + "\n"


def write_private_atomic(path: Path, content: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True, mode=0o700)
    path.parent.chmod(stat.S_IRWXU)
    temp = path.with_suffix(path.suffix + ".tmp")
    temp.write_text(content, encoding="utf-8")
    temp.chmod(stat.S_IRUSR | stat.S_IWUSR)
    temp.replace(path)
    path.chmod(stat.S_IRUSR | stat.S_IWUSR)


def snapshot_wiki(root: Path, excluded: Path) -> dict[str, str]:
    snapshot: dict[str, str] = {}
    if not root.exists():
        return snapshot
    for path in sorted(root.rglob("*")):
        if not path.is_file() or path == excluded:
            continue
        relative = path.relative_to(root).as_posix()
        digest = hashlib.sha256(path.read_bytes()).hexdigest()
        snapshot[relative] = digest
    return snapshot


def changed_paths(before: dict[str, str], after: dict[str, str]) -> list[str]:
    return sorted(
        path
        for path in set(before) | set(after)
        if before.get(path) != after.get(path)
    )


def resolve_openwiki_bin(value: str | None) -> str | None:
    if value:
        path = Path(value).expanduser()
        return str(path) if path.exists() else None
    return shutil.which("openwiki")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", required=True, type=Path)
    parser.add_argument("--title", required=True)
    parser.add_argument("--source", default="codex")
    parser.add_argument("--mode", choices=("summary", "raw"), default="summary")
    parser.add_argument(
        "--completeness",
        choices=("complete", "context-visible", "partial"),
        default=None,
    )
    parser.add_argument("--session-id")
    parser.add_argument(
        "--wiki-root",
        type=Path,
        default=Path.home() / ".openwiki" / "wiki",
    )
    parser.add_argument("--openwiki-bin")
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--stage-only", action="store_true")
    return parser


def run(args: argparse.Namespace) -> dict[str, Any]:
    title = clean_single_line(args.title, "title")
    source = clean_single_line(args.source.lower(), "source")
    if not VALID_SOURCE.fullmatch(source):
        raise SaveError("source must match [a-z][a-z0-9-]{0,31}")

    body = read_input(args.input.expanduser().resolve())
    session_id, session_id_kind = resolve_session_id(args, title)
    completeness = args.completeness or (
        "complete" if args.mode == "summary" else "context-visible"
    )
    wiki_root = args.wiki_root.expanduser().resolve()
    inbox = wiki_root / "inbox"
    target = note_path(inbox, source, session_id, title)
    virtual_path = f"/{target.relative_to(wiki_root).as_posix()}"
    timestamp = utc_now().isoformat()
    rendered = render_note(
        body=body,
        completeness=completeness,
        mode=args.mode,
        session_id=session_id,
        session_id_kind=session_id_kind,
        source=source,
        title=title,
        timestamp=timestamp,
    )

    result: dict[str, Any] = {
        "capture_mode": args.mode,
        "completeness": completeness,
        "dry_run": args.dry_run,
        "inbox_path": str(target),
        "session_id": session_id,
        "session_id_kind": session_id_kind,
        "source": source,
        "virtual_path": virtual_path,
    }
    if args.dry_run:
        result["status"] = "validated"
        return result

    write_private_atomic(target, rendered)
    result["status"] = "staged"
    if args.stage_only:
        return result

    openwiki_bin = resolve_openwiki_bin(args.openwiki_bin)
    if not openwiki_bin:
        result["error"] = "openwiki executable was not found"
        return result

    before = snapshot_wiki(wiki_root, target)
    prompt = (
        f"Read {virtual_path}. It is a {args.mode} capture from a {source} "
        "session. Integrate its durable knowledge into canonical personal "
        "OpenWiki pages. Preserve the inbox note as provenance, link relevant "
        "pages back to it, update indexes and log files, and avoid duplicate "
        "concepts. Do not copy secrets or verbose tool logs into canonical "
        "pages. Report the wiki paths you changed."
    )
    command = [openwiki_bin, "personal", "--update", "--print", prompt]
    completed = subprocess.run(command, text=True, capture_output=True, check=False)
    after = snapshot_wiki(wiki_root, target)
    changed = changed_paths(before, after)
    status = "synthesized" if completed.returncode == 0 else "staged"
    if completed.returncode == 0 and not changed:
        status = "staged-no-changes"

    result.update(
        {
            "changed_paths": changed,
            "openwiki_exit_code": completed.returncode,
            "openwiki_stderr": completed.stderr.strip(),
            "openwiki_stdout": completed.stdout.strip(),
            "status": status,
        }
    )
    if completed.returncode == 0 and not changed:
        result["warning"] = "OpenWiki returned success but changed no canonical wiki files"
    return result


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()
    try:
        result = run(args)
    except (OSError, SaveError, UnicodeError) as exc:
        print(json.dumps({"status": "error", "error": str(exc)}, ensure_ascii=False))
        return 1

    print(json.dumps(result, ensure_ascii=False, indent=2, sort_keys=True))
    if result.get("error") or result.get("openwiki_exit_code", 0) != 0:
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
