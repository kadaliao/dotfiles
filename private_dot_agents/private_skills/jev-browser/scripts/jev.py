"""Small host-local Jev entrypoint; secrets never enter command arguments or output."""
import argparse
from datetime import datetime, timezone
import getpass
import importlib.util
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import time
import uuid

SERVICE = "codex-jev-browser"
ACCOUNT = "TYPESAFE_API_KEY"
RUN_LOG = Path.home() / ".local/state/jev-browser/runs.jsonl"


def record_run(record):
    RUN_LOG.parent.mkdir(parents=True, exist_ok=True, mode=0o700)
    fd = os.open(RUN_LOG, os.O_WRONLY | os.O_CREAT | os.O_APPEND, 0o600)
    with os.fdopen(fd, "a") as stream:
        stream.write(json.dumps(record, ensure_ascii=False) + "\n")


def status():
    if not RUN_LOG.exists():
        print("No recorded Jev runs. Tracking starts with this version; older runs are not included.")
        return 0
    from collections import deque
    with RUN_LOG.open() as stream:
        for line in deque(stream, maxlen=5):
            print(line.rstrip())
    return 0


def key_exists():
    return subprocess.run(
        ["/usr/bin/security", "find-generic-password", "-s", SERVICE, "-a", ACCOUNT],
        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
    ).returncode == 0


def text_config():
    names = ("TEXT_MODEL_API_KEY", "TEXT_MODEL_BASE_URL", "TEXT_MODEL")
    if any(os.environ.get(n) for n in names):
        if not all(os.environ.get(n) for n in names):
            raise ValueError("Set all three TEXT_MODEL_* variables together.")
        return {n: os.environ[n] for n in names}
    path = Path.home() / ".pi/agent/models.json"
    provider = json.loads(path.read_text())["providers"]["oneapi"]
    key = provider["apiKey"]
    if not isinstance(key, str) or not key or key.startswith("!"):
        raise ValueError("The Pi provider key must be literal or an exported variable name.")
    reference = re.fullmatch(r"\$\{([A-Za-z_][A-Za-z0-9_]*)\}", key) or re.fullmatch(r"\$([A-Za-z_][A-Za-z0-9_]*)", key)
    if reference or key.isidentifier():
        key = os.environ.get(reference.group(1) if reference else key)
        if not key:
            raise ValueError("The Pi provider's key variable is not exported.")
    elif key.startswith("$"):
        raise ValueError("Unsupported key expression in the Pi provider; use an environment variable.")
    return {"TEXT_MODEL_API_KEY": key, "TEXT_MODEL_BASE_URL": provider["baseUrl"],
            "TEXT_MODEL": "deepseek-v4-flash"}


def setup_key():
    if not sys.stdin.isatty():
        raise ValueError("Run setup-key in this Mac's Terminal for hidden input.")
    import keyring
    key = getpass.getpass("TypeSafe API Key (hidden): ").strip()
    if not key:
        raise ValueError("No key entered; nothing changed.")
    try:
        keyring.set_password(SERVICE, ACCOUNT, key)
        if keyring.get_password(SERVICE, ACCOUNT) != key:
            raise ValueError("Keychain verification failed.")
    except Exception:
        raise ValueError("Cannot access the login keychain. Run this in Terminal in this Mac's logged-in GUI session.") from None
    print("TypeSafe key saved and verified in this Mac's keychain.")


def doctor():
    result = {"runtime": bool(importlib.util.find_spec("jev_ultrafast")),
              "typesafe_key": "environment" if os.environ.get(ACCOUNT) else "keychain" if key_exists() else "missing"}
    try:
        config = text_config()
        result.update(text_helper="configured", text_model=config["TEXT_MODEL"],
                      text_base_url=config["TEXT_MODEL_BASE_URL"])
    except (ValueError, KeyError, OSError):
        result["text_helper"] = "missing or invalid"
    print(json.dumps(result, ensure_ascii=False, indent=2))
    return 0 if result["runtime"] and result["typesafe_key"] != "missing" and result["text_helper"] == "configured" else 2


