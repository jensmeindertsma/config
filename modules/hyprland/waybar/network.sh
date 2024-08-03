# This is my custom script for the waybar network module

INFO=$(nmcli)

IP=$(echo -e "$INFO" | grep "ip4 default" -A 1 | grep "inet4" | cut -f 2 -d ' ' | cut -f 1 -d '/')
IS_VPN=$(echo -e "$INFO" | grep "VPN connection")
IS_WIRED=$(echo -e "$INFO" | grep 'ethernet (' -B 2 | grep "connected to")
WIFI_NAME=$(nmcli -t -f active,ssid dev wifi list --rescan no | grep '^yes' | cut -d: -f2)

if [[ -n "$IS_VPN" ]]; then
	if [[ -z "$IP" ]] then
		printf '{"text": "󰦝 loading...", "tooltip": ""}\n'
	else
		VPN_NAME=$(echo -e "$INFO" | grep "VPN connection" | cut -f 1 -d ' ')
		if [[ -n "$IS_WIRED" ]]; then
			SUBSTRING="connected to "
			NET_NAME="${IS_WIRED#*$SUBSTRING}"
			printf "{\"text\": \"󰦝 $IP ($VPN_NAME)\", \"tooltip\": \"󰈀 connected to '$NET_NAME'\"}\n"
		else 
			printf "{\"text\": \"󰦝 $IP ($VPN_NAME)\", \"tooltip\": \"󰖩  connected to '$WIFI_NAME'\"}\n"
		fi
	fi
	exit
fi

IS_WIFI=$(echo -e "$INFO" | grep "wifi " -B 2 | grep "connected to")

if [[ -n "$IS_WIFI" ]]; then
	printf "{\"text\": \"󰖩  $IP ($WIFI_NAME)\", \"tooltip\": \"\"}\n"
	exit
fi

if [[ -n "$IS_WIRED" ]]; then
	printf "{\"text\": \"󰈀 $IP\", \"tooltip\": \"\"}\n"
	exit
fi

IS_DISCONNECTED=$(echo -e "$INFO" | grep -v "p2p-dev" | grep disconnected)

if [[ -n "$IS_DISCONNECTED" ]]; then
	printf '{"text": "󰖪 disconnected!", "tooltip": ""}\n'
	exit
fi

# DISABLED
IS_DISABLED=$(echo -e "$INFO" | grep "wifi " -B 2 | grep "sw disabled")

if [[ -n "$IS_DISABLED" ]]; then
	printf "{\"text\": \"󱡺  disabled!\", \"tooltip\": \"\"}\n"
	exit
fi
# 󰦝 󰴳 󰚊
printf '{"text": " loading...", "tooltip": ""}\n'
