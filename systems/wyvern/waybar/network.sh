#!/bin/bash

OUTPUT=$(nmcli)

CONNECTED=$(echo "$OUTPUT" | grep "ip4 default")

if [ -z "$CONNECTED" ]; then
	echo "disconnected"
	return 0
fi

VPN=$(echo "$OUTPUT" | grep "VPN connection" | awk '{print $1}')

if [ -n "$VPN" ]; then
	IP=$(echo "$OUTPUT" | grep "VPN connection" -A 5 | grep "inet4" | awk '{print $2}')

	if [ -n "$IP" ]; then
		echo "$IP ($VPN)"
	else
		echo "loading ($VPN)"
	fi

	return 0
fi

IP=$(echo "$OUTPUT" | grep "ip4 default" -A 1 | grep "inet4" | awk '{print $2}' )
CONNECTION_NAME=$(echo "$OUTPUT" | grep "connected to" | awk '{print $4}')

echo "$IP ($CONNECTION_NAME)"