def run(args):
    if not os.environ.get(ACCOUNT):
        if not key_exists():
            raise ValueError("TypeSafe key missing. Run: ~/.agents/skills/jev-browser/scripts/jev setup-key")
        import keyring
        try:
            key = keyring.get_password(SERVICE, ACCOUNT)
        except Exception:
            raise ValueError("Cannot read the keychain; authorize access in this Mac's GUI session.") from None
        if not key:
            raise ValueError("TypeSafe key unavailable.")
        os.environ[ACCOUNT] = key
    os.environ.update(text_config())
    os.environ.setdefault("TEXT_MODEL_REASONING", "none")
    # Honor macOS's trusted corporate CAs without weakening TLS verification.
    import truststore
    truststore.inject_into_ssl()
    from jev_ultrafast import Agent
    agent = Agent(args.url, args.goal)
    print(json.dumps({"executor": "jev", "run_id": args.audit["run_id"], "tab_id": agent.browser.target}), flush=True)
    state = agent.snapshot()
    try:
        for _ in range(args.max_steps):
            state = agent.command("tick")
            print(json.dumps({"elapsed_ms": state["elapsed_ms"], "status": state["status"],
                              "actions": len(state["history"])}), flush=True)
            if state["status"] in {"done", "blocked"}:
                break
        result = {"status": state["status"] if state["status"] in {"done", "blocked"} else "budget_exhausted",
                  "elapsed_ms": state["elapsed_ms"], "url": state["page"]["url"],
                  "title": state["page"]["title"], "visible_text": state["page"]["text"][:6000],
                  "tab_id": agent.browser.target,
                  "jev_usage": [d.get("usage", {}) for d in state["decisions"]],
                  "text_usage": [d.get("usage", {}) for d in state["text_calls"]]}
        print(json.dumps(result, ensure_ascii=False, indent=2))
        args.audit["status"] = result["status"]
        return 0 if result["status"] == "done" else 3
    finally:
        final = agent.state
        args.audit.update(actions=len(final["history"]), jev_requests=len(final["decisions"]),
                          text_requests=len(final["text_calls"]), agent_loop_ms=final["elapsed_ms"],
                          jev_model_ms=sum(d.get("latency_ms", 0) for d in final["decisions"]),
                          text_model_ms=sum(d.get("latency_ms", 0) for d in final["text_calls"]))
        if args.close:
            agent.close()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest="command", required=True)
    commands.add_parser("doctor")
    commands.add_parser("setup-key")
    commands.add_parser("status", help="Show the five most recent recorded Jev runs.")
    task = commands.add_parser("run")
    task.add_argument("--url", required=True)
    task.add_argument("--goal", required=True)
    task.add_argument("--max-steps", type=int, default=20, choices=range(1, 61), metavar="1..60")
    task.add_argument("--close", action="store_true")
    args = parser.parse_args()
    started = time.perf_counter()
    if args.command == "run":
        args.audit = {"executor": "jev", "run_id": uuid.uuid4().hex[:12],
                      "started_at": datetime.now(timezone.utc).isoformat(), "status": "error",
                      "actions": 0, "jev_requests": 0, "text_requests": 0}
    try:
        if args.command == "status":
            return status()
        return setup_key() if args.command == "setup-key" else doctor() if args.command == "doctor" else run(args)
    except Exception as error:
        # Provider/browser exceptions can include page or authentication details.
        if isinstance(error, ValueError):
            print(str(error), file=sys.stderr)
        else:
            print(f"Jev failed ({type(error).__name__}); check credentials and browser connection.", file=sys.stderr)
        return 2
    finally:
        if args.command == "run":
            args.audit["total_ms"] = round((time.perf_counter() - started) * 1000)
            try:
                record_run(args.audit)
            except OSError:
                print("Could not save Jev usage record.", file=sys.stderr)


if __name__ == "__main__":
    sys.exit(main())
