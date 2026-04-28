#!/bin/bash

IFACE=$(ip route show default 2>/dev/null | awk '{print $5}' | head -1)

if [ -z "$IFACE" ]; then
    printf "↓ %-6s ↑ %-6s" "--" "--"
    exit 0
fi

CACHE="/tmp/waybar-net-$IFACE"

read rx < /sys/class/net/$IFACE/statistics/rx_bytes 2>/dev/null || { printf "↓ %-6s ↑ %-6s" "0B" "0B"; exit 0; }
read tx < /sys/class/net/$IFACE/statistics/tx_bytes 2>/dev/null || { printf "↓ %-6s ↑ %-6s" "0B" "0B"; exit 0; }

if [ -f "$CACHE" ]; then
    read prev_rx prev_tx < "$CACHE"
else
    prev_rx=$rx
    prev_tx=$tx
fi

echo "$rx $tx" > "$CACHE"

delta_rx=$((rx - prev_rx))
delta_tx=$((tx - prev_tx))

format_speed() {
    local val
    val=$(awk -v b="$1" 'BEGIN {
        if (b >= 1048576) printf "%.1fM", b/1048576
        else if (b >= 1024) printf "%dK", b/1024
        else printf "%dB", b
    }')
    printf "%-5s" "$val"
}

printf "↓ %s ↑ %s" "$(format_speed $delta_rx)" "$(format_speed $delta_tx)"
