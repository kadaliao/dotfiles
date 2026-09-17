#!/bin/sh
# Bootstrap the herdr plugin set on this machine.
#
# Why the plugin state itself is not synced:
#   - `herdr plugin install ...` downloads its own managed checkout and writes
#     ~/.config/herdr/plugins.json plus ~/.config/herdr/.plugins.lock, which
#     hold machine-local enabled state and the resolved commit. A dot_ file
#     would fight the CLI, so neither belongs in this repo.
#   - Sockets, logs, release-notes.json and session.json under
#     ~/.config/herdr are per-machine runtime state as well. Only config.toml
#     is managed, and it stays identical across machines.
#
# So the table below is the single source of truth for which plugins each
# machine has. Editing it changes the script contents, which is what re-triggers
# this run_onchange_ script.
#
# Row format: <owner/repo[/subdir]>|<expected plugin id>
#   The expected id is what `herdr plugin list` prints; it comes from the
#   plugin's own herdr-plugin.toml, not from the repository name.
#
# Upgrading is deliberately manual, exactly like `pi update --extensions` and
# `omp plugin install`: re-run `herdr plugin install <spec> -y` on the machine,
# or bump a pin here with a `--ref`-style rewrite of the spec.
set -eu

HERDR_PLUGINS='
kadaliao/herdr-space-index|kadaliao.space-index
'

# herdr normally comes from Homebrew, and a non-interactive script gets no
# shell PATH, so fall back to the usual install locations.
if command -v herdr >/dev/null 2>&1; then
    HERDR_BIN=$(command -v herdr)
else
    HERDR_BIN=""
    for candidate in /opt/homebrew/bin/herdr /usr/local/bin/herdr "$HOME"/.local/bin/herdr; do
        if [ -x "$candidate" ]; then
            HERDR_BIN=$candidate
            break
        fi
    done
fi

if [ -z "$HERDR_BIN" ]; then
    echo "herdr is not installed; skipping herdr plugin bootstrap." >&2
    echo "After installing herdr, re-run with: chezmoi state delete-bucket --bucket=scriptState && chezmoi apply" >&2
    exit 0
fi

# Installing a plugin writes ~/.config/herdr/plugins.json directly, so it works
# with no server running. `herdr status server` also exits 0 either way, which
# is why this script does not gate on a server: chezmoi apply can bootstrap the
# plugin before herdr was ever started on the machine.

installed_herdr_plugins() {
    "$HERDR_BIN" plugin list 2>/dev/null | sed -n 's/^- \([^ ][^ ]*\) .*/\1/p'
}

installed=$(installed_herdr_plugins)

while IFS='|' read -r spec want_id; do
    if [ -z "$spec" ]; then
        continue
    fi

    if printf '%s\n' "$installed" | grep -Fxq -- "$want_id"; then
        echo "herdr plugin: $want_id already installed"
        continue
    fi

    echo "herdr plugin: installing $spec"
    "$HERDR_BIN" plugin install "$spec" -y
done <<EOF
$HERDR_PLUGINS
EOF

# A plugin that installed but never resolved stays silently absent from the
# sidebar, so re-check instead of trusting the install command.
installed=$(installed_herdr_plugins)
missing=0

while IFS='|' read -r spec want_id; do
    if [ -z "$spec" ]; then
        continue
    fi
    if ! printf '%s\n' "$installed" | grep -Fxq -- "$want_id"; then
        echo "herdr plugin: $want_id is still not installed" >&2
        missing=1
    fi
done <<EOF
$HERDR_PLUGINS
EOF

if [ "$missing" -ne 0 ]; then
    exit 1
fi

echo "herdr plugins: all declared plugins installed"
