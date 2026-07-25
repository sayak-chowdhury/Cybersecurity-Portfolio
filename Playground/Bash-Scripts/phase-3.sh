#!/bin/bash

#===========================================
#Script Name: phase-3.sh
#Purpose: Desicsion making using if-else
#Usage: ./phase-3.sh
#===========================================

echo "=================================================="
echo "		PHASE 3: DECISION MAKING		"
echo "=================================================="

#1.------Check if the script is run as root------
#------Pentesters often need root privileges to run advanced tools------

if [[ "$EUID" -ne 0 ]]
then
	echo "[-] !!!!WARNING!!!! ---> You are not running this script as root, some tasks might fail <----"
else
	echo "[+] Running with Root/Sudo privileges."
fi

#2.-----Check if tools are installed or not-----

echo -e "\n[*] Checking required tools......"

for tool in nslookup dig curl
do

#-----'command -v tool_name' returns tool's path if it is present, or else returns nothing-----
#-----'> /dev/null' redirects the stdout to null to hide command's text output & '2>&1' redirects any error in command's output to current stdout's location to clean the screen-----
#----- '2' is for stderr(standard error) and 1 is for stdout(here, null is stdout)-----

	if command -v "$tool" > /dev/null 2>&1
	then
		echo "$tool is already installed."
	else
		echo "$tool is not installed."
	fi
done

#3.-----Check if the IP address is reachable from user input (Ping Check)-----

read -p "[*] Enter target IP Address to check reachability: " targ_ip

if ping -c 2 -W 4 "$targ_ip" > /dev/null 2>&1
then
	echo "SUCCESSFULL ----> Host $targ_ip is reachable."
else
	echo "FAILED ----> Host $targ_ip is not reachable."
fi

#4.-----Check if a domain resolves from user input (DNS Check)-----

read -p "[*] Enter target domain to check: " targ_dom

resolved_ip=$(dig "$targ_dom" +short | grep '^[0-9]')

if [[ -n "$resolved_ip" ]]
then
	echo "Resolved address is: $resolved_ip"
	echo "SUCCESS -----> Domain $targ_dom resolves properly."
else
	echo "FAILED -----> Domain $targ_dom does not resolve."
	exit 1
fi

