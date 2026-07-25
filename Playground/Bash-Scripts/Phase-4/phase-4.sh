#!/bin/bash

#=================================================
#Script Name: phase-4.sh
#Purpose: Practicing loops (for and while loops)
#Usage: ./phase-4.sh, ./targets.txt, ./scan_*.log
#=================================================

echo "===================================================="
echo "			PHASE-4: LOOPS			  "
echo "===================================================="

#1.-----Ping multiple IPs (Hardcoded Arrays/lists)-----

echo -e "\n[+]Pinging multiple IP addresses....."

ips=("8.8.8.8" "1.1.1.1" "127.0.0.1" "192.168.1.1")

for ip in "${ips[@]}"
do
	if ping -c 1 -W 2 "$ip" > /dev/null 2>&1
	then
		echo "[*] Host $ip is online."
	else
		echo "[*] Host $ip is offline."
	fi
done

#2.-----Scan a list of targets from a file (Using while loops)-----

echo -e "\n[+]Scanning list of targets from the file....."

target_file="targets.txt"

if [[ -f "$target_file" ]]
then
	#----'while IFS= read -r' reads line-by-line without dropping backslashes or leading whitespaces----
	while IFS= read -r target
	do
		#---skip empty lines if any---
		[[ -z "$target" ]] && continue

		echo "Checking target from file: $target"

		if ping -c 1 -W 1 "$target" > /dev/null 2>&1
		then
			echo "	----> [SUCCESS] $target is reachable"
		else
			echo "	----> [FAILED] $target is not reachable"
		fi
	done < "$target_file"
else
	echo "[-] File $target_file not found!!!"
fi

#3.-----Rename scan reports automatically (Batch file renaming)-----

echo -e "\n[+] Renaming scan reports automically...."

#----Loop through all files matching the pattern 'scan_*.log'----
for file in scan_*.log
do
	#---Checking if files matched actually exists----4
	if [[ -f "$file" ]]
	then
		new_name="archived_${file}"
		mv "$file" "$new_name"
		echo "[*] Renamed $file to $new_name"
	else
		echo "[-] $file does not exist."
	fi
done

#4.-----Run the same command against multiple domains-----

echo -e "\n[+] Running DNS resolution across multiple domains....."

domains=("google.com" "github.com" "invalid.domain.test")

for domain in "${domains[@]}"
do
	resolved=$(dig "$domain" +short | grep '^[0-9]')

	if [[ -n $resolved ]]
	then
		echo "[*] $domain resolved to: $resolved"
	else
		echo "[*] $domain failed to resolve."
	fi
done

