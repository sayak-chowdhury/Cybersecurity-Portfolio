#!/bin/bash

# =============================================
# Script Name: phase-7.sh
# Purpose: Create and use reusable functions
# Usage: ./phase-7.sh
# =============================================


# ==================
# Global Variables
# ==================

Report_Dir="$HOME/scripts/reports"
Timestamp="$(date +%Y%m%d_%H%M%S)"


#1.-----Print Banner Function-----

print_banner() {
	echo "=================================================="
	echo "		Phase 7: Reusable Functions		"
	echo "=================================================="
}


#2.-----Check Tool Availability Function-----

check_tool(){
	local tool="$1"
	if command -v "$tool" &> /dev/null
	then
		echo "[+] Tool $tool is installed"
		return 0
	else
		echo "[-] Tool $tool is not installed"
		return 1
	fi
}


#3.-----Check Host Reachability Function-----

check_host(){
	local target="$1"
	echo "[*] Checking reachability for host: $target"
	if ping -c 1 -W 2 "$target" &> /dev/null
	then
		echo "[+] Host $target is reachable"
		return 0
	else
		echo "[-] Host $target is not reachable"
		return 1
	fi
}


#4.-----Scan Ports Function (Using native Bash /dev/tcp)-----
# /dev/tcp/host/port -> Native Bash TCP socket test; returns exit status 0 if open, non-zero if closed
# shift: Shifts positional arguments left by 1 position, removing $1 (target) so $@ now contains only the remaining port numbers.
# local ports=("$@"): Captures all remaining arguments into a Bash array named ports.

scan_ports(){
	local target="$1"
	shift
	local ports=("$@")

	echo "[*] Scanning $target on ports: ${ports[*]}...."
	for port in "${ports[@]}"
	do
		(echo > "/dev/tcp/$target/$port") &> /dev/null && echo "[+] Port $port is OPEN...." || echo "[-] Port $port is CLOSED...."
	done
}


#5.----Enumerate Domain DNS Records Function----
# +short: outputs clean results

enumerate_domain(){
	local domain="$1"

	echo "[*] Enumerating DNS records for domain: $domain..."
	if command -v dig &> /dev/null
	then
		echo "--- A Records (IPs) ---"
		dig +short "$domain" A | sed 's/^/   /'
		echo "--- MX Records (Mail) ---"
		dig +short "$domain" MX | sed 's/^/   /'
		echo "--- NS Records (NameServers) ---"
		dig +short "$domain" NS | sed 's/^/   /'
	else
		echo "[-] 'dig' command not available for DNS lookup."
	fi
}


#6.----Save Report Function----

save_report(){
	local content="$1"
	local target="$2"

	mkdir -p "$Report_Dir"
	local filename="$Report_Dir/recon_${target}_${Timestamp}.txt"

	echo -e "$content" > "$filename"

	echo "[+]Report saved successfully to: $filename"
}


#-----Main Execution Logic-----

main(){
	print_banner

	#1.-----Interactive Input Collection-----
	echo -e "\n[+] Target Configuration Setup"

	# Prompt for Target Host / IP (with default 127.0.0.1)
	read -p "Enter Target IP/Host [default: 127.0.0.1]: " Target_Host
	Target_Host=${Target_Host:-"127.0.0.1"}

	# Prompt for Target Domain (with default example.com)
	read -p "Enter Target Domain [default: example.com]: " Target_Domain
	Target_Domain=${Target_Domain:-"example.com"}

	# Prompt for Ports (space-separated input)
	read -p "Enter Ports to scan (space-separated) [default: 22 80 443 8080]: " Ports_Input
	Ports_Input=${Ports_Input:-"22 80 443 8080"}

	# read -r -a ARRAY <<< "$STRING" -> Converts a space-separated string into a Bash array without interpreting backslashes
	# -r (Raw input): Disables backslash escaping. It ensures that backslashes (\) inside the input string are treated as literal characters rather tha 		escape characters.
	# -a PORTS_TO_SCAN (Array assignment): Tells read to split the incoming text (by default spaces/tabs) and store each piece as an individual element 		in an array named PORTS_TO_SCAN.
	# <<< "$PORTS_INPUT" (Here-String): The <<< operator feeds the contents of the variable $PORTS_INPUT directly into the standard input (stdin) of the		read command.

	read -r -a Ports_to_Scan <<< "$Ports_Input"

	# 2.-----Start Execution Sequence-----
    echo -e "\n=================================================="
    echo " Starting Recon on Target: $Target_Host ($Target_Domain)"
    echo "=================================================="

    echo -e "\n---STEP 1: Checking required tools---"
    check_tool "ping"
    check_tool "dig"

    echo -e "\n---STEP 2: Host Reachability---"
    check_host "$Target_Host"

    echo -e "\n---STEP 3: Port Scanning---"
    scan_ports "$Target_Host" "${Ports_to_Scan[@]}"

    echo -e "\n---STEP 4: Domain Enumeration---"
    enumerate_domain "$Target_Domain"

    echo -e "\n---STEP 5: Saving Scan Summary---"
    local REPORT_DATA="=== RECON SUMMARY REPORT ===\nTarget Host: $Target_Host\nDomain: $Target_Domain\nScanned Ports: ${Ports_to_Scan[*]}\nScan Date: $(date)"
    save_report "$REPORT_DATA" "$Target_Host"
}

#----Execute main function----
main

