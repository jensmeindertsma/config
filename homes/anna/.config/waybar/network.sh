#!/usr/bin/env bash
set -euo pipefail

WG_IF="proton-nl"
MAX_HANDSHAKE=180

json() {
	local text="$1"
	local class="$2"
	local tooltip="${3:-}"

	tooltip=${tooltip//\\/\\\\}
	tooltip=${tooltip//\"/\\\"}
	tooltip=${tooltip//$'\n'/\\n}

	printf '{"text":"%s","class":"%s","tooltip":"%s"}\n' \
		"$text" "$class" "$tooltip"
}

down() {
	json "down" "down"
	exit 0
}

leak() {
	json "leaking" "leaking"
	exit 0
}

############################################################
# Interface
############################################################

ip link show "$WG_IF" >/dev/null 2>&1 || down

state=$(<"/sys/class/net/$WG_IF/operstate")

[[ "$state" == "up" || "$state" == "unknown" ]] || down

############################################################
# Handshake
############################################################

hs=$(sudo wg show "$WG_IF" latest-handshakes | awk '{print $2}')

[[ "$hs" != "0" ]] || down

age=$(($(date +%s) - hs))

((age <= MAX_HANDSHAKE)) || down

############################################################
# Allowed IPs
############################################################

allowed=$(sudo wg show "$WG_IF" allowed-ips)

grep -q '0\.0\.0\.0/0' <<<"$allowed" || leak

ipv6=false
if grep -q '::/0' <<<"$allowed"; then
	ipv6=true
fi

############################################################
# IPv4 routing
############################################################

route=$(ip route get 1.1.1.1)

dev=$(awk '
{
    for(i=1;i<=NF;i++)
        if($i=="dev"){
            print $(i+1)
            exit
        }
}' <<<"$route")

[[ "$dev" == "$WG_IF" ]] || leak

############################################################
# IPv6 routing
############################################################

if $ipv6 && ip -6 route get 2606:4700:4700::1111 >/dev/null 2>&1; then

	route6=$(ip -6 route get 2606:4700:4700::1111)

	dev6=$(awk '
    {
        for(i=1;i<=NF;i++)
            if($i=="dev"){
                print $(i+1)
                exit
            }
    }' <<<"$route6")

	[[ "$dev6" == "$WG_IF" ]] || leak
fi

############################################################
# Public IP
############################################################

info=$(curl -fsS --max-time 5 https://ipinfo.io/json) || down

ip=$(jq -r '.ip' <<<"$info")
city=$(jq -r '.city' <<<"$info")
country=$(jq -r '.country' <<<"$info")
org=$(jq -r '.org' <<<"$info")

tooltip="${ip}
${city}, ${country}
${org}"

json "up" "up" "$tooltip"
