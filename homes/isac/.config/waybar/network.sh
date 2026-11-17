#!/usr/bin/env bash

IFACE="proton-nl"
IPV4_TEST="1.1.1.1"
IPV6_TEST="2606:4700:4700::1111"

# Test IPv4 and IPv6 connectivity
ping -4 -c 1 -W 2 "$IPV4_TEST" >/dev/null 2>&1
CONNECTIVITY_IPV4=$?

ping -6 -c 1 -W 2 "$IPV6_TEST" >/dev/null 2>&1
CONNECTIVITY_IPV6=$?

# Get the actual interfaces used by each route
ROUTE_IPV4=$(ip -4 route get "$IPV4_TEST" 2>/dev/null | awk '{for (i=1; i<=NF; i++) if ($i=="dev") {print $(i+1); exit}}')
ROUTE_IPV6=$(ip -6 route get "$IPV6_TEST" 2>/dev/null | awk '{for (i=1; i<=NF; i++) if ($i=="dev") {print $(i+1); exit}}')

# Both fail: down
if (( CONNECTIVITY_IPV4 != 0 && CONNECTIVITY_IPV6 != 0 )); then
    echo "{\"text\":\"disconnected\",\"alt\":\"down\"}"

# At least one succeeds: verify both routes use the VPN
elif [[ "$ROUTE_IPV4" == "$IFACE" && "$ROUTE_IPV6" == "$IFACE" ]]; then
    echo "{\"text\":\"$IFACE\",\"alt\":\"safe\"}"

else
    # At least one of the routes is not going through the VPN, figure out which one and what
    # interface it is
    if [[ "$ROUTE_IPV4" != "$IFACE" && -n "$ROUTE_IPV4" ]]; then
        ACTUAL_IFACE="$ROUTE_IPV4"
    else
        ACTUAL_IFACE="$ROUTE_IPV6"
    fi 
    
    echo "{\"text\":\"$ACTUAL_IFACE (danger)\",\"alt\":\"danger\"}"
fi
