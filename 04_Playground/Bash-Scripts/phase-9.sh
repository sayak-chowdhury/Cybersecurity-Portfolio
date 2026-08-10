#!/bin/bash

# ===========================================
# Script Name: phase-9.sh
# Purpose: Networking Automation
# Usage: ./phase-9.sh [target_domain_or_ip]
# ===========================================

#1-----Target & Environment Initialization-----
TARGET="${1:-example.com}"
DOWNLOAD_DIR="$HOME/scripts/downloads_phase-9"

echo "=================================================="
echo "      PHASE 9 - NETWORKING AUTOMATION             "
echo "=================================================="
echo "[*] Target Host: $TARGET"
echo "[*] Timestamp:   $(date)"
echo "=================================================="

#2-----Interface & Listening Ports Overview (ip & ss)-----
echo -e "\n[+] Network State & Active Sockets"
echo "---Active IP Interface(ip)---"
ip -brief addr 2>/dev/null || ip addr | grep "inet "

echo -e "\n---Listening TCP/UDP Ports---"
ss -tuln | head -n 8

#3-----Check connectivity (ping)-----
echo -e "\n[+] Checking Host Connectivity"
if ping -c 2 -W 2 "$TARGET" &>/dev/null
then
	echo "[+] Success: $TARGET is ALIVE and responding to ICMP ping."
else
	echo "[-] Warning: $TARGET is DOWN or blocking ICMP ping requests."
fi

#4-----Resolve DNS (dig & nslookup)-----
echo -e "\n[+] Resolving DNS Records"
if command -v dig &>/dev/null
then
	echo "---Primary Lookup using 'dig'---"
	echo "[*] A Record (IPv4 Address):"
	dig +short "$TARGET" A | sed 's/^/      /'
	echo "[*] MX Record (Mail Server):"
	dig +short "$TARGET" MX | sed 's/^/      /'
else
	echo "[-] Tool 'dig' is not installed."
fi

if command -v dig &>/dev/null
then
	echo "---Secondary Lookup using 'nslookup'---"
	nslookup "$TARGET" | grep -A 1 "Name:" | sed 's/^/      /'
else
	echo "[-] Tool 'nslookup' is not installed."
fi

#5-----Retrieve HTTP Headers & Identify Server Banner (curl)-----
echo -e "\n[+] Retrieving HTTP Headers & Server Banner"

if command -v curl &>/dev/null
then
	echo "--- Fetching Response Headers (curl -I) ---"
	HEADERS=$(curl -I -s --max-time 5 "http://$TARGET")

	if [[ -n "$HEADERS" ]]
	then
		echo "$HEADERS" | head -n 8 | sed 's/^/      /'
		echo -e "\n--- Extracted Server Banner ---"
		BANNER=$(echo "$HEADERS" | grep "^Server" | tr -d '\r')
		if [[ -n "$BANNER" ]]
		then
			echo "[+] Banner Found: $BANNER"
        	else
           		echo "[-] Banner Hidden: 'Server:' header was not provided by host."
        	fi
	else
		echo "[-] Failed: Could not connect to http://$TARGET"
	fi
else
	echo "[-] Tool 'curl' is not installed."
fi

#6-----Download Webpage Content (wget)-----
echo -e "\n[+] Downloading Webpage Content"
mkdir -p "$DOWNLOAD_DIR"

if command -v wget &>/dev/null
then
	OUTPUT_FILE="$DOWNLOAD_DIR/${TARGET}_index.html"
	echo "[*] Downloading homepage via 'wget'..."
	if wget -q -O "$OUTPUT_FILE" --timeout=5 "http://$TARGET"
	then
		echo "[+] Success: File saved to $OUTPUT_FILE ($(du -h "$OUTPUT_FILE" | cut -f1))"
	else
		echo "[-] Failed to download webpage using 'wget'."
	fi
else
	echo "[-] Tool 'wget' is not installed."
fi

echo -e "\n=================================================="
echo "       NETWORKING AUTOMATION COMPLETE             "
echo "=================================================="

