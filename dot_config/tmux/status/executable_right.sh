#!/bin/sh

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/tmux-status"
state_file="$cache_dir/net.state"

mkdir -p "$cache_dir"

append_part() {
    color="$1"
    text="$2"

    if [ -z "$text" ]; then
        return
    fi

    if [ -n "$parts" ]; then
        parts="$parts#[fg=white,bg=brightblack,nobold,noitalics,nounderscore]  "
    fi

    parts="$parts#[fg=$color,bg=brightblack,nobold,noitalics,nounderscore] $text"
}

human_rate() {
    bytes="$1"

    if [ -z "$bytes" ] || [ "$bytes" -lt 0 ] 2>/dev/null; then
        printf '0B'
    elif [ "$bytes" -ge 1048576 ] 2>/dev/null; then
        awk "BEGIN { printf \"%.1fM\", $bytes / 1048576 }"
    elif [ "$bytes" -ge 1024 ] 2>/dev/null; then
        awk "BEGIN { printf \"%.1fK\", $bytes / 1024 }"
    else
        printf '%sB' "$bytes"
    fi
}

battery_segment() {
    info="$(pmset -g batt 2>/dev/null | awk -F'; *' '/InternalBattery/ {
        split($1, fields, "\t")
        pct = fields[length(fields)]
        gsub(/%/, "", pct)
        print pct "|" $2
        exit
    }')"

    if [ -z "$info" ]; then
        return
    fi

    pct="${info%%|*}"
    state="${info#*|}"
    color="green"
    label="🔋 ${pct}%"

    case "$state" in
        charged)
            label="🔌 ${pct}%"
            color="green"
            ;;
        charging)
            label="🔌 ${pct}%"
            color="green"
            ;;
        discharging)
            if [ "$pct" -le 20 ] 2>/dev/null; then
                color="red"
            elif [ "$pct" -le 50 ] 2>/dev/null; then
                color="yellow"
            else
                color="green"
            fi
            ;;
        *)
            color="white"
            ;;
    esac

    append_part "$color" "$label"
}

load_segment() {
    load_avg="$(sysctl -n vm.loadavg 2>/dev/null | sed 's/[{}]//g' | awk '{print $1}')"
    append_part "yellow" "🏋️ $load_avg"
}

network_segment() {
    iface="$(route -n get default 2>/dev/null | awk '/interface:/{print $2; exit}')"

    if [ -z "$iface" ]; then
        return
    fi

    set -- $(netstat -ibn -I "$iface" 2>/dev/null | awk '
        NR > 1 && $7 ~ /^[0-9]+$/ && $10 ~ /^[0-9]+$/ {
            rx = $7
            tx = $10
        }
        END {
            print rx + 0, tx + 0
        }
    ')

    rx="${1:-0}"
    tx="${2:-0}"
    now="$(date +%s)"
    down_rate=0
    up_rate=0

    if [ -r "$state_file" ]; then
        read -r prev_iface prev_time prev_rx prev_tx < "$state_file"
        if [ "$prev_iface" = "$iface" ] && [ -n "$prev_time" ] && [ "$now" -gt "$prev_time" ] 2>/dev/null; then
            elapsed=$((now - prev_time))
            if [ "$elapsed" -gt 0 ] 2>/dev/null; then
                rx_delta=$((rx - prev_rx))
                tx_delta=$((tx - prev_tx))
                if [ "$rx_delta" -lt 0 ] 2>/dev/null; then
                    rx_delta=0
                fi
                if [ "$tx_delta" -lt 0 ] 2>/dev/null; then
                    tx_delta=0
                fi
                down_rate=$((rx_delta / elapsed))
                up_rate=$((tx_delta / elapsed))
            fi
        fi
    fi

    printf '%s %s %s %s\n' "$iface" "$now" "$rx" "$tx" > "$state_file"
    append_part "cyan" "↓ $(human_rate "$down_rate")/s ↑ $(human_rate "$up_rate")/s"
}

parts=""

battery_segment
load_segment
network_segment

printf '#[fg=brightblack,bg=black,nobold,noitalics,nounderscore]%s' "$parts"
