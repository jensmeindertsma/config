#!/bin/bash

INFO=$(nmcli)

IS_DISCONNECTED=$(echo -e "$INFO" | grep -v "p2p-dev" | grep disconnected)

if [[ -n "$IS_DISCONNECTED" ]]; then
	printf '{"text": "󰖪 disconnected!", "tooltip": ""}\n'
	exit
fi

IS_VPN=$(echo -e "$INFO" | grep "VPN connection")

if [[ -n "$IS_VPN" ]]; then
	VPN_NAME=$(echo -e "$INFO" | grep "VPN connection" | cut -f 1 -d ' ')
	IP=$(echo -e "$INFO" | grep "ip4 default" -A 1 | grep "inet4" | cut -f 2 -d ' ' | cut -f 1 -d '/')
	WIFI_NAME=$(nmcli -t -f active,ssid dev wifi list --rescan no | grep '^yes' | cut -d: -f2)
	printf "{\"text\": \"󰦝 $IP ($VPN_NAME)\", \"tooltip\": \"󰖩  connected to '$WIFI_NAME'\"}\n"
	exit
fi

IS_WIFI=$(echo -e "$INFO" | grep "wifi " -B 2 | grep "connected to")

if [[ -n "$IS_WIFI" ]]; then
	IP=$(echo -e "$INFO" | grep "ip4 default" -A 1 | grep "inet4" | cut -f 2 -d ' ' | cut -f 1 -d '/')
	WIFI_NAME=$(nmcli -t -f active,ssid dev wifi list --rescan no | grep '^yes' | cut -d: -f2)
	printf "{\"text\": \"󰖩  $IP ($WIFI_NAME)\", \"tooltip\": \"\"}\n"
	exit
fi

# TODO: wired connection

# 󰦝 󰴳 󰚊
printf '{"text": " loading...", "tooltip": ""}\n'
