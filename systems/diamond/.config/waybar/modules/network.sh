#!/bin/bash

OUTPUT=$(nmcli)

# --- VPN HAS TOP PRIORITY ---
VPN=$(echo "$OUTPUT" | grep "VPN connection")

if [ -n "$VPN" ]; then
    IP=$(echo "$OUTPUT" | grep "VPN connection" -A 5 | grep "inet4")

    if [ -n "$IP" ]; then
        echo "{\"alt\": \"vpn\"}"
    else
        echo "{\"alt\": \"loading\"}"
    fi
    exit 0
fi

# --- NORMAL CONNECTION ---
CONNECTED=$(echo "$OUTPUT" | grep "ip4 default")

if [ -n "$CONNECTED" ]; then
    echo "{\"alt\": \"connected\"}"
    exit 0
fi

# --- WIFI DISABLED ---
DISABLED=$(echo "$OUTPUT" | grep "wifi " | grep "sw disabled")

if [ -n "$DISABLED" ]; then
    echo "{\"alt\": \"disabled\"}"
    exit 0
fi

# --- FALLBACK ---
echo "{\"alt\": \"disconnected\"}"
exit 0

