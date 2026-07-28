#!/bin/bash

#==================================================================================================
#Script Name: phase-2.sh
#Purpose: Validating condition using if-else, creating output directory and storing automatically
#Usage: ./phase-2.sh
#==================================================================================================

echo "==========================================="
echo "|  Phase-2: PENTESTING LOG CONFIGURATION  |"
echo "==========================================="

#----Gather user input & input validation

#1. Target IP

read -p "[?] Enter Target IP Address: " Targ_IP
if [[ -z "$Targ_IP" ]]
then
	echo "!!!!ERROR!!!!--> Target IP cannot be empty"
	exit 1
fi

#2. Target Domain

read -p "[?] Enter Target domain: " Targ_dom
if [[ -z "$Targ_dom" ]]
then
	echo "!!!!ERROR!!!!--> Target Domain cannot be empty"
	exit 1
fi

#3. Output Directory

read -p "[?] Enter output directory (e.g.- ~/scans): " Out_dir
if [[ -z "$Out_dir" ]]
then
	echo "!!!!ERROR!!!!--> Output directory cannot be empty"
	exit 1
fi

#4. Scan Name

read -p "[?] Enter scan name (e.g.- NMAP_INITIAL): " Scan_name
if [[ -z "$Scan_name" ]]
then
	echo "!!!!ERROR!!!!--> Scan name cannot be empty"
	exit 1
fi

#----Make the directory automatically if it does not exists
#----Tilde(~) can fail sometimes inside a variable, so we need to evaluate it

Real_dir="${Out_dir/#\~/$HOME}"

echo -e "\n[*] Setting up environment....."
mkdir -p  "$Real_dir"

#----Store Scan details into a log file
LOG_file="$Real_dir/${Scan_name}_config.log"

{
	echo "====PENTEST CONFIGURATION LOG===="
	echo "Timestamp: $(date)"
	echo "Target IP: $Targ_IP"
	echo "Target Domain: $Targ_dom"
	echo "Output Directory: $Out_dir"
	echo "Scan Name: $Scan_name"
	echo "================================="
} >> "$LOG_file"

echo "[?] SUCCESS --> Configuration stored at ---> $LOG_file"

