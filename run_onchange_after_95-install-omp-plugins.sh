#!/bin/sh
# Bootstrap the omp (oh-my-pi) plugin set on this machine.
#
# Why the plugin state itself is not synced:
#   - ~/.omp/plugins/node_modules is ~377 MB / ~29k files with cross-platform
#     prebuilt binaries (node-pty, clipboard). It must never enter this repo.
#   - `omp plugin install` rewrites package.json, bun.lock and
#     omp-plugins.lock.json. Managing those as dot_ files would let
#     `chezmoi apply` revert a plugin installed on this machine, and
#     `chezmoi add` pull a machine-local install into the repo.
#   - A synced omp-plugins.lock.json also carries per-machine `enabled` /
#     `enabledFeatures` state that would be stomped between machines.
#
# So the table below is the single source of truth for which plugins each
# machine has. Editing it changes the script contents, which is what
# re-triggers this run_onchange_ script - that is also how you upgrade a pin.
#
# Row format: <install spec>|<plugin name>|<expected version, empty = any>
#   npm specs pin an exact version so a fresh machine cannot drift; git specs
#   track a branch, so append #<sha> to the URL when reproducibility matters.
set -eu

OMP_PLUGINS='
https://github.com/gsanhueza/pi-token-speed|pi-token-speed|
npm:@plannotator/pi-extension@0.27.15|@plannotator/pi-extension|0.27.15
'

if ! command -v omp >/dev/null 2>&1; then
    echo "omp is not on PATH; skipping omp plugin bootstrap." >&2
    echo "After installing omp, re-run with: chezmoi state delete-bucket --bucket=scriptState && chezmoi apply" >&2
    exit 0
fi

if ! command -v python3 >/dev/null 2>&1; then
    echo "python3 is required to read 'omp plugin list --json'." >&2
    exit 1
fi

# "<name> <version>" per npm-installed plugin.
installed=$(omp plugin list --json | python3 -c '
import json, sys
for plugin in json.load(sys.stdin).get("npm", []):
    print(plugin["name"], plugin.get("version", ""))
')

while IFS='|' read -r spec name want; do
    if [ -z "$spec" ]; then
        continue
    fi

    have=$(printf '%s\n' "$installed" | awk -v name="$name" '$1 == name { print $2; exit }')

    # Already satisfied: reinstalling would re-enable a plugin that was
    # deliberately disabled here, and reset its feature selection.
    if [ -n "$have" ] && { [ -z "$want" ] || [ "$have" = "$want" ]; }; then
        echo "omp plugin: $name@$have already installed"
        continue
    fi

    if [ -n "$have" ]; then
        echo "omp plugin: $name $have -> $want"
    else
        echo "omp plugin: installing $spec"
    fi
    omp plugin install "$spec"
done <<EOF
$OMP_PLUGINS
EOF

# A synced lockfile without node_modules is skipped silently at load time, so
# plugins would disappear with no error. Make that failure loud instead.
if ! omp plugin doctor; then
    echo "omp plugin doctor reported problems; see the output above." >&2
    exit 1
fi

echo "omp plugins: all declared plugins present"
