#!/bin/sh
# Bootstrap the pi package set on this machine.
#
# Why the installed packages are not synced:
#   - ~/.pi/agent/npm is ~746 MB / ~53k files, and git-sourced packages are
#     cloned into ~/.pi/agent/git/<host>/<path>. Neither belongs in this repo.
#   - `pi install` writes ~/.pi/agent/settings.json, but that file is managed
#     here by modify_private_settings.json, which merges (it only pins
#     defaultProvider/defaultModel) instead of overwriting. So pi and chezmoi
#     can both write it, unlike ~/.omp/plugins where a dot_ file would fight
#     `omp plugin install`.
#
# The list below is the single source of truth for which packages each machine
# gets. Specs are copied verbatim from settings.json and are intentionally
# unpinned: upgrade with `pi update --extensions` (or `pi update --all`), which
# is also what reconciles pinned git refs. Editing this list changes the script
# contents, which is what re-triggers this run_onchange_ script.
#
# `pi list` prints a spec with a resolved path when it is installed, and the
# spec alone when it is merely declared - which is what a machine looks like
# right after it first syncs settings.json.
set -eu

PI_PACKAGES='
https://github.com/gsanhueza/pi-token-speed
npm:pi-web-access
npm:pi-lens
npm:@plannotator/pi-extension
npm:pi-mcp-adapter
npm:@juicesharp/rpiv-ask-user-question
npm:pi-agent-browser-native
npm:pi-arcade-games
npm:@zhushanwen/pi-pending-notifications@0.7.2
npm:pi-herdr-agents
'

# pi normally comes from fnm, and a non-interactive script gets no fnm
# multishell shim on PATH, so fall back to the fnm default alias and then to
# any installed node version.
if command -v pi >/dev/null 2>&1; then
    PI_BIN=$(command -v pi)
else
    PI_BIN=""
    for candidate in "$HOME"/.local/share/fnm/aliases/default/bin/pi "$HOME"/.local/share/fnm/node-versions/*/installation/bin/pi; do
        if [ -x "$candidate" ]; then
            PI_BIN=$candidate
            break
        fi
    done
fi

if [ -z "$PI_BIN" ]; then
    echo "pi is not installed; skipping pi package bootstrap." >&2
    echo "After installing pi, re-run with: chezmoi state delete-bucket --bucket=scriptState && chezmoi apply" >&2
    exit 0
fi

installed_pi_packages() {
    "$PI_BIN" list | awk '
        /^  [^ ]/ { spec = $0; sub(/^[ \t]+/, "", spec); next }
        /^    [^ ]/ { if (spec != "") print spec; spec = ""; next }
        { spec = "" }
    '
}

installed=$(installed_pi_packages)

while IFS= read -r source; do
    if [ -z "$source" ]; then
        continue
    fi

    if printf '%s\n' "$installed" | grep -Fxq -- "$source"; then
        echo "pi package: $source already installed"
        continue
    fi

    echo "pi package: installing $source"
    "$PI_BIN" install "$source" --no-approve
done <<EOF
$PI_PACKAGES
EOF

# A spec that settings.json declares but never materialised stays silently
# absent at load time, so re-check instead of trusting the install command.
installed=$(installed_pi_packages)
missing=0

while IFS= read -r source; do
    if [ -z "$source" ]; then
        continue
    fi
    if ! printf '%s\n' "$installed" | grep -Fxq -- "$source"; then
        echo "pi package: $source is still not installed" >&2
        missing=1
    fi
done <<EOF
$PI_PACKAGES
EOF

if [ "$missing" -ne 0 ]; then
    exit 1
fi

echo "pi packages: all declared packages installed"
